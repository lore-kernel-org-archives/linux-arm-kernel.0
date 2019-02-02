Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A121C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:27:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B5F62146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Op8SYZQq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/B1et1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5F62146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1GzzRyQRh/rC83jDfkCIQyCAGaL/3mm8qArXJrTi0kg=; b=Op8SYZQq+ZyTuk
	TnqikD5jcSj8x4enh6X9DhuTzl1Td+hkMRpRn6hCfD4Amy3KFhAghHdu8QU5sOxN94PZEDI2Su5Yg
	ReN6mWnfQaaq4Ym8+589+0+j40j/nS9DWxpfYe0c60DcxGb3ry3vBux2w3Byt4k9vHYUv3G/Vb8BY
	QNiR6jRWi8JmpPmy6R2oDTIaJTM4GvOhWHFeeoLcQq6SvEcyHN2w1Y7z8hrTfkjZn/HnabAL7BseX
	vKGAdKNQk7jlEFxvTHHH5HCoMagvBCqhYeGEqvxZnU6ZMRnC9IvZ8/PLLVMysCVN6gWEaAt8UATVA
	OJ2E1pm5YbYCKcoRsEzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpsW2-0000RT-Hk; Sat, 02 Feb 2019 10:27:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpsVz-0000R6-SO
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 10:27:13 +0000
Received: from localhost (unknown [125.16.100.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 57314217D6;
 Sat,  2 Feb 2019 10:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549103231;
 bh=GS/fdapWnmzoOb1gHr/sWftx5rSEkr7c8Rf7n8mX+ak=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=E/B1et1b2uCqjJGTFBrGngFuW8z1AfcmKNWBRFnTSfe9LPkEGZJa+3oKXlE2ou3Jv
 kjUia/oCPMnmL66bduRAm+zmhktVHZzCOFeVocsQ7L8LNYOCg4ZDWzml+Mxf1aMD2E
 VI85NGBcOeo0IX4Qv8utHeJjqPMQYsnZOjy1ccmc=
Date: Sat, 2 Feb 2019 15:55:40 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Codrin.Ciubotariu@microchip.com
Subject: Re: [PATCH v2] dmaengine: at_xdmac: Fix wrongfull report of a
 channel as in use
Message-ID: <20190202102540.GF4296@vkoul-mobl>
References: <20190123163339.17506-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190123163339.17506-1-codrin.ciubotariu@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_022711_937145_F397FC45 
X-CRM114-Status: GOOD (  13.96  )
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

On 23-01-19, 16:33, Codrin.Ciubotariu@microchip.com wrote:
> From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> 
> atchan->status variable is used to store two different information:
>  - pass channel interrupts status from interrupt handler to tasklet;
>  - channel information like whether it is cyclic or paused;
> 
> This causes a bug when device_terminate_all() is called,
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
> This patch fixes the bug by adding a different struct member to keep
> the interrupts status separated from the channel status bits.

Applied, thanks

-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
