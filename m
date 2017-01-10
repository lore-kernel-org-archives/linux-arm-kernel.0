From: joerg.krause@embedded.rocks (=?ISO-8859-1?Q?J=F6rg?= Krause)
Date: Tue, 10 Jan 2017 17:17:34 +0100
Subject: noise issues when recording sound on i.MX28
In-Reply-To: <20160217085502.39e4cb24@ipc1.ka-ro>
References: <20160127105613.GC13664@pengutronix.de>
 <CAOMZO5BpLen517q2heramSta-R6pdESkjM6w=7FRMZebY6ue-Q@mail.gmail.com>
 <20160127144340.GD13664@pengutronix.de>
 <CAOMZO5AE6HwBYz7kOFORt0HTojJLSb0MYUbkb_HCshDHy=d27g@mail.gmail.com>
 <20160210150315.GC13664@pengutronix.de>
 <CAOMZO5D5H4F90nse9kyW9KvsJStN-sCGktup4FDPw_zTeNfS2g@mail.gmail.com>
 <20160211084029.GE13664@pengutronix.de>
 <CAOMZO5BDjkWi+cQK1-J7ag8Z48tY1Uwofi4EkovN-drSC4_reA@mail.gmail.com>
 <20160217085502.39e4cb24@ipc1.ka-ro>
Message-ID: <1484065054.28705.1.camel@embedded.rocks>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Wed, 2016-02-17 at 08:55 +0100, Lothar Wa?mann wrote:
> Hi,
> 
> On Tue, 16 Feb 2016 13:01:19 -0200 Fabio Estevam wrote:
> > On Thu, Feb 11, 2016 at 6:40 AM, Uwe Kleine-K?nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > 
> > > root at hostname:/sys/kernel/debug/clk find -name saif?_sel
> > > ./ref_xtal/pll0/saif0_sel
> > > ./ref_xtal/pll0/saif1_sel
> > > 
> > > root at hostname:/sys/kernel/debug/clk cat
> > > ./ref_xtal/pll0/saif?_sel/clk_rate
> > > 480000000
> > > 480000000
> > 
> > Ok, what about the SAIF0 and SAIF1 sampling rates: are they always
> > the same?
> > 
> 
> Yes, of course. The driver wouldn't allow using both interfaces with
> different sample rates any way.

Are there any updates about this issue?

I am facing the same problem when using SAIF1 for capture and SAIF0 for
playback. SAIF1 uses SAIF0 as the master and I do set
MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0 when bringing up the board. However,
whenever I record with

$ arecord -D hw:0,1 -t wav -c 2 -r 48000 -f S16_LE -d 5 /tmp/out.wav

and playback afterwards:

$ aplay -D hw:0,0 /tmp/out.wav

I only get noise.

Note, that I am using the Audio Codec Board from Mikroelectronika, but
replaced the on-board 12.288MHz quarz with the MCLK line from SAIF0.

Best regards,
J?rg Krause
