Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84ECC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:26:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AACBB2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IHRY0WCA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACBB2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vfeaIuQyr606Qe/s8larIxFoUvz/Xieci+TFHfNqlxo=; b=IHRY0WCAeT+4Gc
	Hzaya/x+4cWI43nkiS2300iX/VMuwh+tSeHUSByF3bdY82oRYU38Q/8enp2ialrqTktp09uLKGh0w
	5J6bizXu25AeHWZ8dc7EfCVNUWQwdyDD7E18HWMOKQHtL/PFiDvQ9kNNMGw5O+o2U/gACltW12gWZ
	ynXOL9F5ZxPRBCqrqHP00h3IZlGLf3WfAogQsNAzD+wx9hbg0AvWIam6Rf+4z9qSKzLBB4i3AwSMl
	mp3v/zotBCdTd/t73HkSdU0Io1fiBh8TKjfgoHmb5sn9MdK4jxsiFqeYIBZZYn+dk4kmjZHNtk6D+
	WHv1YN98BUKNVWlZqfPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqkop-0004VA-FB; Mon, 04 Feb 2019 20:26:15 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqkol-0004UG-Qg
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 20:26:13 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id C6214808C;
 Mon,  4 Feb 2019 20:26:16 +0000 (UTC)
Date: Mon, 4 Feb 2019 12:26:04 -0800
From: Tony Lindgren <tony@atomide.com>
To: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH] config: arm: omap2: remove PROVE_LOCKING from defconfig
Message-ID: <20190204202604.GP5720@atomide.com>
References: <CGME20181009153624eucas1p2ad30aea33ad1c869f11bd9ca1156d9af@eucas1p2.samsung.com>
 <20181009153624eucas1p2ad30aea33ad1c869f11bd9ca1156d9af~b_rxQW8J90311703117eucas1p2U@eucas1p2.samsung.com>
 <20181108165958.GK56134@atomide.com>
 <21ce2c61-0b20-41f2-4d12-3c5b1c4b7925@partner.samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <21ce2c61-0b20-41f2-4d12-3c5b1c4b7925@partner.samsung.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_122611_904348_6E479581 
X-CRM114-Status: GOOD (  15.10  )
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
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Lukasz Luba <l.luba@partner.samsung.com> [181113 10:22]:
> Hi Tony,
> 
> On 11/8/18 5:59 PM, Tony Lindgren wrote:
> > Hi,
> > 
> > * Lukasz Luba <l.luba@partner.samsung.com> [181009 08:36]:
> >> PROVE_LOCKING enables LOCKDEP, which causes big overhead on cache and
> >> bus transactions.
> >>
> >> On some ARM big.LITTLE architecutres (Exynos 5433) the overhead is really big.
> >> The overhead can be measures using hackbench which will speed up
> >> by x3 times (11sec -> 3.4sec).
> >> When you check transaction on cache or buses, the results are way higher
> >> than normal for the same hackbench test:
> >> L1d cache invalidations: 26mln vs 4mln
> >> L2u cache invalidations: 42mln vs 12mln
> >> bus cyc/access: 30cyc/access vs. 20cyc/access
> >> context switch is x3 times cheaper
> >>
> >> Enable this option only when you have some locking issue to investigate.
> > 
> > I'm all for this, but this disables also other less intrusive
> > debug options. It used to be that we'd get locking issues merged
> > into drivers and I think that's how it originally got enabled.
> That's common reason for a few defconfigs in mainline.

Actually looks like this does not change the DEBUG
related options.. I must have done something wrong
earlier, sorry. So applying into omap-for-v5.1/defconfig.

> > So we should take a look which ones we can or want to keep.
> > Or just disable CONFIG_DEBUG completely.
> Ideally, the CI should try a few 'types' of configs,
> generated based on the 'defconfig'. Some 'smart' script might
> cut the debug options for an image for performance regression tests.
> > 
> > For distros, that's multi_v7_defconfig nowadays for most part
> > so I think most people using omap2plus_defconfig are developers
> > working on various devices.

Yes I think that's the case.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
