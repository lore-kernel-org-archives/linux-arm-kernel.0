Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F8CC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:13:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 163B020659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fVPXUOO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163B020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FIQ9vshjsTzld8h8wQtBvNvyDaqIXLdNgg1264jH20Q=; b=fVPXUOO8DN73rG
	vJsvymlJZU8gEfIWy1iZS0Us5lz2SVRwgf7u8rNNtIKLt0HOqP4yLaguFoMLm4s8sWyBJLVa3ZLQq
	QmC0RMo78PJJ8Zg335hPV8NLjwd15duqlRb9fHQSyV+04zBVgp753pAcb8PBDdzMBa9zTUxMrMEd9
	ZlIN7tMV+H7rSiYO2rxIsxsC/a8fcFzwA5/TiKmb1OtLj3A9gj6WQCCEticW4/SVgiMIxYmFi/5AP
	fBe2LVNRq/Yk8dPAauWX3TrcASRb5VlA0/q2zi9RZBczcmefVqq/tXD5HnYEC2lfICM/+6vXfDF+S
	wCt0PzEKg85X5lOD8wnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUAWT-0001bN-6T; Tue, 04 Dec 2018 13:13:57 +0000
Received: from hillosipuli.retiisi.org.uk ([2001:1bc8:1a6:d3d5::81:2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUAWO-0001aV-RL
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 13:13:54 +0000
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk
 [IPv6:2001:1bc8:1a6:d3d5::80:2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 71D6A634C7E;
 Tue,  4 Dec 2018 15:13:33 +0200 (EET)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.89)
 (envelope-from <sakari.ailus@retiisi.org.uk>)
 id 1gUAW5-0000Jo-64; Tue, 04 Dec 2018 15:13:33 +0200
Date: Tue, 4 Dec 2018 15:13:33 +0200
From: sakari.ailus@iki.fi
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 1/6] media: dt-bindings: media: sun6i: Separate H3
 compatible from A31
Message-ID: <20181204131333.peobmjkksl2p3hvv@valkosipuli.retiisi.org.uk>
References: <20181130075849.16941-1-wens@csie.org>
 <20181130075849.16941-2-wens@csie.org>
 <CAMty3ZC-4hnVOx9AYhm7uUCUHF=n_NoH3xV-3SyUXWxb_X8TGg@mail.gmail.com>
 <CAGb2v67xoqV+QuVxDyBrUzzpab9vsbJRQBFPA0OS=h_bZ2H7Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGb2v67xoqV+QuVxDyBrUzzpab9vsbJRQBFPA0OS=h_bZ2H7Tw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_051353_074110_C3F045B3 
X-CRM114-Status: GOOD (  17.15  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Jagan Teki <jagan@amarulasolutions.com>, Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Chen-Yu,

On Mon, Dec 03, 2018 at 05:48:31PM +0800, Chen-Yu Tsai wrote:
> On Mon, Dec 3, 2018 at 5:42 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > On Fri, Nov 30, 2018 at 1:29 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > >
> > > The CSI controller found on the H3 (and H5) is a reduced version of the
> > > one found on the A31. It only has 1 channel, instead of 4 channels for
> > > time-multiplexed BT.656. Since the H3 is a reduced version, it cannot
> > > "fallback" to a compatible that implements more features than it
> > > supports.
> > >
> > > Split out the H3 compatible as a separate entry, with no fallback.
> > >
> > > Fixes: b7eadaa3a02a ("media: dt-bindings: media: sun6i: Add A31 and H3
> > >                       compatibles")
> > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >
> > "media" text appear two times on commit head.
> 
> Just following what previous commits did. :)

I understand Mauro has a  script prefixes everything going through the
media tree with "media: " unless it's already there. I'd drop the latter,
but perhaps elaborate a bit this is about CSI. Fine details... I think it's
fine as-is for now.

> 
> > Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
> 
> BTW, I know you've been trying to get CSI to work on the A64.
> I have it working for the Bananapi-M64. The CSI SCLK needs to
> be lowered to 300 MHz or the image gets corrupted.
> 
> ChenYu

-- 
Sakari Ailus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
