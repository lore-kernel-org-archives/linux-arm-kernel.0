Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029A9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:26:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C30F8218AD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jdct8k8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30F8218AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b0f50quvV4tUzxFWqWdzag1e5DMMV/A7LrTwqcNpe9Q=; b=Jdct8k8X3NcO6G
	bYEb/qnUlYnjwQZpXzdsNkrd/hXpP03hWF8n7NSb/401+iQGqlyVwmQQGAi8nDHrUAdaaDgfzuiIW
	HIQE1ml9uxNPZ2MrbK+oVW6eVfWtULm6v8S6IH0V4k82XHb7VY5c12fT7VakIEC+zSgDMr7Oxz5vW
	qI85YHnnVmt8ynzN02q4uK4bSbPH7Ou1FWspEWSrjtxPozkrI+GeTdNZ0Za+97EMjRPurPXqsOqf7
	I5VlucgIBx5cW/E88ToqQiw3TdtX0VWzDDBLOEL5THPraNT1MWLWjoC32Yc8RJtQKO9inc5eceGyg
	TVdQrv/nBHanMiQ/fmvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gveFw-0006j7-RP; Mon, 18 Feb 2019 08:26:28 +0000
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gveFs-0006ig-QO
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 08:26:26 +0000
X-Originating-IP: 90.88.30.68
Received: from aptenodytes (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: paul.kocialkowski@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B866740015;
 Mon, 18 Feb 2019 08:26:09 +0000 (UTC)
Message-ID: <8d64d043333e3d43c36d60788d6c5b0997bc4e69.camel@bootlin.com>
Subject: Re: [PATCH v3 0/8] drm/sun4i: dsi: Add burst mode support
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Jagan Teki <jagan@openedev.com>, Maxime Ripard <maxime.ripard@bootlin.com>
Date: Mon, 18 Feb 2019 09:26:09 +0100
In-Reply-To: <c46cd50a-3695-ebc8-0cd4-4ddc27fc353b@openedev.com>
References: <cover.f28d9994585553a089a519392616b0d26ed54af1.1549896081.git-series.maxime.ripard@bootlin.com>
 <20190215141244.5jrrqkykna6enbtp@flea>
 <CAMty3ZAA90-fHPADJSE3ht9CiYWA3yBoyEy7wVv9=6C5JiaTVw@mail.gmail.com>
 <c46cd50a-3695-ebc8-0cd4-4ddc27fc353b@openedev.com>
Organization: Bootlin
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_002625_002857_885DCC91 
X-CRM114-Status: GOOD (  19.00  )
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
Cc: bbrezillon@kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 Sean Paul <seanpaul@chromium.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jagan,

On Fri, 2019-02-15 at 22:37 +0530, Jagan Teki wrote:
> Hi Maxime,
> 
> On 15/02/19 8:10 PM, Jagan Teki wrote:
> > 
> > On Fri, 15 Feb, 2019, 7:43 PM Maxime Ripard, <maxime.ripard@bootlin.com 
> > <mailto:maxime.ripard@bootlin.com>> wrote:
> > 
> >     On Mon, Feb 11, 2019 at 03:41:21PM +0100, Maxime Ripard wrote:
> >      > Hi,
> >      >
> >      > Here is a series implementing the burst mode support for DSI.
> >      >
> >      > It's been tested on an A33 board with the panel supported on the last
> >      > patch, which should remove all quirks due to a different SoC from the
> >      > equation.
> > 
> >     I should have sent that mail yesterday, but patches 1-4 and 6-7 were
> >     merged. Patch 5 was discarded since it was not consistent with the
> >     rest of the driver, and 8 had some comments.
> > 
> > 
> > Are the applied patches from this series or from my v7 series?
> > 
> >   Would you please point me the branch.
> > 
> 
> Unfortunately my last mail didn't reach arm mailing list.
> 
> Just wanted to know are the applied patches from this series or from my 
> v7 series? Would you please point me the repo, I couldn't find it on
> git://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git

This series is the one that was applied upstream. You can find the
commits merged at: https://cgit.freedesktop.org/drm/drm-misc/log/

The sunxi tree is not used for changes taking place in specific
subsystems that have their own maintainer trees. In this case, changes
to the DRM driver are going through the DRM misc tree (of which Maxime
is also a maintainer).

With this basis merged, you should be able to respin your series in a
lighter form. Hopefully, that'll help get your changes in shape faster!

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
