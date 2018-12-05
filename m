Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B367C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:54:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C73D214F1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O3tXBfnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C73D214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wu4iBIu44bjqzVuXlONEW3ATQyzubgi9rMMX6FQ/LB8=; b=O3tXBfnmNH1sTU
	J1cnFDi7N2UygZ3DUX2Ln/jUXz2T6v3mTjXiOw+FwCrzjBZ2XxjLsQGxSCJE8W7pTzoT3LNZ+zd5o
	0U6S1T4pNPcpa+C3+Iend96WAbr9euhw57mxlrDIcbyfjrPuHej1p2llo+UCeTzbPN3fhNvgekI4d
	J2ZuNAH/52JNyYbanG4CB8GVzYJ4NNp8D+yd+KzlaBI2L7e/MfqbiS1KY5SsclIN5r+Jl3jrMJTf2
	woFh3j4Zk5yU9E1hj/T/Z0RRovjaCxl+/LKwOr92cXBnGJUe/csKnq4BawDKcWkzxUEGjCyZCV2UJ
	EfGul3fp1IbE83j8roYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUTss-0006mw-7I; Wed, 05 Dec 2018 09:54:22 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUTsp-0006kh-2c
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 09:54:20 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id D2CB320A63; Wed,  5 Dec 2018 10:54:07 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 7CA2D20726;
 Wed,  5 Dec 2018 10:53:57 +0100 (CET)
Message-ID: <f2fd100fd4f0fa66f437b6b3cc80ed3f7da6ba3a.camel@bootlin.com>
Subject: Re: [PATCH v2 07/15] arm64: dts: allwinner: h5: Add system-control
 node with SRAM C1
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 05 Dec 2018 10:53:57 +0100
In-Reply-To: <CAGb2v67tgp_tD_Pkx1Qkc=d__saZUMwwmE44uCCeLgVM2HWmUQ@mail.gmail.com>
References: <20181205092444.29497-1-paul.kocialkowski@bootlin.com>
 <20181205092444.29497-8-paul.kocialkowski@bootlin.com>
 <CAGb2v66JwZ_RkEdk6sz-0Z7EJx7ieG3zBT6yr-95X6guxUkKTg@mail.gmail.com>
 <edf44a24633ecaf59a7d5bea1f4acffdd0ae01a3.camel@bootlin.com>
 <CAGb2v67tgp_tD_Pkx1Qkc=d__saZUMwwmE44uCCeLgVM2HWmUQ@mail.gmail.com>
Organization: Bootlin
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_015419_414812_48CA5A38 
X-CRM114-Status: GOOD (  23.41  )
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
Cc: devel@driverdev.osuosl.org, devicetree <devicetree@vger.kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Wed, 2018-12-05 at 17:49 +0800, Chen-Yu Tsai wrote:
> On Wed, Dec 5, 2018 at 5:48 PM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> > Hi,
> > 
> > On Wed, 2018-12-05 at 17:45 +0800, Chen-Yu Tsai wrote:
> > > On Wed, Dec 5, 2018 at 5:25 PM Paul Kocialkowski
> > > <paul.kocialkowski@bootlin.com> wrote:
> > > > Add the H5-specific system control node description to its device-tree
> > > > with support for the SRAM C1 section, that will be used by the video
> > > > codec node later on.
> > > > 
> > > > The CPU-side SRAM address was obtained empirically while the size was
> > > > taken from the documentation. They may not be entirely accurate.
> > > > 
> > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > ---
> > > >  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 22 ++++++++++++++++++++
> > > >  1 file changed, 22 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > > > index b41dc1aab67d..42bfb560b367 100644
> > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > > > @@ -94,6 +94,28 @@
> > > >         };
> > > > 
> > > >         soc {
> > > > +               system-control@1c00000 {
> > > > +                       compatible = "allwinner,sun50i-h5-system-control";
> > > > +                       reg = <0x01c00000 0x1000>;
> > > > +                       #address-cells = <1>;
> > > > +                       #size-cells = <1>;
> > > > +                       ranges;
> > > > +
> > > > +                       sram_c1: sram@1d00000 {
> > > > +                               compatible = "mmio-sram";
> > > > +                               reg = <0x00018000 0x1c000>;
> > > 
> > > 0x1d00000 or 0x18000?
> > 
> > For the H5, I found the VE SRAM area to be mapped to 0x18000 on the CPU
> > side (when testing with devmem), unlike the A64, H3 and others. I was
> > rather surprised about this as well!
> 
> I'm actually referring to the node name that still says 1d00000.

Oh I totally missed that, sorry. Thanks for pointing it out!

Cheers,

Paul

> ChenYu
> 
> > > > +                               #address-cells = <1>;
> > > > +                               #size-cells = <1>;
> > > > +                               ranges = <0 0x00018000 0x1c000>;
> > > 
> > > Same here.
> > > 
> > > > +
> > > > +                               ve_sram: sram-section@0 {
> > > > +                                       compatible = "allwinner,sun50i-h5-sram-c1",
> > > > +                                                    "allwinner,sun4i-a10-sram-c1";
> > > > +                                       reg = <0x000000 0x1c000>;
> > > > +                               };
> > > > +                       };
> > > > +               };
> > > > +
> > > >                 mali: gpu@1e80000 {
> > > >                         compatible = "allwinner,sun50i-h5-mali", "arm,mali-450";
> > > >                         reg = <0x01e80000 0x30000>;
> > > > --
> > > > 2.19.2
> > 
> > Cheers,
> > 
> > Paul
> > 
> > --
> > Paul Kocialkowski, Bootlin (formerly Free Electrons)
> > Embedded Linux and kernel engineering
> > https://bootlin.com
> > 
-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
