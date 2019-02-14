Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D5AC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:48:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A5FC218FF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ChhQuTRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5FC218FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CQVOPPHPTl1pYXUGCU5cd2l3BAC87cQvB0BE0MwFQaE=; b=ChhQuTRovBVb6C
	wS9Il9UYTcksjiBTG23ttex6D3lbQY6dLQLgduplVD3ez060bmRPQpz+dcYBnwyqpv4CJ0ht+xP9+
	q70hPNvW5TssaxCl5uIwPOVHXBN4sE26yX8Rp/26sR1ee7ef94MZmrQJ4osUaZfmFGhEF8LlDV1zr
	58A5i36XzLFbJKFUBq3JQ4z5EbTbpsDAC0roQ/sH+zooeJRXT4kyIPsXHW2GXVajJo9Kcey8zx1Dq
	XuZ61U/+wBUgX4jyJcvyShqya/BSQ9CSTeK8jiD4GPcn0+rb8p9gd8ImoGnZjYqK7wlS7yZr6ZUc2
	nz+cQSL3QniHyMzHLe6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guJFJ-00025P-V8; Thu, 14 Feb 2019 15:48:17 +0000
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guJFA-0001u7-MK
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 15:48:11 +0000
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id A470940018;
 Thu, 14 Feb 2019 15:47:56 +0000 (UTC)
Date: Thu, 14 Feb 2019 16:47:56 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH v3 0/2] media: cedrus: Add H264 decoding support
Message-ID: <20190214154756.iirejyrmqrtfjr3e@flea>
References: <cover.d3bb4d93da91ed5668025354ee1fca656e7d5b8b.1549895062.git-series.maxime.ripard@bootlin.com>
 <CAAFQd5AcqiwAb30ajLxmj6LZoabVygUsAB8A+drpityOAvY60A@mail.gmail.com>
 <4a1346315224850faf31345b577ce3a29c069f3a.camel@collabora.com>
 <CAAFQd5DE+T6KJ0TXcQUxLSnog5enQf5G0SVM+5t6f60VjcovFw@mail.gmail.com>
 <2e468fd22b577f1a5fd5d3186d6cc88e442e07ec.camel@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2e468fd22b577f1a5fd5d3186d6cc88e442e07ec.camel@collabora.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_074809_072694_E0EAAA0D 
X-CRM114-Status: GOOD (  34.24  )
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
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg  Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexandre Courbot <acourbot@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 jenskuske@gmail.com, linux-sunxi@googlegroups.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Tomasz Figa <tfiga@chromium.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Hans Verkuil <hans.verkuil@cisco.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 01:28:34PM -0300, Ezequiel Garcia wrote:
> On Wed, 2019-02-13 at 12:02 +0900, Tomasz Figa wrote:
> > On Wed, Feb 13, 2019 at 6:22 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> > > Hey Tomasz,
> > > 
> > > On Tue, 2019-02-12 at 21:50 +0900, Tomasz Figa wrote:
> > > > Hi Maxime,
> > > > 
> > > > On Mon, Feb 11, 2019 at 11:39 PM Maxime Ripard
> > > > <maxime.ripard@bootlin.com> wrote:
> > > > > Hi,
> > > > > 
> > > > > Here is a new version of the H264 decoding support in the cedrus
> > > > > driver.
> > > > 
> > > > Thanks for working on this. Please see my comments below.
> > > > 
> > > > > As you might already know, the cedrus driver relies on the Request
> > > > > API, and is a reverse engineered driver for the video decoding engine
> > > > > found on the Allwinner SoCs.
> > > > > 
> > > > > This work has been possible thanks to the work done by the people
> > > > > behind libvdpau-sunxi found here:
> > > > > https://github.com/linux-sunxi/libvdpau-sunxi/
> > > > > 
> > > > > I've tested the various ABI using this gdb script:
> > > > > http://code.bulix.org/jl4se4-505620?raw
> > > > > 
> > > > > And this test script:
> > > > > http://code.bulix.org/8zle4s-505623?raw
> > > > > 
> > > > > The application compiled is quite trivial:
> > > > > http://code.bulix.org/e34zp8-505624?raw
> > > > > 
> > > > > The output is:
> > > > > arm:    builds/arm-test-v4l2-h264-structures
> > > > >         SHA1: 88cbf7485ba81831fc3b93772b215599b3b38318
> > > > > x86:    builds/x86-test-v4l2-h264-structures
> > > > >         SHA1: 88cbf7485ba81831fc3b93772b215599b3b38318
> > > > > x64:    builds/x64-test-v4l2-h264-structures
> > > > >         SHA1: 88cbf7485ba81831fc3b93772b215599b3b38318
> > > > > arm64:  builds/arm64-test-v4l2-h264-structures
> > > > >         SHA1: 88cbf7485ba81831fc3b93772b215599b3b38318
> > > > > 
> > > > > Let me know if there's any flaw using that test setup, or if you have
> > > > > any comments on the patches.
> > > > > 
> > > > > Maxime
> > > > > 
> > > > > Changes from v2:
> > > > >   - Simplified _cedrus_write_ref_list as suggested by Jernej
> > > > >   - Set whether the frame is used as reference using nal_ref_idc
> > > > >   - Respect chroma_format_idc
> > > > >   - Fixes for the scaling list and prediction tables
> > > > >   - Wrote the documentation for the flags
> > > > >   - Added a bunch of defines to the driver bit fields
> > > > >   - Reworded the controls and data format descriptions as suggested
> > > > >     by Hans
> > > > >   - Reworked the controls' structure field size to avoid padding
> > > > >   - Removed the long term reference flag
> > > > 
> > > > This and...
> > > > 
> > > 
> > > Maxime has dropped this because of Ayaka's mail about long term references
> > > not making much sense in stateless decoders.
> > 
> > I haven't seen any argument confirming that thesis, though. I should
> > have kicked in earlier, sorry.
> > 
> 
> OK, in that case, we need to have this flag back.
> 
> > > I noticed that RK3399 TRM has a field to specify long term refs and
> > > so was wondering about this item as well.
> > > 
> > > > >   - Reintroduced the neighbor info buffer
> > > > >   - Removed the ref_pic_list_p0/b0/b1 arrays that are redundant with the
> > > > >     one in the DPB
> > > > 
> > > > these are used in our Rockchip VDEC driver.
> > > > 
> > > > Could you elaborate on the reasons why they got removed?
> > > > 
> > > 
> > > If I understood correctly, there are two reference picture lists.
> > > P-frames will populate ref_pic_list0 and B-frames will populate both.
> > > 
> > > According to this, v4l2_ctrl_h264_slice_param.ref_pic_list0 and .ref_pic_list1
> > > should be enough and ref_pic_list_p0/b0/b1 are not needed.
> > > 
> > > What do you think?
> > 
> > The lists in v4l2_ctrl_h264_slice_param are expected to be past the
> > per-slice modification stage (which is quite complicated and better
> > done in userspace),
> 
> The fact that these are RefPicList0 and RefPicList1, after
> the reordering stage should be better documented.
> 
> > while the ones in v4l2_ctrl_h264_decode_param just
> > in the original order. Rockchip VPU expects them in the original order
> > and does the modification in the hardware.
> > 
> 
> OK, I see.
> 
> So, we have RefPicList0 and RefPicList1, and there is an initialization
> stage and a modification/reordering process.
> 
> One could argue that it's more generic to just pass the initial list,
> but that would mean doing in the kernel something that is easier
> done in userspace (and parsers doing this are already available).
> 
> The question would be what is the most generic way of passing
> the RefPicList0 and RefPicList1 in its initial state.
> 
> 1/ We create additional controls for these.
> 
> 2/ We put them on some of the other controls. Putting them on
> v4l2_ctrl_h264_decode_param didn't seem too wrong.
> 
> Any objections to put them back in there?

None. i'll put them back in.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
