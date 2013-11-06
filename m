From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 06 Nov 2013 13:13:06 +0100
Subject: [PATCH 2/3] clk: shmobile: Add MSTP clock support
In-Reply-To: <CANqRtoRe2repacDdWhoZxY7sMP=AOhW=Mtwm3P9AgzVvwoBGKA@mail.gmail.com>
References: <1383058511-26046-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383058511-26046-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CANqRtoRe2repacDdWhoZxY7sMP=AOhW=Mtwm3P9AgzVvwoBGKA@mail.gmail.com>
Message-ID: <1469822.fWgxvRAPOn@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Wednesday 06 November 2013 17:33:39 Magnus Damm wrote:
> On Tue, Oct 29, 2013 at 11:55 PM, Laurent Pinchart wrote:
> > MSTP clocks are gate clocks controlled through a register that handles
> > up to 32 clocks. The register is often sparsely populated.
> > 
> > Those clocks are found on Renesas ARM SoCs.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  .../bindings/clock/renesas,cpg-mstp-clocks.txt     |  47 +++++
> >  drivers/clk/shmobile/Makefile                      |   1 +
> >  drivers/clk/shmobile/clk-mstp.c                    | 229 ++++++++++++++++
> >  include/dt-bindings/clock/r8a7790-clock.h          |  56 +++++
> >  4 files changed, 333 insertions(+)
> >  create mode 100644
> >  Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> >  create mode 100644 drivers/clk/shmobile/clk-mstp.c
> 
> Thanks for this. The MSTP driver looks fine to me, but..
> 
> >  create mode 100644 include/dt-bindings/clock/r8a7790-clock.h
> 
> .. why do you bundle r8a7790-specific bits with the generic MSTP
> driver in this patch?
> 
> It looks to me that you want these r8a7790 bits included with the
> r8a7790 support code.

My mistake, I'll fix that.

-- 
Regards,

Laurent Pinchart
