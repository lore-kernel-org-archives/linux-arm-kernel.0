From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 24 Nov 2015 17:23:29 +0000
Subject: [PATCH v4 2/5] mfd: syscon: add a DT property to set value width
In-Reply-To: <20151124172214.GJ12874@x1>
References: <1448291861-28543-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1448291861-28543-3-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151124082036.GE807@x1> <20151124162439.GC4616@localhost>
 <20151124172214.GJ12874@x1>
Message-ID: <20151124172329.GK12874@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Nov 2015, Lee Jones wrote:

> On Tue, 24 Nov 2015, Damien Riegel wrote:
> 
> > On Tue, Nov 24, 2015 at 08:20:36AM +0000, Lee Jones wrote:
> > > On Mon, 23 Nov 2015, Damien Riegel wrote:
> > > 
> > > > Currently syscon has a fixed configuration of 32 bits for register and
> > > > values widths. In some cases, it would be desirable to be able to
> > > > customize the value width.
> > > > 
> > > > For example, certain boards (like the ones manufactured by Technologic
> > > > Systems) have a FPGA that is memory-mapped, but its registers are only
> > > > 16-bit wide.
> > > > 
> > > > This patch adds an optional "bus-width" DT binding for syscon that
> > > > allows to change the width for the data bus (i.e. val_bits). If this
> > > > property is provided, it will also adjust the register stride to
> > > > bus-width / 8. If not provided, the default configuration is used.
> > > > 
> > > > Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/mfd/syscon.txt |  3 +++
> > > >  drivers/mfd/syscon.c                             | 13 +++++++++++++
> > > >  2 files changed, 16 insertions(+)
> > > 
> > > Works for me.
> > > 
> > > For my own reference:
> > >   Acked-by: Lee Jones <lee.jones@linaro.org>
> > 
> > This pachset requires a new version to fix something in the watchdog,
> > I will add your Ack in the v5.
> > 
> > > 
> > > How would you like this set to be handled?
> > > 
> > 
> > Not sure what you mean. Actually, I don't know how it works for such
> > patchset with changes across multiple subsystems. What are the options?
> 
> I'm happy to handle it, I just need Acks from the other Maintainers.

Actually, I just need Wim's Ack.

The 2 ARM patches will go in separately.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
