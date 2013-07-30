From: padma.kvr@gmail.com (Padma Venkat)
Date: Tue, 30 Jul 2013 08:58:39 +0530
Subject: [PATCH V2 7/8] ARM: dts: wm8994: Add wm8994 support on smdk5420
In-Reply-To: <20130729134311.GX9858@sirena.org.uk>
References: <1374845812-7803-1-git-send-email-padma.v@samsung.com>
 <1374845812-7803-8-git-send-email-padma.v@samsung.com>
 <20130726151902.GL9858@sirena.org.uk>
 <CAAgF-Be8SNxTZv1yFCwH6yJ-O_3R4reh=3y+pSCLJYW7S9TkUg@mail.gmail.com>
 <CAAgF-Bexp_fGT8KV+TQ0_kZLJBtq7UK=TG4eYRA6qpTSL+scxg@mail.gmail.com>
 <20130729134311.GX9858@sirena.org.uk>
Message-ID: <CAAgF-BeDYm1jNJpkyfTeS5HjpEuaHiumFq+D_PNs=QYG6-Px+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, Jul 29, 2013 at 7:13 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jul 29, 2013 at 05:31:16PM +0530, Padma Venkat wrote:
>> On Sat, Jul 27, 2013 at 6:46 AM, Padma Venkat <padma.kvr@gmail.com> wrote:
>
>> >>> +     vdd: fixed-regulator at 0 {
>> >>> +             compatible = "regulator-fixed";
>> >>> +             regulator-name = "vdd-supply";
>
>> >> These names look wrong - they should reflect the names in the schematic
>> >> as they're for human comprehensibility.  This may just be a case of
>> >> dropping the -supply.
>
>> When I posted the same patch for smdk5250, you asked me to club all
>> the same supply regulators. So I clubbed AVDD2 and CPVDD. So any other
>> better name for representing both supplies?
>
> No, I'd have told you to combine things taht come from the same supply
> on the board - things like the speaker supplies for example aren't going
> to be coming from separate places.  The names should reflect whatever
> the names on the schemaric are, like I say that's probably just removing
> the -supply.
>
>> >> documentation update the other day, it's in my tree now) but it's not
>> >> essential and I suspect it needs some work on the clock driver side
>> >> still.
>
>> > OK. I will check this.
>
>> As per schemata, input clock to MCLK1 is an oscillator clock with
>> 16.9MHz and MCLK2 not showing any input clock. So here I need to add a
>> fixed rate clock with 16.9MHz as MCLK1 in the smdk board file.
>
>> Is it correct?
>
> Yes, in the DTS (or to XCLKOUT on the AP?).

On smdk boards(atleast on smdk5250 and smdk5420) there is no XCLKOUT
funda. Codec MCLK can get clock from oscillator clock in codec master
mode or i2scdclk in codec slave mode. XCLKOUT is there in some other
variants of 5250 and 5420 where it is using other codecs than wm8994.
But the mux and divider of XCLKOUT is out of CMU. As Sylwester told it
is there in PMU registers.

Thanks
Padma
