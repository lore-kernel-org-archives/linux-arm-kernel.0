Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED67C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:22:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A073E222BE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iskzkzXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A073E222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j0HYsRYRFEVb0OBbEZBHuvn92BFIUOgVwGuaIu/sdKo=; b=iskzkzXqrfwlHq
	TIyffyHuBCFQiB+R9t1F2kMt2X5s5XYONMtnbODPvoiIAEXnVMQkZCC0UL7mM4BmDMmQPw95IO4XD
	+D0fsM0DbF2X+Qi+LzEx1KwqQEdP5pzx4wAjKDkhG/qH4/iWz8Y/0tAMXuyBpwUsxMx8BPBdEwiWe
	dfJBHanM3UCGmaY1trvyGkgerERls+oV+wYz/aE4ctfh/peBF01RhmqMyS15gKbwGQPFT2USjxmBQ
	a+3qkv+uDT/0pwe7d5x6gXsg1UbLb61TfACMFaEStzmxyAb7SOQdVWwCloff1XJKDwrIAG9fNbXD9
	xSy3yPFXnm9pl5DBUn6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtfVg-0001HU-VJ; Tue, 12 Feb 2019 21:22:32 +0000
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtfVd-0001H7-US
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 21:22:31 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: ezequiel) with ESMTPSA id 35D8327FB65
Message-ID: <4a1346315224850faf31345b577ce3a29c069f3a.camel@collabora.com>
Subject: Re: [PATCH v3 0/2] media: cedrus: Add H264 decoding support
From: Ezequiel Garcia <ezequiel@collabora.com>
To: Tomasz Figa <tfiga@chromium.org>, Maxime Ripard <maxime.ripard@bootlin.com>
Date: Tue, 12 Feb 2019 18:22:17 -0300
In-Reply-To: <CAAFQd5AcqiwAb30ajLxmj6LZoabVygUsAB8A+drpityOAvY60A@mail.gmail.com>
References: <cover.d3bb4d93da91ed5668025354ee1fca656e7d5b8b.1549895062.git-series.maxime.ripard@bootlin.com>
 <CAAFQd5AcqiwAb30ajLxmj6LZoabVygUsAB8A+drpityOAvY60A@mail.gmail.com>
Organization: Collabora
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_132230_242231_B11DE3D7 
X-CRM114-Status: GOOD (  23.61  )
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
Cc: "list@263.net:IOMMU DRIVERS
 <iommu@lists.linux-foundation.org>, Joerg   Roedel <joro@8bytes.org>,
 " <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexandre Courbot <acourbot@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 jenskuske@gmail.com, linux-sunxi@googlegroups.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
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

Hey Tomasz,

On Tue, 2019-02-12 at 21:50 +0900, Tomasz Figa wrote:
> Hi Maxime,
> 
> On Mon, Feb 11, 2019 at 11:39 PM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > Hi,
> > 
> > Here is a new version of the H264 decoding support in the cedrus
> > driver.
> 
> Thanks for working on this. Please see my comments below.
> 
> > As you might already know, the cedrus driver relies on the Request
> > API, and is a reverse engineered driver for the video decoding engine
> > found on the Allwinner SoCs.
> > 
> > This work has been possible thanks to the work done by the people
> > behind libvdpau-sunxi found here:
> > https://github.com/linux-sunxi/libvdpau-sunxi/
> > 
> > I've tested the various ABI using this gdb script:
> > http://code.bulix.org/jl4se4-505620?raw
> > 
> > And this test script:
> > http://code.bulix.org/8zle4s-505623?raw
> > 
> > The application compiled is quite trivial:
> > http://code.bulix.org/e34zp8-505624?raw
> > 
> > The output is:
> > arm:    builds/arm-test-v4l2-h264-structures
> >         SHA1: 88cbf7485ba81831fc3b93772b215599b3b38318
> > x86:    builds/x86-test-v4l2-h264-structures
> >         SHA1: 88cbf7485ba81831fc3b93772b215599b3b38318
> > x64:    builds/x64-test-v4l2-h264-structures
> >         SHA1: 88cbf7485ba81831fc3b93772b215599b3b38318
> > arm64:  builds/arm64-test-v4l2-h264-structures
> >         SHA1: 88cbf7485ba81831fc3b93772b215599b3b38318
> > 
> > Let me know if there's any flaw using that test setup, or if you have
> > any comments on the patches.
> > 
> > Maxime
> > 
> > Changes from v2:
> >   - Simplified _cedrus_write_ref_list as suggested by Jernej
> >   - Set whether the frame is used as reference using nal_ref_idc
> >   - Respect chroma_format_idc
> >   - Fixes for the scaling list and prediction tables
> >   - Wrote the documentation for the flags
> >   - Added a bunch of defines to the driver bit fields
> >   - Reworded the controls and data format descriptions as suggested
> >     by Hans
> >   - Reworked the controls' structure field size to avoid padding
> >   - Removed the long term reference flag
> 
> This and...
> 

Maxime has dropped this because of Ayaka's mail about long term references
not making much sense in stateless decoders.

I noticed that RK3399 TRM has a field to specify long term refs and
so was wondering about this item as well.

> >   - Reintroduced the neighbor info buffer
> >   - Removed the ref_pic_list_p0/b0/b1 arrays that are redundant with the
> >     one in the DPB
> 
> these are used in our Rockchip VDEC driver.
> 
> Could you elaborate on the reasons why they got removed?
> 

If I understood correctly, there are two reference picture lists.
P-frames will populate ref_pic_list0 and B-frames will populate both.

According to this, v4l2_ctrl_h264_slice_param.ref_pic_list0 and .ref_pic_list1
should be enough and ref_pic_list_p0/b0/b1 are not needed.

What do you think?

Regards,
Ezequiel


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
