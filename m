Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367F7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:29:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C4120872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uJo4VHTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C4120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lUH7BS1l5v9iQgDvO4qnwK15FgT7lQAwVs6R4Ig66p8=; b=uJo4VHTs++M/T9
	SNamGd9WaBYrByDE9lTFD7BfrvRRb59rtzDQsb1ho6dxoQOvyZ7FXkSvk+i3S0hVkOkz6b86SUaZo
	746fewC1Mo5k6TDpc1gPK/UnkkCLw54zBzL7P/culRwtHnnBSoGdNiHwJ2FftKhuhmQfH3zrInw21
	JkAnAz2tCguBkTjstC+9VYzI6UWuqwiVHeE6sFRVXgyVsVFvtWZ9Met5gBnHLf+wCkW84SYV9GMFw
	HUml5sBpJ+6BY2zEgADPjAEumYsveJ/XDphIlI7nVnOj4VsHC6HlMIJf2BjrjUu35QEUwEvf7PgQB
	HJwMDsvmYSGt9V0YC62Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghuzi-00073l-14; Fri, 11 Jan 2019 11:28:58 +0000
Received: from 8bytes.org ([2a01:238:4383:600:38bc:a715:4b6d:a889]
 helo=theia.8bytes.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghuzf-00072w-5F
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 11:28:56 +0000
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 89F8844C; Fri, 11 Jan 2019 12:28:50 +0100 (CET)
Date: Fri, 11 Jan 2019 12:28:49 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/of: Fix probe-deferral
Message-ID: <20190111112849.y2gfhpw2lk3fjojb@8bytes.org>
References: <b158bd8aae8e9fd1a7fc7960cf17fa623dd47b11.1546880690.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b158bd8aae8e9fd1a7fc7960cf17fa623dd47b11.1546880690.git.robin.murphy@arm.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_032855_344913_4B66DF25 
X-CRM114-Status: GOOD (  10.15  )
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
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 07, 2019 at 05:04:50PM +0000, Robin Murphy wrote:
> Whilst iommu_probe_device() does check for non-NULL ops as the previous
> code did, it does not do so in the same order relative to the other
> checks, and as a result means that -EPROBE_DEFER returned by of_xlate()
> (plus any real error condition too) gets overwritten with -EINVAL and
> leads to various misbehaviour.
> 
> Reinstate the original logic, but without implicitly relying on ops
> being set to infer !err as the initial condition (now that the validity
> of ops for its own sake is checked elsewhere).
> 
> Fixes: 641fb0efbff0 ("iommu/of: Don't call iommu_ops->add_device directly")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Applied to iommu/fixes, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
