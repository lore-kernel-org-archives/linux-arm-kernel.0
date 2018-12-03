Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97802C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:06:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63A952087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZOD93nSk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="G9YqCu5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A952087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tdrt0dhrLNXiYrC749gXcURySfbKYqZTnehcLz0cO3A=; b=ZOD93nSk7yje2E
	L+MFyWR3BmEh8InymLlj4TjakyORUu9v1C4QWipFL2nlk5v1BF2OOMhm6aCzQNfQx89pgwxGvg65O
	ZfrMBOChbh+QWgQHmPJl1awBlpeEEyGdXUaC8BqQQ4ibb1xMGID6Zeine6rbP/9oK5G0yjSi76mZk
	2/9Iht33eTbIhXHBgZHiuImGaSmNi7p7drzSiijd7VDZ9DIFXKVIC8qpyAR6yGzJaItjRTBAZX0fF
	0QL2zUo+qTK5FheGup9ONe3GpbpkCkO2w4DJyPj7r6jHlOZ/qcClFQQgA7KSX6WI3XzC84mmehkn1
	7/0fcdea3YoQJdHtRIQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTl7u-0000hp-EQ; Mon, 03 Dec 2018 10:06:54 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTl7p-0000g7-CK
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:06:51 +0000
Received: by mail-wm1-x344.google.com with SMTP id y139so5059826wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 02:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=F++MSDZ9NwcbKE28yth3o0igpRm9LeO2TCIWU6MMa3Y=;
 b=G9YqCu5CkkFpSFaHoDGjwYuuZMEgnI4ZC00EUXS6IHhydHAqvxD64lye5ySwgJE1oo
 5aPcQ84gSDEQr52s0vWoTTNAeifUo/jEd+9UZp944OXAWRi8vrQRIVmTpfYxSNkD6sFG
 ojLZ5qQhhCEEWqHPUxsBskOr+mxGPiJX87x5vA7Uuky1oPUk4AGFw67HQqkrvvECw3V+
 NHEtTFk4U15rmyNBzMBJ4PEZwmZYBwOyeaME5PPRK37eNcHT4bxT7z+T7MgIrztYxKFa
 pbjclWozHOI3s6FLh81I4IHenfAjrZNm15qdAFWmcAAZW4NFtiQKjY1CX/zWcaaCnUVr
 qsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :organization:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=F++MSDZ9NwcbKE28yth3o0igpRm9LeO2TCIWU6MMa3Y=;
 b=rSwUaBX7gWfsHvCTglm0GkyjBDpXD2qQc91RvedfWnVPFGTiyYJx+eQyJtsjvgQE09
 5yC+1mkXS7+I4H1CNWhamQi4aSQqXbdRLy44NslBaSjFtzFqhQKdq5G0Hth3MwFDS0rZ
 sieWRmyePQjiDPizW4B8XicdIvy/kq6IigkIjU4aIhW6NYeMDyngCc8paBNHUJUrL/0I
 ngOOk2KjKeb2Eg2qVqthxIDbzvOAkt1dGSmsMurgpQp+z2r/VzGN7+ETEEgfnS42gr5f
 qSwI3XFVy0GKg7h7Vk/jgG2/7RPcAWXq2LZFpdHe2BEdkxbOCcOjf8O75bpwjG+QWobF
 5Eyw==
X-Gm-Message-State: AA+aEWZ6f+QaRXp0GmSVHJ02N45dNB6yhvb1z90weWliCcKeuwe6Wg3n
 KlXEIr6ILcvHZwVJXV3we66/xw==
X-Google-Smtp-Source: AFSGD/W4YNU//GtRZXwhqgCiSVEmKzMsZiRv4yL9RScZhBVu705tInPibS9IeDvdqvKilrhLCeTRJQ==
X-Received: by 2002:a1c:ce0e:: with SMTP id e14mr8106488wmg.53.1543831597318; 
 Mon, 03 Dec 2018 02:06:37 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id y138sm6091647wmc.16.2018.12.03.02.06.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 02:06:36 -0800 (PST)
Subject: Re: [PATCH 2/2] irqchip/meson-gpio: Add support for Meson-G12A SoC
To: Xingyu Chen <xingyu.chen@amlogic.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>,
 Kevin Hilman <khilman@baylibre.com>
References: <20181203061324.36248-1-xingyu.chen@amlogic.com>
 <20181203061324.36248-3-xingyu.chen@amlogic.com>
 <7a2f88d849ada782de6e27676518d0b9897e30e7.camel@baylibre.com>
 <dc42e7df-a3de-7323-177f-56a08564fb60@amlogic.com>
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
Message-ID: <4fc0694c-4c00-5abd-5336-ef85ad36d9b5@baylibre.com>
Date: Mon, 3 Dec 2018 11:06:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <dc42e7df-a3de-7323-177f-56a08564fb60@amlogic.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_020649_421196_3B405A79 
X-CRM114-Status: GOOD (  20.20  )
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
Cc: Rob Herring <robh@kernel.org>, Jianxin Pan <jianxin.pan@amlogic.com>,
 linux-kernel@vger.kernel.org, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMDMvMTIvMjAxOCAxMDoyOCwgWGluZ3l1IENoZW4gd3JvdGU6Cj4gCj4gCj4gT24gMjAxOC8x
Mi8zIDE3OjE5LCBKZXJvbWUgQnJ1bmV0IHdyb3RlOgo+PiBPbiBNb24sIDIwMTgtMTItMDMgYXQg
MTQ6MTMgKzA4MDAsIFhpbmd5dSBDaGVuIHdyb3RlOgo+Pj4gVGhlIE1lc29uLUcxMkEgU29DIHVz
ZXMgdGhlIHNhbWUgR1BJTyBpbnRlcnJ1cHQgY29udHJvbGxlciBJUCBibG9jayBhcyB0aGUKPj4+
IG90aGVyIE1lc29uIFNvQ3MsIEEgdG90bGUgb2YgMTAwIHBpbnMgY2FuIGJlIHNwaWVkIG9uLCB3
aGljaCBpcyB0aGUgc3VtIG9mOgo+Pj4KPj4+IC0gMjIzOjEwMCB1bmRlZmluZWQgKG5vIGludGVy
cnVwdCkKPj4+IC0gOTk6OTfCoMKgIDMgcGlucyBvbiBiYW5rIEdQSU9FCj4+PiAtIDk2Ojc3wqDC
oCAyMCBwaW5zIG9uIGJhbmsgR1BJT1gKPj4+IC0gNzY6NjHCoMKgIDE2IHBpbnMgb24gYmFuayBH
UElPQQo+Pj4gLSA2MDo1M8KgwqAgOCBwaW5zIG9uIGJhbmsgR1BJT0MKPj4+IC0gNTI6MzfCoMKg
IDE2IHBpbnMgb24gYmFuayBCT09UCj4+PiAtIDM2OjI4wqDCoCA5IHBpbnMgb24gYmFuayBHUElP
SAo+Pj4gLSAyNzoxMsKgwqAgMTYgcGlucyBvbiBiYW5rIEdQSU9aCj4+PiAtIDExOjDCoMKgwqAg
MTIgcGlucyBpbiB0aGUgQU8gZG9tYWluCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogWGluZ3l1IENo
ZW4gPHhpbmd5dS5jaGVuQGFtbG9naWMuY29tPgo+Pj4gU2lnbmVkLW9mZi1ieTogSmlhbnhpbiBQ
YW4gPGppYW54aW4ucGFuQGFtbG9naWMuY29tPgo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL2lycWNo
aXAvaXJxLW1lc29uLWdwaW8uYyB8IDUgKysrKysKPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKykKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pcnFjaGlwL2lycS1tZXNv
bi1ncGlvLmMgYi9kcml2ZXJzL2lycWNoaXAvaXJxLW1lc29uLQo+Pj4gZ3Bpby5jCj4+PiBpbmRl
eCA3YjUzMWZkMDc1YjguLjk3MWU4ZGVhMDY5YSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvaXJx
Y2hpcC9pcnEtbWVzb24tZ3Bpby5jCj4+PiArKysgYi9kcml2ZXJzL2lycWNoaXAvaXJxLW1lc29u
LWdwaW8uYwo+Pj4gQEAgLTY3LDEyICs2NywxNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG1lc29u
X2dwaW9faXJxX3BhcmFtcyBheGdfcGFyYW1zID0gewo+Pj4gwqDCoMKgwqDCoCAubnJfaHdpcnEg
PSAxMDAsCj4+PiDCoCB9Owo+Pj4gwqAgK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbWVzb25fZ3Bpb19p
cnFfcGFyYW1zIGcxMmFfcGFyYW1zID0gewo+Pj4gK8KgwqDCoCAubnJfaHdpcnEgPSAxMDAsCj4+
PiArfTsKPj4+ICsKPj4KPj4gU2FtZSBjb21tZW50IGFzIG9uIGkyYywgdGhlIGcxMiBzZWVtcyBj
b21wYXRpYmxlIHdpdGggdGhlIGF4Zy4KPj4gSXMgdGhpcyBwYXRjaHNldCBwYXRjaHNldCByZWFs
bHkgbmVjZXNzYXJ5ID8KPj4KPiBBbHRob3VnaCB0aGUgdG90YWwgbnVtYmVyIG9mIHBpbnMgaXMg
dGhlIHNhbWUgYXMgdGhlIE1lc29uLUFYRyBTb0MsIHRoZSBncGlvIGJhbmtzIGFuZCBpcnEgbnVt
YmVycyBhcmUgZGlmZmVyZW50LiBUbyBhdm9pZCBjb25mdXNpb24gb24gdXNlLCBpIHRoaW5rIHRo
ZSBuZXcgY29tcGF0aWJsZSBzdHJpbmcgaXMgbmVlZGVkLgoKT0sgZm9yIHRoZSBuZXcgY29tcGF0
aWJsZSwgYnV0IHlvdSBjYW4gcmUtdXNlIHRoZSBzYW1lIHN0cnVjdCBsaWtlIGZvciBpMmMuCgpO
ZWlsCgo+Pj4gwqAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbWVzb25faXJxX2dw
aW9fbWF0Y2hlc1tdID0gewo+Pj4gwqDCoMKgwqDCoCB7IC5jb21wYXRpYmxlID0gImFtbG9naWMs
bWVzb244LWdwaW8taW50YyIsIC5kYXRhID0gJm1lc29uOF9wYXJhbXMgfSwKPj4+IMKgwqDCoMKg
wqAgeyAuY29tcGF0aWJsZSA9ICJhbWxvZ2ljLG1lc29uOGItZ3Bpby1pbnRjIiwgLmRhdGEgPSAm
bWVzb244Yl9wYXJhbXMKPj4+IH0sCj4+PiDCoMKgwqDCoMKgIHsgLmNvbXBhdGlibGUgPSAiYW1s
b2dpYyxtZXNvbi1neGJiLWdwaW8taW50YyIsIC5kYXRhID0gJmd4YmJfcGFyYW1zCj4+PiB9LAo+
Pj4gwqDCoMKgwqDCoCB7IC5jb21wYXRpYmxlID0gImFtbG9naWMsbWVzb24tZ3hsLWdwaW8taW50
YyIsIC5kYXRhID0gJmd4bF9wYXJhbXMgfSwKPj4+IMKgwqDCoMKgwqAgeyAuY29tcGF0aWJsZSA9
ICJhbWxvZ2ljLG1lc29uLWF4Zy1ncGlvLWludGMiLCAuZGF0YSA9ICZheGdfcGFyYW1zIH0sCj4+
PiArwqDCoMKgIHsgLmNvbXBhdGlibGUgPSAiYW1sb2dpYyxtZXNvbi1nMTJhLWdwaW8taW50YyIs
IC5kYXRhID0gJmcxMmFfcGFyYW1zCj4+PiB9LAo+Pj4gwqDCoMKgwqDCoCB7IH0KPj4+IMKgIH07
Cj4+PiDCoCAKPj4KPj4KPj4gLgo+Pgo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4gbGludXgtYW1sb2dpYyBtYWlsaW5nIGxpc3QKPiBsaW51eC1h
bWxvZ2ljQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFtbG9naWMKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
