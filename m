Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC71C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:59:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE2D20842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qjLrpOqX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DEyveKSv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9gjqnJJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE2D20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FEusP9AdMcTM0mKUimSvTPV9qAPnsHEo6//+fgmj91E=; b=qjLrpOqX7Mz+ay75E0fPEfiMa
	ji440mMNaRaU02F2vymfbkqlwV6DYyKyQXWV4pQJIPfJWp+IiivczImhfRJtUreK2uN3pXqC5S7hX
	YKYDDWv9UWK3JkwekhSzkyeIEIPZdqyn6WKiRu0uNJOuOdGiJckIiWjTdmhXzBovntHIyNqOQZs2h
	kcfx15NPGD9l4Qca4vYzuJ0hFQ0eZiHXTT5GCFMRVXKh3VMNJc2jOpjB5I4gaXI0whFb7CLSHd+cK
	pH7D5cnS72vrxJHvdu7nZaiDONQy53OeNBJbvUekG8AS37d878Fk3OqRaghBNrZQ0IeE44TEMw5h3
	YonMzKmog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyNLA-0004ey-V6; Mon, 25 Feb 2019 20:59:08 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyNL9-0004er-4E
 for linux-arm-kernel@bombadil.infradead.org; Mon, 25 Feb 2019 20:59:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OlMfOERKozt0qCMopgmfdQ2h0YOTELN011HcmqzEV9s=; b=DEyveKSvyAF/BBL1rz/ZLfqzfE
 1W27igPqV70DoIrOG60F6EALuQ9sjhik21JVUNLOsfWVBvmrZR+xDASm511r7wNVrxl67y10QdeOV
 taAljBaeB7yBryXAuAoTAaS1yafNjLlP3sB3AGIK1XXVRzfwQyZQ2lASJT+igPWkayT6xnvuiilRM
 73zC4GDED6oI9/ZFF7LtY9aTt1ixLeUoXPvnilnJEhFPnvuUAHECrr7nYBXyPRl0i590gfHJblNpU
 xrMOohJsmgqpGSHpyEfAQWm9AXeqexDdPRYlP1Q2tg7gHXNxN9rwWjqPbrxViFQbSGgLsMdgHoXXO
 iutIADxg==;
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyN2d-0001xH-3G
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 20:40:00 +0000
Received: by mail-wm1-x331.google.com with SMTP id n19so291666wmi.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 12:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OlMfOERKozt0qCMopgmfdQ2h0YOTELN011HcmqzEV9s=;
 b=o9gjqnJJZ7PyKFRd/AhbVmlk0ALQg6hynrw1/yZPSPoeUI/0ZgcIInuEWdt/Ws3stV
 IpXDfvus0eNTR20XuIJ0D1kS4a5QKEfcVua57JaAMNClSwUlheQsAIIPB8UrP5+e7zEu
 6DgFn3Oc8Sa/gFKBIeCmku4UvtVXKxBVMc1aFhAz9eqPjpJ1qSKE6s5YoxCo1k3IiUMg
 Rmy62U77zPIICGnLkOcTks5jgYkaSFYDz/EyezLTbylcDij50GZ+iAjrFukRbPO3rSVL
 zoDQZ2xT/KXPDkK5YzHLaGEtnFFb3aAepxd3QDbLsA8asTAmf45Mr9GCo1N+iAXXUu+a
 7NKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OlMfOERKozt0qCMopgmfdQ2h0YOTELN011HcmqzEV9s=;
 b=BCRM6t+1hXbi4cGST7kQI9vSDQcimcGaZkCCZeoSJY4Yzpg1JAEGPPvtWENhTBzKKC
 dQ1wVGloSGmgy6eyGDeHv3nWW2/UYPRHwRLQp7whn75LYJqel0osWIc8BAG1F+7McY2M
 qO7V+ZZOymPn4h8n8UMel9cb+S9gJRiionlPtX9LGVaoE9BEc/MlxXgtYviEZaealUFs
 hXEf9tYsQzWb1wr3HhlPWvWwUX8ItCL7551/fUjZLYDBabLAdUAZ4fRnJZvpjw8/3z+g
 dDdn03z7a8r2i6yFeaDQ9HAvXrGoEjox+/h/+/d0nAI87ZL34ZUBBc5Fx9G2OItH0EIr
 8eDw==
X-Gm-Message-State: AHQUAuYIKFocfA/oWdarRe2kKh0PJ8kRIlxDKLv8rW1N18Pg4b8zdNsj
 W7qItRpJxeuY/Ot2dZmglIfzqtco
X-Google-Smtp-Source: AHgI3Iat2Vez/Yw8eQjcbBw0HXd/LW7bK4USr5BGZCbAyMoNRDQPiRHrX4XxQBKhmocYaD3FGT4uqw==
X-Received: by 2002:a1c:30b:: with SMTP id 11mr380532wmd.110.1551127077093;
 Mon, 25 Feb 2019 12:37:57 -0800 (PST)
Received: from ?IPv6:2a02:810d:340:17ec::1b62? ([2a02:810d:340:17ec::1b62])
 by smtp.gmail.com with ESMTPSA id v6sm13268375wrd.88.2019.02.25.12.37.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 12:37:56 -0800 (PST)
Subject: Re: Allwinner SID THS calibration data cell representation?
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-28-embed3d@gmail.com>
 <20180904184623.e4386b8e6b657b1b25e90c09@bidouilliste.com>
 <55579dd6-625d-e71b-1482-4592dccac665@gmail.com>
 <20180906115114.inc6dhqhy47obo25@flea>
 <CAGb2v65p0G83BVODsxxnXmiSCwuuwPFtY2k2ZV1F5xoFKrJjWQ@mail.gmail.com>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <dfbe9a71-ccab-2415-fe5b-6944df721bff@gmail.com>
Date: Mon, 25 Feb 2019 21:37:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAGb2v65p0G83BVODsxxnXmiSCwuuwPFtY2k2ZV1F5xoFKrJjWQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_203959_189381_6E28625B 
X-CRM114-Status: GOOD (  24.95  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Emmanuel Vadot <manu@bidouilliste.com>,
 Quentin Schulz <quentin.schulz@bootlin.com>, linux-iio@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Jonathan Cameron <jic23@kernel.org>, Icenowy Zheng <icenowy@aosc.io>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 19.02.19 08:54, Chen-Yu Tsai wrote:
> Sorry for resurrecting an old discussion, but since someone posted patches
> for H5 and H6, I thought we should resolve this. I'm working on patches to
> fix / replace the big-endian issue.
> 
> On Thu, Sep 6, 2018 at 7:51 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>>
>> On Thu, Sep 06, 2018 at 01:47:47PM +0200, Philipp Rossak wrote:
>>> On 04.09.2018 18:46, Emmanuel Vadot wrote:
>>>>> +                 /* Data cells */
>>>>> +                 thermal_calibration: calib@234 {
>>>>> +                         reg = <0x234 0x8>;
>>>>> +                 };
>>>>    You are declaring 8 bytes of calibration data but to my knowledge it's
>>>> only 2 bytes per sensor, so 2 bytes for H3.
>>>>    Am I missing something ?
>>>>
>>>>    Thanks,
>>>
>>> Emmanuel you are right, it is 2 bytes per Sensor and should be 2 bytes for
>>> H3, but the thermal calibration data field is on all chips 64 bit wide - so
>>> 8 bytes. So I'm reading here the complete calibration data field.
>>
>> Having one cell per channel would make more sense I guess.
> 
> Would it? The 2 32-bit words directly map onto the registers 0x74 / 0x78 in
> the THS. As far as the SID is concerned, their is just one consumer for this
> data, the thermal sensor. How the thermal sensor uses that data is really not
> its concern. And the thermal sensor is really just copying the data from the
> e-fuses into its registers. Nothing more.

Using 2 32-bit words for the THS would be also ok (from my perspective).
> 
> Furthermore, with the register access interface, the e-fuses are read/write
> 32 bits at a time. Seems to me it would make more sense to enforce a 32-bit
> word size, so cells should be multiples of 32 bits.
> 
For THS I'm ok with that.

> Regards
> ChenYu
> 
Regards,
Philipp

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
