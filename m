Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78109C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:18:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33BE120861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ogEThNOx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2LLZhpUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BE120861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GGFQhh4I2qNWLRx4JMO7heW3dZEJwpc2gbtqPqjicAM=; b=ogEThNOxLyQy2+
	vt4as50PwNgRXQTxqaUWzLURTb+jgxUv5AAkeCOjj1w8hUzp9JpFosyR9EcDGRaz6kl5x7scstYHV
	lQlo3YpJzwDGT2CEG582CGA3fvs4RffVEzQNcXaRj0XxL1j6YZooNTIUKcWi+PIPZepQ1vifk9BKC
	lICY93iDmu0Ecs2hNc8Ug5h2IQ2LhKKhB7WvR6y59UGVqTp7hxlziq7A7gVGrOdmubuN16YA77bKC
	gQ+vLOV0axpZyZ2acwOJ8bI0Io1/cbhZdzI04S61Lx+gk9nD7/YNZ/jDPiGYoFA8e+1pP+JeE+QF9
	9sBdNz2xy1jz1ssq2L2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmHU0-0006uO-QI; Wed, 23 Jan 2019 12:18:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmHTy-0006tv-1o
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 12:18:15 +0000
Received: from localhost (unknown [106.200.229.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CF31720861;
 Wed, 23 Jan 2019 12:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548245893;
 bh=NeuDsS0OVy3+Ri+RiplV7k5Lp6RvyBQuzJB+RSICNRI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=2LLZhpUqgwWX5T3ieq4dqEoHObIm3jwhGgEzxIjATPfClNAAMvmKMFcFTffiX5+ee
 oW/+NuTuMUV/X9qJUCQ0om8QZX9I4wD//zQZIqGU1ttcmInQCJ9I9jmSPJrVGIW/Hr
 7VBK2c1JThgeLyXNP/KXB+PpCWwrQr9lnB0xEyeM=
Date: Wed, 23 Jan 2019 17:46:41 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Codrin.Ciubotariu@microchip.com
Subject: Re: [PATCH] dmaengine: at_xdmac: Fix wrongfull report of a channel
 as in use
Message-ID: <20190123121641.GN4635@vkoul-mobl>
References: <20190117160957.13175-1-codrin.ciubotariu@microchip.com>
 <20190120110417.GS4635@vkoul-mobl>
 <450ee975-a603-cf89-0000-13156c1cb5e8@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <450ee975-a603-cf89-0000-13156c1cb5e8@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_041814_112776_E9E3B27F 
X-CRM114-Status: GOOD (  20.13  )
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
Cc: dmaengine@vger.kernel.org, Ludovic.Desroches@microchip.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 21-01-19, 14:38, Codrin.Ciubotariu@microchip.com wrote:
> On 20.01.2019 13:04, Vinod Koul wrote:
> > Hi Codrin,
> > 
> > On 17-01-19, 16:10, Codrin.Ciubotariu@microchip.com wrote:
> >> From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> >>
> >> atchan->status is used for two things:
> >>   - pass channel interrupts status from interrupt handler to tasklet;
> >>   - channel information like whether it is cyclic or paused;
> >>
> >> Since these operations have nothing in common, this patch adds a
> >> different struct member to keep the interrupts status.
> >>
> >> Fixes a bug in which a channel is wrongfully reported as in use when
> >> trying to obtain a new descriptior for a previously used cyclic channel.
> > 
> > This looks reasonable but am unable to see how the bug is fixed. Perhaps
> > would be great to split the bug part (which can go to fixes) and remove
> > the reuse of variable as a subsequent patch..
> 
> Hi Vinod,
> 
> This patch is the fix, since it moves the operations on atchan->status, 
> in which the interrupt status register is saved, to a different member 
> (irq_status). The AT_XDMAC_CHAN_IS_CYCLIC and AT_XDMAC_CHAN_IS_PAUSED 
> bits have nothing in common with the interrupt status register.
> 
> The bug reproduces when a device_terminate_all() is called, 
> (AT_XDMAC_CHAN_IS_CYCLIC cleared on atchan->status) and then a late End 
> of Block interrupt arrives (AT_XDMAC_CIS_BIS), which sets bit 0 of 
> atchan->status. Bit 0 is also used for AT_XDMAC_CHAN_IS_CYCLIC, so when 
> a new descriptor for a cyclic transfer is created, the driver reports 
> the channel as in use:
> 
> if (test_and_set_bit(AT_XDMAC_CHAN_IS_CYCLIC, &atchan->status)) {
> 	dev_err(chan2dev(chan), "channel currently used\n");
> 	return NULL;
> }
> 
> I can send v2 if you consider the commit message misleading.

Yes please, that would be better and pls add fixes as suggested by
Ludovic along with his ack

-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
