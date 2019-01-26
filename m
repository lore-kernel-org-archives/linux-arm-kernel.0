Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE22C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:03:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CCCB218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g7kxB5om";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1S+YcFKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCCB218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=In8Z3dz+vpG9T9CNSW6HJaRXbACF63NQnuYnIR4uuFQ=; b=g7kxB5om0mTDO9
	gx+ljhOcXaIoYFDNBfp7YK9eDYqsoJb+ofz61T2SjTE8BI7JryLZA1097zt8rkqjj1nS65ExOLEb+
	vevfxj8nnJVBItaVKsIU9TDzx4pBnSfzeYeq8APcPMcSaP3hEvKLGbkBUpInK3fV+hGufap8pITd4
	c7cvLkqUPIzCe5DdNoEAXociY02bs3twBzv7dN1gEsEm3yrM02jzhgfj4xRZJq8z9X4iCTyz/e/Q6
	LIu9uMectOXt396rq8wGnNPqIlPGBojw7TI0Z6ly18YbBuvTSaNaY7OMWTYO6ECnK6wc3r12qODXv
	qzwHppU/xvod9juwnEAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnPUY-0005w2-0t; Sat, 26 Jan 2019 15:03:30 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnPUT-0005vj-6s
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 15:03:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vAImYk36YexvkurQtK36V1nE8m1xtMVCvCr4V3KmHvA=; b=1S+YcFKLiy7aQ7J4gIefAv9iPx
 C8XFomPpQXMca1YXnlkEkXLuFDlYpT4dv5kengNELRpGSsR3CylbeLAN3iFvIpEzYSitjxd8U03SN
 A6DDMi/4d0x4JBveI51Q14tFL2L1eTJAIvxlxL/r/3IGtW+mLkk/maS8GnJMGA/U4jrs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1gnPUO-0005iK-Gz; Sat, 26 Jan 2019 16:03:20 +0100
Date: Sat, 26 Jan 2019 16:03:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 0/5] Add initial Bitmain BM1880 SoC/Board support
Message-ID: <20190126150320.GB20679@lunn.ch>
References: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_070325_401394_6CA14040 
X-CRM114-Status: GOOD (  10.18  )
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

On Sat, Jan 26, 2019 at 09:40:36AM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This patchset adds initial support for Bitmain BM1880 SoC and Sophon
> Edge board. BM1880 SoC consists of a Dual Core ARM Cortex A53 Application
> processor subsystem, a single core RISC-V subsystem and a Tensor
> Processor subsystem.

Hi Manivannan

Interesting combination of CPUs. 

> This patchset adds support for only ARM Cortex A53 Application
> processor subsystem with UART, which enables the board to boot into
> initramfs with 2 CPUs.

Looking forward, what sharing do you expect at the device tree level?

Looking at 

https://sophon-file.bitmain.com.cn/sophon-prod/drive/18/11/06/19/BM1880%20product%20brief%20V0.04_Chinese%20versionV0.06.pdf

it appears all the devices can be shared between the CPUs. So do you
plan to have a shared .dtsi file somewhere? 

Is ARCH_BITMAIN going to be both ARM64 and RISC-V?

   Thanks
	Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
