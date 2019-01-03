Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D7DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:56:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7C020815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ujvtYCU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7C020815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LREVB8sMtzm08YJES6FLNf0YxlaGpEPEr4zxAjaRLMM=; b=ujvtYCU7TIM4PFB+XglYwD1U9
	S54dhmsfYElKY/wlxBNLErIUiJ/sP8pri3PaNmeTUMxghMjToWv0C3gE9/7KM+6rqgd5xkQ35W7hz
	BKZ/LnCCnSUxVMbg+l/lujAWH/hGJFVuNnrw/6EtqY9Q/pFLUPfPArEaOjWpk0HkMfyhw8IRD+o6H
	umvC5r95RbN/3EN3BXNrsBX/kO7KKqaugr9Zyd+T0929QCAtYcyzgJkFo250inBcqnuMwlkzxRNvt
	wd5Wgyf1bdBLbvEI15xnAledtbGqMhCcfaxX+PYVzsNFwacjAGKIiNO21d55jaal3MGvVjVd7CArF
	Piz4h25Tw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf5Ma-0005dC-1I; Thu, 03 Jan 2019 15:56:52 +0000
Received: from mout.kundenserver.de ([212.227.126.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf5MW-0005ce-N4; Thu, 03 Jan 2019 15:56:50 +0000
Received: from [192.168.178.52] ([109.104.40.230]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MxE5Y-1hYHNZ3h16-00xZ5C; Thu, 03 Jan 2019 16:56:17 +0100
Subject: Re: [PATCH v4 0/5] BCM2835 PM driver
To: Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Lee Jones <lee.jones@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
References: <20181212235150.6491-1-eric@anholt.net>
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <7dde45e2-8e26-5051-dea6-da3566bb5e0e@i2se.com>
Date: Thu, 3 Jan 2019 16:56:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181212235150.6491-1-eric@anholt.net>
Content-Language: de-DE
X-Provags-ID: V03:K1:nnCIVsHC5iQW+EBjhvSdfBl3uDHf7k1up7g8vU4rhY1V658Se90
 jQzeKkmHMIU11fvB86ZH74oan5vrgDmqytYEXar8w+CGSObUf96HMFxZM7pdUdheMjpEaC9
 ickBHMvuzDOCfMmPz50Tq49N8emvE1mqvI44R2uKhBSnJo481QvJummr9JDObcAPKNsy9fx
 OHJWIabsJk0hlsRhKUULw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3DqAjtG1nc8=:bOi76EcKcmABfiCfyGOlqN
 RbAy5h+XDnhsCFrT7I3mlIG1KY8ewrb6N+8O81gTVTvsD8ksmGbu+up3eSoRUNO5kKWmy7ahj
 FZam5RHj1SwJDtBsB6efk5C/zqySKp1Ol7vG8ionZY8YSWFsRppNeDkwH0zxzPpNeYnMAspad
 dR6kBAR8y+Hm+so+x6mKarY5Z7gyPApd3bgemHL51AzAS7V5Y7ti9EuaNXBEPc/sgS/oQcVoj
 wm4q4Z1IPDahKQkRScN4qyxeYaib7sdEBy05Vqd8+GEmXVVmGKmaWKgWU3yyKXNtsEFWqKb1q
 oIBeMs6g7j8c3UYym+X1mMXE9YPgIX/wV0c2OShLw/g/TUZeuo7GcMi3GG+PctBM3TsGNfjPY
 QKM2aCmssolmDWJga5glF+UtuE1wMC3cDxHmTeBEaQ+4Ep9cQ/jp1qQLQhaFzuq2XBvIijoEy
 geYlHKN8myMGZO8s/+Ryd6kgGFftce04tNoL60F/MlAClwp3RCGWCfqq8SOos8Qu2oUM/Fbjx
 xZQu/8pxev5JlyQAlfPPtikdxygHdy5Beme5w8PDxxvfVkJezWd52SUJFSQJQhM4Doovh/hjN
 rmtsNAH7+yosI+qu1lyJEUMb2qXHRIkOasr3pcpS40JQc0TVZrHFKp+xot6Ns2Kjq7edk6o+W
 SmC6Tajj7+0ITkj04VVRrV1OQnQQ32zlGugtzaPAJPELgXOtBikYpKajrw99CU19dI2FFK5ni
 VwrjT44HfnrviCVKDtnFG9OPd8vRPz73XKp7XE2cBe4j60n47+iyTV4YuQM=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_075649_054410_93F1C2EA 
X-CRM114-Status: GOOD (  10.95  )
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
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Eric,

Am 13.12.2018 um 00:51 schrieb Eric Anholt:
> v4 adds the system-power-controller node to the binding as requested
> by Stefan.  No driver changes are added to make the power controller
> behavior optional yet, since it's really unrelated to this series.
>
apologize for my late reply. This whole series is

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

I would take care of the power controller behavior with an incremental 
patch.

Should i also make patches to add the driver to the relevant defconfigs 
(bcm2835, multi_v7, arm64)?

Thanks
Stefan


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
