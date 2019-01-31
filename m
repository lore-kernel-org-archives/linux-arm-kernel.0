Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0E4C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:19:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED5920870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WtWamUEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED5920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zPStiio+FHwgXK4RquWn+F79XjAqNs17xiOxiAPE604=; b=WtWamUEfMVJCUK
	+1CKToOQUInnTnyojbyABwYkHIr8zVEbI18DxkRCjm1zgDW0/aXzLicDfaDOSXj16qC9IyGjXCHVe
	rzqnPmuLHXkW/IXiWhXVZwHF8AfD3L/FHGOgfJ4AS70JM06sWP7gE1OoBUColcU5so9AhlJZXUQJk
	osR3nePre0iTOKxN1lwvpu3KvAlddpZN4rkmyGNO2oRnphmUgOaidrljSGHyNzD++HuTyIBtUAlsT
	MN0xjYsBbibAOkNntVTIGbvkcXl0DGm6f7Sy/p7ERv26YMfk5rtVlKkC8nK/SmhF3iqQ2FhJ/pXEM
	raiOy49zmppJpmwkSU5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp2sq-00016f-Nx; Thu, 31 Jan 2019 03:19:20 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp2sl-00015X-N2; Thu, 31 Jan 2019 03:19:17 +0000
X-UUID: 05621ad8e1fa4b1383abb32ba3ed7585-20190130
X-UUID: 05621ad8e1fa4b1383abb32ba3ed7585-20190130
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 554470306; Wed, 30 Jan 2019 19:19:10 -0800
Received: from MTKMBS31N1.mediatek.inc (172.27.4.69) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 30 Jan 2019 19:19:08 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Thu, 31 Jan 2019 11:19:06 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 11:19:05 +0800
Message-ID: <1548904745.19710.33.camel@mhfsdcap03>
Subject: Re: [PATCH v5 01/20] dt-bindings: mediatek: Add binding for mt8183
 IOMMU and SMI
From: Yong Wu <yong.wu@mediatek.com>
To: Evan Green <evgreen@chromium.org>
Date: Thu, 31 Jan 2019 11:19:05 +0800
In-Reply-To: <CAE=gft4dQjUw3j52dZJYjvQ4GTf8_KcZOdW5Wn9cFtY9wu_atg@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-2-git-send-email-yong.wu@mediatek.com>
 <CAE=gft4dQjUw3j52dZJYjvQ4GTf8_KcZOdW5Wn9cFtY9wu_atg@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_191915_752958_FF66F73D 
X-CRM114-Status: GOOD (  33.14  )
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
Cc: youlin.pei@mediatek.com, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 yingjoe.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Evan,

Thanks very much for reviewing this patchset.

On Wed, 2019-01-30 at 10:27 -0800, Evan Green wrote:
> On Mon, Dec 31, 2018 at 7:56 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > This patch adds decriptions for mt8183 IOMMU and SMI.
> >
> > mt8183 has only one M4U like mt8173 and is also MTK IOMMU gen2 which
> > uses ARM Short-Descriptor translation table format.
> >
> > The mt8183 M4U-SMI HW diagram is as below:
> >
> >                           EMI
> >                            |
> >                           M4U
> >                            |
> >                        ----------
> >                        |        |
> >                    gals0-rx   gals1-rx
> >                        |        |
> >                        |        |
> >                    gals0-tx   gals1-tx
> >                        |        |
> >                       ------------
> >                        SMI Common
> >                       ------------
> >                            |
> >   +-----+-----+--------+-----+-----+-------+-------+
> >   |     |     |        |     |     |       |       |
> >   |     |  gals-rx  gals-rx  |   gals-rx gals-rx gals-rx
> >   |     |     |        |     |     |       |       |
> >   |     |     |        |     |     |       |       |
> >   |     |  gals-tx  gals-tx  |   gals-tx gals-tx gals-tx
> >   |     |     |        |     |     |       |       |
> > larb0 larb1  IPU0    IPU1  larb4  larb5  larb6    CCU
> > disp  vdec   img     cam    venc   img    cam
> 
> It might be cool to put the gals in the picture in the bindings. Not a
> big deal though.

OK. the picture in the binding should be more generic, I will try add
gals in the binding picture in next version.

> 
> >
> > All the connections are HW fixed, SW can NOT adjust it.
> >
> > Compared with mt8173, we add a GALS(Global Async Local Sync) module
> > between SMI-common and M4U, and additional GALS between larb2/3/5/6
> > and SMI-common. GALS can help synchronize for the modules in different
> > clock frequency, it can be seen as a "asynchronous fifo".
> >
> > GALS can only help transfer the command/data while it doesn't have
> > the configuring register, thus it has the special "smi" clock and it
> > doesn't have the "apb" clock. From the diagram above, we add "gals0"
> > and "gals1" clocks for smi-common and add a "gals" clock for smi-larb.
> >
> > From the diagram above, IPU0/IPU1(Image Processor Unit) and CCU(Camera
> > Control Unit) is connected with smi-common directly, we can take them
> > as "larb2", "larb3" and "larb7", and their register spaces are
> > different with the normal larb.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/iommu/mediatek,iommu.txt   |  15 ++-
> >  .../memory-controllers/mediatek,smi-common.txt     |  11 +-
> >  .../memory-controllers/mediatek,smi-larb.txt       |   3 +
> >  include/dt-bindings/memory/mt8183-larb-port.h      | 130 +++++++++++++++++++++
> >  4 files changed, 153 insertions(+), 6 deletions(-)
> >  create mode 100644 include/dt-bindings/memory/mt8183-larb-port.h
> >
> > diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> > index 6922db5..6e758996 100644
> > --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> > +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> > @@ -36,6 +36,10 @@ each local arbiter.
> >  like display, video decode, and camera. And there are different ports
> >  in each larb. Take a example, There are many ports like MC, PP, VLD in the
> >  video decode local arbiter, all these ports are according to the video HW.
> > +  In some SoCs, there may be a GALS(Global Async Local Sync) module between
> > +smi-common and m4u, and additional GALS module between smi-larb and
> > +smi-common. GALS can been seen as a "asynchronous fifo" which could help
> > +synchronize for the modules in different clock frequency.
> >
> >  Required properties:
> >  - compatible : must be one of the following string:
> > @@ -44,18 +48,23 @@ Required properties:
> >         "mediatek,mt7623-m4u", "mediatek,mt2701-m4u" for mt7623 which uses
> >                                                      generation one m4u HW.
> >         "mediatek,mt8173-m4u" for mt8173 which uses generation two m4u HW.
> > +       "mediatek,mt8183-m4u" for mt8183 which uses generation two m4u HW.
> >  - reg : m4u register base and size.
> >  - interrupts : the interrupt of m4u.
> >  - clocks : must contain one entry for each clock-names.
> > -- clock-names : must be "bclk", It is the block clock of m4u.
> > +- clock-names : Only 1 optional clock:
> > +  - "bclk": the block clock of m4u.
> > +  Note that m4u use the EMI clock which always has been enabled before kernel
> > +  if there is no this "bclk".
> 
> Ideally bclk could be specified a little more crisply, as this is
> actually required for some SoCs and not used at all on others (as in
> patch 7).

OK. I will add like this:

+ Here is the list which require the "bclk":
+   - mt2701, mt2712, mt7623 and mt8173. 

> 
> >  - mediatek,larbs : List of phandle to the local arbiters in the current Socs.
> >         Refer to bindings/memory-controllers/mediatek,smi-larb.txt. It must sort
> >         according to the local arbiter index, like larb0, larb1, larb2...
> >  - iommu-cells : must be 1. This is the mtk_m4u_id according to the HW.
> >         Specifies the mtk_m4u_id as defined in
> >         dt-binding/memory/mt2701-larb-port.h for mt2701, mt7623
> > -       dt-binding/memory/mt2712-larb-port.h for mt2712, and
> > -       dt-binding/memory/mt8173-larb-port.h for mt8173.
> > +       dt-binding/memory/mt2712-larb-port.h for mt2712,
> > +       dt-binding/memory/mt8173-larb-port.h for mt8173, and
> > +       dt-binding/memory/mt8183-larb-port.h for mt8183.
> >
> >  Example:
> >         iommu: iommu@10205000 {
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> > index e937ddd..8d3240a 100644
> > --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> > +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> > @@ -2,9 +2,10 @@ SMI (Smart Multimedia Interface) Common
> >
> >  The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
> >
> > -Mediatek SMI have two generations of HW architecture, mt2712 and mt8173 use
> > -the second generation of SMI HW while mt2701 uses the first generation HW of
> > -SMI.
> > +Mediatek SMI have two generations of HW architecture, here is the list
> > +which generation the Socs use:
> > +generation 1: mt2701 and mt7623.
> > +generation 2: mt2712, mt8173 and mt8183.
> >
> >  There's slight differences between the two SMI, for generation 2, the
> >  register which control the iommu port is at each larb's register base. But
> > @@ -19,6 +20,7 @@ Required properties:
> >         "mediatek,mt2712-smi-common"
> >         "mediatek,mt7623-smi-common", "mediatek,mt2701-smi-common"
> >         "mediatek,mt8173-smi-common"
> > +       "mediatek,mt8183-smi-common"
> >  - reg : the register and size of the SMI block.
> >  - power-domains : a phandle to the power domain of this local arbiter.
> >  - clocks : Must contain an entry for each entry in clock-names.
> > @@ -30,6 +32,9 @@ Required properties:
> >             They may be the same if both source clocks are the same.
> >    - "async" : asynchronous clock, it help transform the smi clock into the emi
> >               clock domain, this clock is only needed by generation 1 smi HW.
> > +  and these 2 option clocks for generation 2 smi HW:
> > +  - "gals0": the path0 clock of GALS(Global Async Local Sync).
> > +  - "gals1": the path1 clock of GALS(Global Async Local Sync).
> 
> It would also be nice to specify these more clearly too, since these
> are also required for some SoCs and not used on others (as in patch
> 12).

I will add:

+ Here is the list which has the "gals": mt8183.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
