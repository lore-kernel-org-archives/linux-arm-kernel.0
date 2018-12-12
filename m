Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28031C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:48:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F112084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QQng/lga";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="G0o70xBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F112084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5jFDJcXgTX+vx0Dkso4p+As/5mg3wRl5auXU73WNKrM=; b=QQng/lga9DKJqk
	Q0EMMDykf5sDhdgVTzEe+2Mm5FNp9kX8xKiNzGKJ+SSGHpf22b2/pVSnr3nQ1Owc1DVXcuC8O0tTZ
	kXoH5jArmbu5yFF8z00qpgP31MB65va+xgcl73w+eiYMpC+PTvCG/ngdX2fFpJvWH7RKl2DrWaf9l
	Qpy+xN3Yq7JO16UFB9nHTPTfp5H42/et9EkP5YbKSjzAK44kSlS+XyqR9zxvc2Eauw7d5iiZFXzKv
	sSTtyu9H9tuX2mdyUJu8uAnKB1varwWfxKAiXr+Mw7/DdnGNA1puZ4pjFXZcJEnuo6dAYJ2nxy1p+
	/j6Lmi20KAuspmiqGXUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX18F-0001X5-Hj; Wed, 12 Dec 2018 09:48:43 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX18B-0001WF-Mf
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 09:48:41 +0000
Received: by mail-wr1-x442.google.com with SMTP id t27so16968383wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 01:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ulT+9TIIL/Iv54rGhUuxFd8w1T5Iu1luyYHYRVopoFY=;
 b=G0o70xBXob8K5BcOy0Jt4alQZy69UWKxjF5WXyegtRgkYyKNfhZ7f/wwyTnEhM+kO/
 KgxQ24I120kfgomXTvHiqmyHbm0yPEiDMX0JwVnov1BTvvlm24hglQUwNrezYd36RsPZ
 q98Aq2iZY+q1lyVhQlI+fnvbLyZDzKWR8gOVynpfpNcN7Px3LivGrlS8/NwyM3oFMxZJ
 LMw88mCfrCWEBkZDAyz8rOHFcsvYOfue6S62tCAQbmSYQglcfvntp/0kQNkk6S3ZUlOx
 dmtHpUXwoM+FDMDwKbT865gVd0e56zw1spwX5GHLeSy02V4HRxtHaK+wZWwNoVWYj2pX
 He/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :organization:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ulT+9TIIL/Iv54rGhUuxFd8w1T5Iu1luyYHYRVopoFY=;
 b=Tym5/V2D/Z6AGf3KaL+kWRhLR5hbtVk+zDhE0NJWhUijYg7iKzJCOCTP4ljZtrxgP4
 PB8Afr5MJC00nq2NUD5nC7asxMfp8mrKVvLMEibdsUy3mMrtYxVyq4nIrsshyqrRefOQ
 Hp7rBvSUl1aYZeAOc2cf/QA3UjZySylUKGj2Q3SNZQjup2VhGieVkyKm5RLMLRMDlJ1S
 WCjqGxxe2uBK3zpcFOomirDZ1N/DMGNc61mtO+AxYFUtDsAz40aGLL+wN4aspFjDd+vA
 sPOMIHkHfuKBHJqixbwEIuRO/r1l1zDTScC7W1hpbh4eAL2HwJTVUpNjJNs+39NrltV0
 ysWg==
X-Gm-Message-State: AA+aEWb1Ud4Y7NW41bGQk1H0w3xvdEmceYPz1RYItMMnqIvOuMxLnqSy
 zIgkr9estjEjLHMBcHYncf/+k6e549sCdg==
X-Google-Smtp-Source: AFSGD/XUT4DoOy4B4s0AbceTORfHVH0jefDzn2WuptmiABcGmVJscxASDR1C10rW/Y2pzMbAGmGuBQ==
X-Received: by 2002:a5d:4f10:: with SMTP id c16mr17331440wru.177.1544608107631; 
 Wed, 12 Dec 2018 01:48:27 -0800 (PST)
Received: from [10.1.3.173] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id o9sm1924479wmh.3.2018.12.12.01.48.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Dec 2018 01:48:26 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: gpu: mali-midgard: Add resets property
To: Rob Herring <robh@kernel.org>
References: <20181210132227.29262-1-narmstrong@baylibre.com>
 <20181210132227.29262-2-narmstrong@baylibre.com>
 <CAL_JsqK9nDaOOe3yjHAdaH92ds=_cudbq-wQee+YBPaCHEE-HQ@mail.gmail.com>
From: Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT7CwHsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIXOwE0ETVkGzwEIALyKDN/O
 GURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYpQTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXM
 coJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hi
 SvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY4yG6xI99NIPEVE9lNBXBKIlewIyVlkOa
 YvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoMMtsyw18YoX9BqMFInxqYQQ3j/HpVgTSv
 mo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUXoUk33HEAEQEAAcLAXwQYAQIACQUCTVkG
 zwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfnM7IbRuiSZS1unlySUVYu3SD6YBYnNi3G
 5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa33eDIHu/zr1HMKErm+2SD6PO9umRef8V8
 2o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCSKmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+
 RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJ
 C3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTTQbM0WUIBIcGmq38+OgUsMYu4NzLu7uZF
 Acmp6h8g
Organization: Baylibre
Message-ID: <de78b995-59a2-99b2-b47f-44275964cb0c@baylibre.com>
Date: Wed, 12 Dec 2018 10:48:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK9nDaOOe3yjHAdaH92ds=_cudbq-wQee+YBPaCHEE-HQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_014839_881570_47D613F3 
X-CRM114-Status: GOOD (  19.59  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, linux-amlogic@lists.infradead.org,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 11/12/2018 17:58, Rob Herring wrote:
> On Mon, Dec 10, 2018 at 7:22 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> The Amlogic ARM Mali Midgard requires reset controls to power on and
>> software reset the GPU, adds these as optional in the bindings.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
>> index 18a2cde2e5f3..24d83ec952f1 100644
>> --- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
>> @@ -37,6 +37,8 @@ Optional properties:
>>  - operating-points-v2 : Refer to Documentation/devicetree/bindings/opp/opp.txt
>>    for details.
>>
>> +- resets : Phandle to the reset controls for the Mali Midgard device.
> 
> How many? Sounds like 1, but the dts has 2. There's also a similar
> patch for Allwinner[1]. I don't want to see a different number of
> resets and different names for each vendor. So first figure out how
> many resets the IP block has. You'll have to find someone with access
> to the TRM.

I can answer for Amlogic, they have a reset for the bus interface and the GPU IP itself.

You are asking something impossible ;-) We can assume it has a single reset interface,
but vendors can add more to reset some glue HW. So we will need some variant per-vendor,
sorry to annoy you !

Neil

> 
> Rob
> 
> [1] https://patchwork.ozlabs.org/patch/1003654/
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
