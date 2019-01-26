Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96ABC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:17:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B84218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eiOuTWuJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LrYocsTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B84218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n8qKtSnGbcnvXd20g+4laqT5lCxKVBH/fCPp8FAbXa4=; b=eiOuTWuJaPnDJQ
	SdH9q1eBWLN1IDXSJChTZyRWZQaJc6fBr4Xv5ixXX/RzEyfBot/Th73xTW8Gfxrh5wCpor9T0dRXl
	S2Id/5CvtzvjKB2hzZ7455jKjXBTyqiAsadzz1DyUolpms7uxL7DVjNc9MNf63c4EpYDNojwZnfOz
	la2HpwuDSmVXc/kZ+T42ijy0MJ09llvzNmzoX/wgd8MP3jTEH73T8J4K/05y6KX6W73DwHfGldXmI
	tyoOPDgt59aYIacFhwi3Cy5F55Me0LxDzbIqQjRC1DZcqCdM/0ZUR7ape5ZbGAEStZbw81VprzFCA
	/cg5kvBsZtSYFpQLVnTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnPiS-0002QD-62; Sat, 26 Jan 2019 15:17:52 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnPiK-0002Ps-8x
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 15:17:45 +0000
Received: by mail-pg1-x541.google.com with SMTP id w7so5355204pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 26 Jan 2019 07:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ypfIi/wIKiarDm/2lLzjDiZupuVd99j6X/K6v4/0Olo=;
 b=LrYocsTZuJGY9M6oK1fyOYsCLzDf/+LLPs7xG62HOCk0s68dhWfGqM80Y4B559dtGc
 RfyBXVCaLimKhvAkdDfaVkV6dApGlbJSu6cz7hDX7xXypK1k3HQik87mLucag1ecZ1ml
 wLrmU22JAqFScoWc8Va4eawTgU2SGhWVhvYF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ypfIi/wIKiarDm/2lLzjDiZupuVd99j6X/K6v4/0Olo=;
 b=HgvTCv1Cc8ybV0N1OSFZ6T6QEn9YOjqPJB8IfMXiDu5rAfWOjrF2GSldZVctdsew1W
 PzzIikkle4VaKzNN/GL2QE6+tW/aKvwSuWjztRGmObvatSqttnWKAaj0qXZioiME+CeN
 S3PLPHBeHv0LnDTKLzKtk65b39nuyieH5cxC1ab+pP3cYig0zce1ScwMxh+8LEQIWrd/
 mSnC9bIbMeL4JTEnFJAdrzhyGQDNb6g2S2qBWNz4ej2gNDTn/0ZZp/f0UG8ZAkiiYgsD
 WqQWYs9E/GuIFfZYczF2rWaSrOF1aQ4PFmZvBiGfUwTsatfjtG+XaHt1Uy5oEp7AuuTA
 gBKg==
X-Gm-Message-State: AJcUukducVGYZ/FdNweciVOEWgHCroVFCq4F0v6z8t2CERu+buH+1T8V
 R4U9oypWOz0znp3vgcJirwMI
X-Google-Smtp-Source: ALg8bN4AKESaI7wrfY+fYwZJElTafnGMvakFKL+8wR4c+GA+0cN+GgMq65ADucZ6vs9nbfhdYV9enA==
X-Received: by 2002:a62:6143:: with SMTP id v64mr15241945pfb.142.1548515860766; 
 Sat, 26 Jan 2019 07:17:40 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:807:9f85:b1bd:9891:c622:302d])
 by smtp.gmail.com with ESMTPSA id g28sm46010366pfd.100.2019.01.26.07.17.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 26 Jan 2019 07:17:40 -0800 (PST)
Date: Sat, 26 Jan 2019 20:47:33 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 0/5] Add initial Bitmain BM1880 SoC/Board support
Message-ID: <20190126151733.GA15434@Mani-XPS-13-9360>
References: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
 <20190126150320.GB20679@lunn.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190126150320.GB20679@lunn.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_071744_330422_A452E039 
X-CRM114-Status: GOOD (  17.01  )
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
Cc: devicetree@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, darren.tsao@bitmain.com, robh+dt@kernel.org,
 haitao.suo@bitmain.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Andrew,

On Sat, Jan 26, 2019 at 04:03:20PM +0100, Andrew Lunn wrote:
> On Sat, Jan 26, 2019 at 09:40:36AM +0530, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > This patchset adds initial support for Bitmain BM1880 SoC and Sophon
> > Edge board. BM1880 SoC consists of a Dual Core ARM Cortex A53 Application
> > processor subsystem, a single core RISC-V subsystem and a Tensor
> > Processor subsystem.
> 
> Hi Manivannan
> 
> Interesting combination of CPUs. 
> 
> > This patchset adds support for only ARM Cortex A53 Application
> > processor subsystem with UART, which enables the board to boot into
> > initramfs with 2 CPUs.
> 
> Looking forward, what sharing do you expect at the device tree level?
> 
> Looking at 
> 
> https://sophon-file.bitmain.com.cn/sophon-prod/drive/18/11/06/19/BM1880%20product%20brief%20V0.04_Chinese%20versionV0.06.pdf
> 
> it appears all the devices can be shared between the CPUs. So do you
> plan to have a shared .dtsi file somewhere? 
> 
> Is ARCH_BITMAIN going to be both ARM64 and RISC-V?
> 

We don't have any plan to add support for RISC-V subsystem. Moreover,
from the SoC product brief it look like the RISC-V core is a MCU grade
core, so I doubt whether we can run linux on it! It might be a candidate
for RTOS.

For now, ARCH_BITMAIN is going to have only ARM64 support.

Thanks,
Mani

>    Thanks
> 	Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
