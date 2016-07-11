From: hs.liao@mediatek.com (Horng-Shyang Liao)
Date: Mon, 11 Jul 2016 10:55:05 +0800
Subject: [PATCH v9 1/4] dt-bindings: soc: Add documentation for the
 MediaTek GCE unit
In-Reply-To: <1467973066.2472.238.camel@pengutronix.de>
References: <1467270883-1407-1-git-send-email-hs.liao@mediatek.com>
 <1467270883-1407-2-git-send-email-hs.liao@mediatek.com>
 <1467973066.2472.238.camel@pengutronix.de>
Message-ID: <1468205705.11509.15.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jan,

On Fri, 2016-07-08 at 12:17 +0200, Jan L?bbe wrote:
> On Do, 2016-06-30 at 15:14 +0800, HS Liao wrote:
> [...]
> > +Required properties:
> > +- compatible: Must be "mediatek,mt8173-gce"
> > +- reg: Address range of the GCE unit
> > +- interrupts: The interrupt signal from the GCE block
> > +- clock: Clocks according to the common clock binding
> > +- clock-names: Must be "gce" to stand for GCE clock
> > +- #mbox-cells: Should be 1
> [...]
> > +		#mbox-cells = <1>;
> [...]
> > +		mediatek,gce = <&gce>;
> > +		mboxes = <&gce 0 1 /* main display with merging wfe */
> > +			  &gce 1 1>; /* sub display with merging wfe */
> 
> It seems that you use two cells instead of one as you declared above.
> This should be consistent.

Will correct it as 2.

> Also, why do you need an explicit phandle to the gce if you already use
> mailboxes?

"mediatek,gce" should be added to all clients which ask gce to access 
their registers.

"mboxes" should be added to all clients which will communicate with gce
via mailbox.

For example, if mmsys send cmdq tasks to ask gce to write registers of 
mmsys and ovl, mmsys should have "mediatek,gce" and "mboxes", and ovl
should have "mediatek,gce".

I will explain their difference in GCE's device tree document.

> Best regards,
> Jan L?bbe

Thanks,
HS
