Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416DBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:22:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF1D20861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GpgfOPfW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T00YcxJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF1D20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VPEclHIQggDWpv+hFM0vCsjwfsKsu73KoOIXVrTS+NY=; b=GpgfOPfWvhyBob6+rJELFmslc
	WhGezFnV+0CNFimXDDJZfj48BauydUionBc8vbIwH+9p9cPPYhp9mha2NOjgxJU4aBi5ANeHSXvSj
	HQWl23rAQ8FaZxdscVnL9KkjeCHqSvgmgDBkkwkbZcZm++3Jqeh4z5zZD/P0i7pdYzEugyzOi27Vr
	s01oqsMwXAegXqYAfjWHXcIe4IVfepibtOY942RK9m2yryBw+SJBEWPUQggwRKxmHu4PK5LHPhrHM
	tPExNsDJPcNmMI6YyBqr+n9N8bMIGvlpP3I7/6eTmPeLVCdQGQwMjDSOuXoviLshsn0FblFNvOQkL
	CmzkP2nOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjLrL-0004SK-NX; Tue, 15 Jan 2019 10:22:15 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjLqE-0003NL-Mw
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 10:21:09 +0000
Received: by mail-wm1-x343.google.com with SMTP id y139so2654071wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 02:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hFa2JEvFQiwk2KCPkrV02RK6pBeq0zrEWFNHUKsUdd0=;
 b=T00YcxJajsPGni9q1hgTOqNVp0lJWV75MoLOXzFEL7gXLchAB6UUNzWVKySyT8OwLq
 0tmp9GexsyEpnFjamt7ADbIWEV4GBFRvnLXLk7w4Jxziaf4/4Uy1ME2aXiiLMOySDsBy
 3vtmgxhTpSdbgzD4ONOF1k7lgWtcxjW6TysCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hFa2JEvFQiwk2KCPkrV02RK6pBeq0zrEWFNHUKsUdd0=;
 b=Wq2pG3dIUFfvOuAohylb44EFIIYEEenxzckcuRJ3zOa12mYctGdH3MD5BgjJKAl+5s
 Dp1LIoQmhSIyCgC4/OKSC3M8ICiZbByl4iM5XEG+q1lF6tlZq53wg9ex5FJ1nTnQVu/k
 kApztdmUo69QB1xv2IQMxsmjdRWyVb1gpp8M/+Ualt9AboA2fPcRIJdPfpsPaG9ZFEYk
 QQQUKWzYoGZmaN1TtMdOAyIIdWOJEbi3vfenCZP4gt4PfdcVFIzwtA+8n59Ieti8BtYk
 GM/CyC/HJEpBG2Huq05Kp3uBUoqksbKYeYu5+h1SpMwWK7hiSLL9GmUH4O4BgHK3GTnb
 bbCw==
X-Gm-Message-State: AJcUuker3PzxK9/jAerzH+5yVIwFGv05hMHY442n3qBWRdtYmb+G+eEa
 Sg0yhgabxauZbbHp/62j9Zm2lmnkh3M=
X-Google-Smtp-Source: ALg8bN7seLmejwyq3ihtdzWG13d+ILybPt7l7KMb/AEI6zXI2IdfGGC48xkg6xfpH/sJEkd+cg/wdg==
X-Received: by 2002:a1c:ad43:: with SMTP id w64mr2671139wme.32.1547547664220; 
 Tue, 15 Jan 2019 02:21:04 -0800 (PST)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id k15sm108167590wru.8.2019.01.15.02.21.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Jan 2019 02:21:03 -0800 (PST)
Subject: Re: [PATCH 0/3] nvmem: imx-ocotp: Implement i.MX6ULL/ULZ support
To: Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh+dt@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>
References: <1544536273-17909-1-git-send-email-stefan.wahren@i2se.com>
 <7ca64f1d-8649-79a3-4c48-5242a68a837b@i2se.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <617796b0-47b1-7dc2-533b-1765dc825bd0@linaro.org>
Date: Tue, 15 Jan 2019 10:21:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <7ca64f1d-8649-79a3-4c48-5242a68a837b@i2se.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_022107_007249_E7FEA8E2 
X-CRM114-Status: GOOD (  15.37  )
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
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-imx@nxp.com,
 kernel@pengutronix.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 15/01/2019 10:17, Stefan Wahren wrote:
> Hi Shawn,
> hi Srinivas,
> 
> Am 11.12.18 um 14:51 schrieb Stefan Wahren:
>> According to the reference manuals for i.MX6ULL and i.MX6ULZ both SoCs
>> only support 8 OTP banks instead of 16. So we can't use the compatible
>> string of i.MX6UL.
>>
>> Stefan Wahren (3):
>>    dt-bindings: imx-ocotp: Add i.MX6ULL/ULZ support
>>    nvmem: imx-ocotp: Implement i.MX6ULL/ULZ support
>>    ARM: dts: imx6ull: Fix i.MX6ULL/ULZ ocotp compatible
>>
>>   Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 3 ++-
>>   arch/arm/boot/dts/imx6ull.dtsi                        | 4 ++++
>>   drivers/nvmem/imx-ocotp.c                             | 7 +++++++
>>   3 files changed, 13 insertions(+), 1 deletion(-)
>>
> Rob already gave his Reviewed-By for the binding. Are you fine with the rest of the series?
> 

I can take 1 and 2 via nvmem tree, dt patch has to go via ARM SoC tree!


thanks,
srini
> Regards
> Stefan
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
