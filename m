From: broonie@kernel.org (Mark Brown)
Date: Mon, 29 Jul 2013 14:43:11 +0100
Subject: [PATCH V2 7/8] ARM: dts: wm8994: Add wm8994 support on smdk5420
In-Reply-To: <CAAgF-Bexp_fGT8KV+TQ0_kZLJBtq7UK=TG4eYRA6qpTSL+scxg@mail.gmail.com>
References: <1374845812-7803-1-git-send-email-padma.v@samsung.com>
 <1374845812-7803-8-git-send-email-padma.v@samsung.com>
 <20130726151902.GL9858@sirena.org.uk>
 <CAAgF-Be8SNxTZv1yFCwH6yJ-O_3R4reh=3y+pSCLJYW7S9TkUg@mail.gmail.com>
 <CAAgF-Bexp_fGT8KV+TQ0_kZLJBtq7UK=TG4eYRA6qpTSL+scxg@mail.gmail.com>
Message-ID: <20130729134311.GX9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 05:31:16PM +0530, Padma Venkat wrote:
> On Sat, Jul 27, 2013 at 6:46 AM, Padma Venkat <padma.kvr@gmail.com> wrote:

> >>> +     vdd: fixed-regulator at 0 {
> >>> +             compatible = "regulator-fixed";
> >>> +             regulator-name = "vdd-supply";

> >> These names look wrong - they should reflect the names in the schematic
> >> as they're for human comprehensibility.  This may just be a case of
> >> dropping the -supply.

> When I posted the same patch for smdk5250, you asked me to club all
> the same supply regulators. So I clubbed AVDD2 and CPVDD. So any other
> better name for representing both supplies?

No, I'd have told you to combine things taht come from the same supply
on the board - things like the speaker supplies for example aren't going
to be coming from separate places.  The names should reflect whatever
the names on the schemaric are, like I say that's probably just removing
the -supply.

> >> documentation update the other day, it's in my tree now) but it's not
> >> essential and I suspect it needs some work on the clock driver side
> >> still.

> > OK. I will check this.

> As per schemata, input clock to MCLK1 is an oscillator clock with
> 16.9MHz and MCLK2 not showing any input clock. So here I need to add a
> fixed rate clock with 16.9MHz as MCLK1 in the smdk board file.

> Is it correct?

Yes, in the DTS (or to XCLKOUT on the AP?).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130729/9290a566/attachment.sig>
