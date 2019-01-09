Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FC3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:49:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D270206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jhrzqc3Z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTSxkqtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D270206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wkCL4msqQZS1ys07q3rzDxysXHMMxQTuFVT1ePMpnkc=; b=jhrzqc3ZS4Q0E3
	xpSOnhVPAuqImpyiLXJHjJuG5HSFfPyPaKrAayWppLWASORKTnhcNb01KJkYzyIpGi/DlRH1+i5EA
	LeNjyf4kM1BgfB0+uEJ/cnihd82WDI2oc4Wv8wHFJA68JGNvv7utesKRaqwGOsu3Mjlh2V+/VSPJy
	a0tyVG1T5DpwNcZS7SKnNZex6elUSUHXdiePZhwKMW7pJJ/NiizHcoY+Bd15sAhSRLU1gXd99h522
	KtVxo0vefyqNvNwfZ73ZQIDPZtQBRqXGs79CpCO2sQEGh2Sz7RQu5OTbtkXyLDn6V/vYbgbhM1AtK
	FAiDT6tsJhHUu6CODwbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghDIb-0003zM-1j; Wed, 09 Jan 2019 12:49:33 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghDIY-0003yt-1A
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 12:49:31 +0000
Received: by mail-wm1-x344.google.com with SMTP id g67so8057344wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 04:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wcBNaca/Qk9n+SjvifhK9ulpTQ+WQ8/cjJpk1MT8KgM=;
 b=ZTSxkqtIJhN6+PVuW2LQYYcHnPNPwwoAi7hbBBnCsGHXDEi02FwiNR8LXeTig/7vzS
 5xEpiFBboYHQNWt7jIcbvJeF0ZSaabiVUh9Hr4aluowbp5ozbhjzO3KPuck2kPwmSNUV
 lSEG2HkLGKiweNfL6DrUU8MRv+aWrR9FZaXj77wNvOlBHogQ8ylxjaHXa2hzqBUdvHlv
 IsMygolaiGQbuRNltz9OczJclhH6UeUxRsj8NfUFAYv3vOtGYJx78XjAiMDgfHeHGrbz
 bVX5ycFeFjyx+IQsubuOcm2QBRgkRa7/bqkeOo2Ru9OsRM4uVkp0Kc9KWOihx1BPOOZe
 gNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wcBNaca/Qk9n+SjvifhK9ulpTQ+WQ8/cjJpk1MT8KgM=;
 b=VFmfErQbBDY9Um2rHmMAlru02DBCw07sH06mscZRLPZiwFE+frzHq7OE0dnZ4cw+RK
 ZzVYWPzbct//N7taLx1R3HUSHlhhI/tRcOfaKWCclAczkEYm7xwxOCVm6+erPXERSCxR
 WvEaNNk8auTBLtXx2d1+dbjvPJ9Jue7/V08P932EEzDSTjfM0+bm1p9mGofdEVnQi6Cc
 zRrBd4mQStBVEm41eE+09xoMNR9LPv31klE+f5ZAr3e6I19dyv9dZDksCFEdGDErm5yH
 OspBDRlH6MfM8kN65Nu/of1FqEdLWaPDaEZhcYvR0/9/F9EPfzV7ne5gD/q4nykKoPuD
 q2cQ==
X-Gm-Message-State: AJcUukdOp9Y2Gqj69Qyj/GAmiamD2w1AbhV2YwsMG36KgttwXtTpUqjJ
 Hr5crXLP7vlpn5LvFEEY8/7gnDsa
X-Google-Smtp-Source: ALg8bN53Z4R0vZ855AmaXyWpO6kizzx6sQjIoej6vMUXiHmVSISC1WbO0nOtTjKqpzGv+5SsQXcSLQ==
X-Received: by 2002:a1c:bd86:: with SMTP id n128mr5469410wmf.22.1547038167785; 
 Wed, 09 Jan 2019 04:49:27 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz.
 [86.49.110.70])
 by smtp.gmail.com with ESMTPSA id n82sm13510377wma.42.2019.01.09.04.49.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jan 2019 04:49:27 -0800 (PST)
Subject: Re: [PATCH V3] arm64: dts: r8a77990: ebisu: Add and enable SDHI
 device nodes
To: Simon Horman <horms@verge.net.au>
References: <20181106204647.18051-1-marek.vasut+renesas@gmail.com>
 <20190109104922.z6g772vgncdqqbqt@verge.net.au>
 <20190109105754.vvqx6uvsktvxeq7a@ninjato>
 <34cd1769-f0c9-0c2b-8947-4fceca9a9fb2@gmail.com>
 <20190109123259.cpql62omcvypafdu@verge.net.au>
From: Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <a77e5b5c-fb77-3180-b382-0654eaf7b2a9@gmail.com>
Date: Wed, 9 Jan 2019 13:49:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190109123259.cpql62omcvypafdu@verge.net.au>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_044930_098800_D3B930FF 
X-CRM114-Status: GOOD (  14.87  )
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
Cc: devicetree@vger.kernel.org, Takeshi Kihara <takeshi.kihara.df@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@the-dreams.de>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/9/19 1:32 PM, Simon Horman wrote:
> On Wed, Jan 09, 2019 at 01:02:00PM +0100, Marek Vasut wrote:
>> On 1/9/19 11:57 AM, Wolfram Sang wrote:
>>>> [    3.373714] renesas_sdhi_internal_dmac ee100000.sd: mmc0 base at 0xee100000 max clock rate 200 MHz
>>>> [    3.456829] renesas_sdhi_internal_dmac ee120000.sd: mmc1 base at 0xee120000 max clock rate 200 MHz
>>>
>>> No mmc2 initialized. That should work regardless of eMMC. Probably
>>> something wrong in the DT somewhere.
>>
>> Weird, it worked in next-20181102 with these patches, I just rechecked:
>>
>> 7818a9f06df1 mmc: renesas_sdhi: Whitelist R8A77990 SDHI
>> a05a906776f8 pinctrl: sh-pfc: r8a77990: Add voltage switch operations
>> for SDHI
>> 2cc9d3a293e9 pinctrl: sh-pfc: r8a77990: Add SDHI pins, groups and functions
>> 6b8d151613b7 pinctrl: sh-pfc: r8a77990: Add Audio SSI pins, groups and
>> functions
>> 9167b22938f7 pinctrl: sh-pfc: r8a77990: Add Audio clock pins, groups and
>> functions
>> 000cc50fc942 arm64: dts: r8a77990-ebisu: Enable HS200 of SDHI3
>> d3f59bbbf7ce arm64: dts: r8a77990-ebisu: Enable eMMC of SDHI3
>> 5928c59bff8d arm64: dts: r8a77990-ebisu: Enable UHS-I of SDHI0 and SDHI1
>> dae32a3172b8 arm64: dts: r8a77990-ebisu: Enable SD card of SDHI0 and SDHI1
>> 8feef039c6c6 arm64: dts: r8a77990: Add SDHI device nodes
>> 25e9471b6a27 (tag: next-20181102) Add linux-next specific files for 20181102
>>
>> I'll let you know once I figure it out.
> 
> Could it be related to potentially old U-Boot etc.. on the board I am using?

No, I don't think so (however, you should only use latest greatest of
course :-) ).

I see this on next/master, but not on next/20181224 right now, so I'm
bisecting it down.

-- 
Best regards,
Marek Vasut

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
