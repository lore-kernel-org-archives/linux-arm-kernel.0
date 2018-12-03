Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435C4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 00:41:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0302B208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 00:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UQyk7QHp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvCs/Hfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0302B208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DuqHkVn3Nu+3/0PsMc3rpuLqqfoSQCGkC3NpdUwAtws=; b=UQyk7QHpYrMBdI
	RUnvUQqmgEQn9+9Na/eGyBFhuX/4Rn5DFlRRTFm/vxKev2z8XN7xzpFm/0ivuYU00v9sdVgnddWFs
	tfLRjHG/JN6ky9D7cY3pbHrlFvqr/osE0x5JRUhM3IixfK5I7p+1f2vuDNXL1LRqbd62WJVuGcXJi
	AJ7IdVS4a+/O441U2SNsO8Wr1FoM3c9P6liDoJNNtiFZYV64oEQJ76fB4B0QhzEZVlZACfKVsLNUv
	qgGCDz9t4kp8IVP2q/+x7T4ylQxdVuZZTsY2R3aDSbzWxq2Y3Kp5m2OELraq44k7a4l9stOXHvBTt
	wjWLAe4vNodH23iKEmcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTcJB-0001c5-Jm; Mon, 03 Dec 2018 00:41:57 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTcJ7-0001bB-QQ; Mon, 03 Dec 2018 00:41:55 +0000
Received: by mail-wm1-x336.google.com with SMTP id n190so1548000wmd.0;
 Sun, 02 Dec 2018 16:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sbJqiDoCNG1jpiM/jk/6p5/Bg/Yy9zN2uS+g9N6XNj4=;
 b=JvCs/Hfh9KC1glwMUW4rQ/BJRI7U4wrHB8EYmhon2rebT9U7CdL5VvqdCnaF01j6eq
 YnUGYgfOtdBJnFWQE+l67Ur7mkbSAWvK6vHL3umpaRH6WMF9bfJEzbKBJDhpWL4CMtt+
 wiw3QwmEPPnKe4WWA+HfKvOsgqGcMkWF+R+NOcnEjdVkOCJ8THIFqI/PmI8U6+vUshVt
 QNEH9d/PtY0KAqls3yWXPOiroi9EpUeNlpiAGV+H8PCc31KJAjjeZ6t4Xn1nW/9NNrMy
 qQPjDUlNcIawjX3wQgiVaigTrD9r9LMeQZYlchvc56GwqEtvmVe7diTgjeewf8DvLNik
 C8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=sbJqiDoCNG1jpiM/jk/6p5/Bg/Yy9zN2uS+g9N6XNj4=;
 b=iJiVS3FoxQI8RNpYlGV2tF8wJbpyNfgmj8Vqhj5OB77bdCrK3NYmFy0PQo13Re8L17
 wGGvDSamG9Tg2EcqGGoBzHAl7aeS1afGXpGGJFPJ5sUDfTII2MgyEbmQYwPJwygb9hPN
 SAZhdfxKDPfxp1MRuFXbmB/BZfaL9g8D5QGFo6/7dYWczc4HJDwtp1QCMNEd5RitYkwa
 sBgXUp2HSCKDtbvsVjum6aUOI/rCk5Hqjvx1+0YIecOeVO6oX+vGaYZ5MykdH96IhbIf
 pOKiV58gVTNrJSOJZ8C/dkJkxfzi6tNddJ5lSh3uAKNi7y88Ll19U8xN9jt4YI8kKHZN
 c9Bw==
X-Gm-Message-State: AA+aEWbHK9Gozx7J19PTKylB+wXggU0k4eEoJK35GHvD4YcTCpcTe7LT
 +lFH93lYXGEFR4CpK3bkYtuyngSq9+4=
X-Google-Smtp-Source: AFSGD/X1q/JE5xq1DMoSehvOPSiWNy/ISezLqirOflmXxkoyrsIf3KAdcfzF6pnSB0DlGgCn2ACThw==
X-Received: by 2002:a1c:af08:: with SMTP id y8mr4831751wme.94.1543797701930;
 Sun, 02 Dec 2018 16:41:41 -0800 (PST)
Received: from ziggy.stardust ([93.176.147.153])
 by smtp.gmail.com with ESMTPSA id q3sm9939205wrn.84.2018.12.02.16.41.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 02 Dec 2018 16:41:41 -0800 (PST)
Subject: Re: [GIT PULL] arm: mediatek: DT fixes for v4.20
To: Olof Johansson <olof@lixom.net>
References: <d131fdd3-663c-9a5b-4296-94f2635f8c41@gmail.com>
 <5e3371a7-e4a3-49cc-b517-20902a5e2ed4@gmail.com>
 <CAOesGMimqGGL+3Dd8tyyJpb506j9-tJZP0FeSCkvKwuUGWAmAg@mail.gmail.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <e10b0801-ffd0-0850-6346-c12a32afb920@gmail.com>
Date: Mon, 3 Dec 2018 01:41:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAOesGMimqGGL+3Dd8tyyJpb506j9-tJZP0FeSCkvKwuUGWAmAg@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_164153_875779_D268D622 
X-CRM114-Status: GOOD (  18.91  )
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
Cc: ARM-SoC Maintainers <arm@kernel.org>,
 "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>,
 Ryder Lee <ryder.lee@mediatek.com>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 02/12/2018 21:01, Olof Johansson wrote:
> On Sun, Dec 2, 2018 at 11:57 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>>
>> Hi all,
>>
>> On 26/11/2018 11:34, Matthias Brugger wrote:
>>> Hi Olof,
>>> Hi Arnd,
>>>
>>> There two issues with the mt7622 based boards in the current v4.20-rc cycle.
>>> Could you please pull the following fixes for the issues.
>>>
>>> Thanks,
>>> Matthias
>>
>> I just saw, that this is not part of armsoc-fixes [1]
>> Does it fall through the cracks or are there any comments?
> 
> Hi,
> 
> I pinged you on IRC, which I'm guessing you didn't see.

Sorry, I just realized.

> 
> Your branch was based on -rc3 when the rest of fixes were on -rc1 for
> this cycle. I asked if I could cherry-pick, but in the end I decided
> to send what we have and just merge it once Linus picks it up (since
> the new branch would be based on -rc4 or 5). So, it's on the list and
> I'll merge it later today or tomorrow.
> 

Ok, great. If you want me to prepare a branch based on a different rc, just let
me know.

Thanks,
Matthias

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
