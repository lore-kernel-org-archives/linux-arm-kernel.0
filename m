Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00276C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:49:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C85E320879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L3zBPJBo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6GXKa9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85E320879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B9yWJxDv0GIU27/1xiJxUHYOebrpg/zi/eu3OH9whDI=; b=L3zBPJBoAOnnnl
	Q9Vma8tu2OTjbQsDgOTF0cW2YMUL+iDudhu+BALSShWhG773qL+LQu0GMR5eVOIHFk4nXy83wDdgw
	BYyoL/i2icmJu3SHjF9B3mMM2D+ZxzD8QrDxmvxT8GbHrGLQbLQFvAXqPAdPqIVFHnErUlMuQ4K7/
	WJuniR0dHwQbkh8PiU6UsZRvAwO6mU+tZgo6d0MUcVcugpQcOkyr3c/fg2AXeeD4VzBmibVDBSLCx
	Ra8VN35+JxBD7WFjHn/m+/nciVuLnQdHr+0XpvfyeqLASQ9cY7jGBzw1jKLIIlDjVUFdaXB87evvN
	OyWVuOvsmry6pOeAhJXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUbIu-0007Up-T7; Wed, 05 Dec 2018 17:49:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUbIs-0007Ta-3S
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 17:49:43 +0000
Received: from localhost (unknown [106.201.124.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F244E2084C;
 Wed,  5 Dec 2018 17:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544032171;
 bh=MePwmX+i9XEEu4ESz9qr//H9dp5rCVBzexST1kjLkMU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c6GXKa9OxlEaOASE2gnOLGv+fX2M6vkY2VnJhIlctwRaAlncLrG1MKVOKoo+Fgr5O
 /kT74gTjNQigb1xten6xmcrRTaq3h/2KQoN48l4q6bEadwX1uBjnsG6KbDMLni8Oe7
 yvepgPSvFYdjG9tsGvzBVRLT3wVvfXsJfaCh0bJg=
Date: Wed, 5 Dec 2018 23:19:23 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Peng Ma <peng.ma@nxp.com>
Subject: Re: [v11 1/7] dmaengine: fsldma: Replace DMA_IN/OUT by FSL_DMA_IN/OUT
Message-ID: <20181205174923.GU2847@vkoul-mobl>
References: <20181030023604.34027-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181030023604.34027-1-peng.ma@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_094942_158457_55731769 
X-CRM114-Status: UNSURE (   7.06  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Wen He <wen.he_1@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 leoyang.li@nxp.com, zw@zh-kernel.org, robh+dt@kernel.org,
 dmaengine@vger.kernel.org, dan.j.williams@intel.com, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 30-10-18, 10:35, Peng Ma wrote:
> From: Wen He <wen.he_1@nxp.com>
> 
> This patch implement a standard macro call functions is
> used to NXP dma drivers.

Applied all except DTS patches, thanks
-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
