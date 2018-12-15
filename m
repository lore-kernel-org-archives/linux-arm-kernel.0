Return-Path: <SRS0=YQjL=OY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC509C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 06:30:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 967EF2171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 06:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Eco9kjgx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG1noszi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967EF2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u9P9vC8jrvDNp0tetnji6UHY/p1z4RzMdYzrOJYhKso=; b=Eco9kjgxrV2X2J
	y3nhs7NOz4zV5hWLYeZUJ2A8L/P5yxVOxS+bBEAG38qSEdXIm88rlx+bV0RdrI4At93mA1OP3q/cE
	hZe7avWKO4dDA62ccGpWTvvcOlVtpOGbTxDO5v/TM426x537AmwzZEmxB3dJ7Z7Jk0ejBAXsReCaN
	IHUC2AgyhqHM1XBPYZkEFcTkCy8vyJOVc+W1WmLdXuqly33JUzhLyDdoOZO3S1z+lwr098+SFyLHE
	KHtyXkv6doZOTrDd8UKaB2snM662pE3s5/rvkF8lHQmxQLQsNcY40sWmXLfEfLvG0W3jwJq4t3mBC
	8p10NP02hoIaTmY9dorg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gY3TA-0003DC-Aw; Sat, 15 Dec 2018 06:30:36 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gY3T6-00031a-6l; Sat, 15 Dec 2018 06:30:33 +0000
Received: by mail-pg1-x541.google.com with SMTP id g189so3679313pgc.5;
 Fri, 14 Dec 2018 22:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=tzH4fhsUhl3IHK4OwnrkxhHc5sZa4QDSuGx19nV84pA=;
 b=OG1noszi4jduCQPyVDpRUMYFu2te2FPgwot9XYZiN5/eDaGOxMFEojzMNaAt5mSdKA
 tNk7O3NdwHNKfSHuHkMaYrq8jG586rtmpBPrP7TS8vjXM8PAenMoAK4gA+rwytQTTvhl
 4xkIX4aotww17wQzUpnyllXZd0RPs8cubWs2Xs4qrUOndRo9OC+KFOsLxUzVbnn0S2qc
 Gb7J2YATK+/BWv65uwcCG+Hh8bHvXGstt7+1c37iq8LUNAiEyCZTsUmFzdGOhNcfFxOn
 7kgYQS/Z7IiGrmq6nnJQW7qQjMu09NiK6Ow35vuzzgS+eC2D01wrMycAtXi3GVMxE+Lq
 dsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=tzH4fhsUhl3IHK4OwnrkxhHc5sZa4QDSuGx19nV84pA=;
 b=q1Yfn2cygHHn8B+MerESmwFSiR6BEE+nEoEX8XhFvPW99tjxNAukPBQj6q4dSMnTZm
 l/wwx2QDuXd+tkWScezoIjDkdYcpJFt2sFSEQ4CToFuzFrvYjESwKg2+u5HfdBxbGw3+
 Qwh86msHA5j7AGwHCgfWV34w8BbCqdR+MqC8sR0XUWc3kXBCx+NP+6wXUf4ryvJ45y0j
 Q0uzLqphHhPHYd3UWrLh6u02hb7MVDdK9eDnSa9XoXW05Nd7otIcLUKS1waHhKQuxy7R
 BXuLuQ024WaQoZjkV8f/onc6GWCfmEAyY9fhoOw+dnScgVQD9r31B+vTs3jgyvpwkh9S
 pBFQ==
X-Gm-Message-State: AA+aEWYLGY6xmDo9XnKWfYUS1SMC4uBvVh52E6k4MV33JcpIoSjlRZR7
 yqAIwOGNCfPhWp+ZxYgLd2w=
X-Google-Smtp-Source: AFSGD/WPuSk6zoP0Mr2OLxGWbsOkqyn/5QK4fc98MSYr3w5jWtgC9IbRRuriXdklsgERbhS+kp96dw==
X-Received: by 2002:a62:5a03:: with SMTP id o3mr5474571pfb.19.1544855420740;
 Fri, 14 Dec 2018 22:30:20 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id m76sm9175311pfi.102.2018.12.14.22.30.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Dec 2018 22:30:19 -0800 (PST)
Date: Fri, 14 Dec 2018 22:30:18 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/6] sparc: remove the sparc32_dma_ops indirection
Message-ID: <20181215063018.GA11415@roeck-us.net>
References: <20181208174115.16237-1-hch@lst.de>
 <20181208174115.16237-4-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181208174115.16237-4-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_223032_247090_FC9E9E98 
X-CRM114-Status: UNSURE (   8.96  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-parisc@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>,
 Vineet Gupta <vgupta@synopsys.com>, linux-mips@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Matwey V. Kornilov" <matwey@sai.msu.ru>,
 iommu@lists.linux-foundation.org, openrisc@lists.librecores.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 08, 2018 at 09:41:12AM -0800, Christoph Hellwig wrote:
> There is no good reason to have a double indirection for the sparc32
> dma ops, so remove the sparc32_dma_ops and define separate dma_map_ops
> instance for the different IOMMU types.
> 

Except maybe this:

scsi host0: esp
scsi host0: Data transfer overflow.
scsi host0: cur_residue[0] tot_residue[-36] len[36]
scsi 0:0:0:0: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
scsi target0:0:0: Beginning Domain Validation
scsi host0: Data transfer overflow.
scsi host0: cur_residue[0] tot_residue[-36] len[36]
scsi host0: Data transfer overflow.
scsi host0: cur_residue[0] tot_residue[-36] len[36]
scsi host0: Data transfer overflow.
scsi host0: cur_residue[0] tot_residue[-36] len[36]
scsi host0: Data transfer overflow.
scsi host0: cur_residue[0] tot_residue[-36] len[36]

and so on, until qemu is terminated. This is seen with all sparc32
qemu emulations. Reverting the patch fixes the problem.

Guenter

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
