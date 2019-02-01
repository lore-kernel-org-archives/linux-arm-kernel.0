Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB87C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:28:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 101A920863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MtK0Gcl+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kk2Yz2FU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101A920863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WN/Q0/5xOFHiXSP81UA4wDv5W0FgnSblenwkT65FwpE=; b=MtK0Gcl+xK/R7D
	BzPt4Dv9fsluQrU09yYQevK70cSzjNMAkg+R+IXKHESU7x7SA4vQBU9Mmliv9IIotR4tGmhUPEWQX
	/OGBdmg4uyTnYJRR5KNo1/zW2vTYTA2icY0+T0nZIC53iOcEQTOplFm1RZoHcOHzJ4uvc+X6G1KZR
	1ha8NryDhmYJF+8q9+QO8ZR/4vV63u9eBasFTBZFzRQNUx9lrp52yz74FqP3rTaVmx65X6V5VXjC9
	gaL6JyWSOl95JusU599tuCVusPQquM5aYQpMTX86eRDKLxcUBJ07Fjx0Jw3Oqa//zY3ggm9aHxue5
	aNjirJFvp6TyIqqBoEdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpPVG-0001AV-H7; Fri, 01 Feb 2019 03:28:30 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpPVD-00019v-2L
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 03:28:28 +0000
Received: by mail-pg1-x543.google.com with SMTP id z10so2276633pgp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 19:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=4dRjyVg+9JCxNZnpzzEFgbpHtM0rs0G6fZXT2YJHEQM=;
 b=Kk2Yz2FU4UfJhJ1fIvh+PS7Wjzudz9oHdndqTsU5IItNpg8Iy2jroalfsk/9C0NqqZ
 FccPiQhPI5w/qLGhCUtFEYlGu4AnkD/HUuh3RjTJCY/pMlWOBquQITUlKMQq/FLGzee5
 YRNAFStBJGJWtSItcZfkSwnfFhQzjETKfeTh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4dRjyVg+9JCxNZnpzzEFgbpHtM0rs0G6fZXT2YJHEQM=;
 b=WtDZH8gidT4Pi1uQCyJxlNZV2UNjN7/bQn/0KGeTSxotKAqNqV+zrFZlccsciU1442
 sERla6aSeYAtvZ2DA5O9aRznAc3rgZF9eS6xooKTVSLNcoibzl2S45cSzGkyoaYviH7Y
 XKCObWQ+lU0AyDzNya8buWvn//cyEHrNRatG65wICVbJ9yLkxU+VEt7Vd6tmc/Avfp5V
 P+JDENoBi3zEpMuspHHZwEY60Kqdz8bnFu8i5PZjH1a2YltU2CsMZiIexp9y8fUqxxdc
 zLRLez+dnpoHc3yzU/RfadiJRLVu37m2NN500kixfd9NFn8ztMfBlUSYvLKvMJb3WDo/
 XnJQ==
X-Gm-Message-State: AHQUAuYQX01Jl3tDHS/1j/8nP27HF+1GV5P/B0LICbl13IQcetg8UTPV
 StEAPaHVoGI3ZbX+BpKuilLf
X-Google-Smtp-Source: AHgI3IYvTnx25Jafk3oczwUF1ifpD5btKXyX895Bwe5PeF7PuT2Bxq3+8CDJz3JuLtG5w/kW0ywc9w==
X-Received: by 2002:a63:5723:: with SMTP id l35mr609137pgb.228.1548991705606; 
 Thu, 31 Jan 2019 19:28:25 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:72ca:1df8:3db9:68de:e3db:c028])
 by smtp.gmail.com with ESMTPSA id n7sm7684996pff.36.2019.01.31.19.28.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 31 Jan 2019 19:28:24 -0800 (PST)
Date: Fri, 1 Feb 2019 08:58:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: shawnguo@kernel.org
Subject: Re: [PATCH v3 0/5] Add Oxalis board support
Message-ID: <20190201032817.GA3008@Mani-XPS-13-9360>
References: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_192827_260402_91321521 
X-CRM114-Status: GOOD (  19.66  )
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
Cc: devicetree@vger.kernel.org, a.tropschug@ebs-systart.com,
 m.bittner@ebs-systart.com, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, leoyang.li@nxp.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 09:51:42AM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This patchset adds Oxalis board support. This board is one of the
> 96Boards Enterprise Edition platform from EBS-SYSTART GmbH. Below are some
> of the key features of this board:
> 
> * SoC: NXP Layerscape LS1012A
> * RAM: 1GB DDR3L
> * PMU: NXP VR5100
> * Storage: 64MByte SPI Flash for bootloader and RCW, MicroSD Card, SATA
> * Connectivity: 2x Ethernet
> * USB: 2x USB3.0
> 
> More information about this board can be found in 96Boards product
> page: https://www.96boards.org/product/oxalis/
> 
> Ethernet and SPI flash are not supported yet!
> 
> Thanks,
> Mani
> 

Hi Shawn,

Any update on this patchset?

Thanks,
Mani

> Changes in v3:
> 
> * Fixed LS1012A and LS1021A bindings
> * Added missing devicetree compatibles for LS1021A based boards
> * Added Rob's Reviewed-by tag for Vendor prefix patch
> 
> Changes in v2:
> 
> As per Rob's review:
> 
> * Adopted the Oxalis board binding to JSON format.
> * Sorted the EBS-SYSTART vendor prefix alphabetically.
> * Used the generic node name for audio codec.
> 
> Manivannan Sadhasivam (5):
>   dt-bindings: arm: fsl: Fix bindings for LS1012A and LS1021A based
>     boards
>   ARM: dts: Add devicetree compatibles for LS1021A based boards
>   dt-bindings: vendor-prefixes: Add EBS-SYSTART GmbH Vendor Prefix
>   dt-bindings: arm: fsl: Add devicetree binding for Oxalis
>   arm64: dts: freescale: Add devicetree for Oxalis
> 
>  .../devicetree/bindings/arm/fsl.yaml          | 11 ++-
>  .../devicetree/bindings/vendor-prefixes.txt   |  1 +
>  arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts   |  1 +
>  arch/arm/boot/dts/ls1021a-qds.dts             |  1 +
>  arch/arm/boot/dts/ls1021a-twr.dts             |  1 +
>  arch/arm64/boot/dts/freescale/Makefile        |  1 +
>  .../boot/dts/freescale/fsl-ls1012a-oxalis.dts | 96 +++++++++++++++++++
>  7 files changed, 111 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts
> 
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
