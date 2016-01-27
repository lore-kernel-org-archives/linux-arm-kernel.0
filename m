From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 27 Jan 2016 09:53:18 -0200
Subject: noise issues when recording sound on i.MX28
In-Reply-To: <20160127105613.GC13664@pengutronix.de>
References: <20160127105613.GC13664@pengutronix.de>
Message-ID: <CAOMZO5BpLen517q2heramSta-R6pdESkjM6w=7FRMZebY6ue-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Wed, Jan 27, 2016 at 8:56 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello,
>
> I currently work with an i.MX28 based machine and occasionally when
> recording sound with arecord but no microphone connected the result
> contains much noise.
>
> I found commits
>
>         90ce77d4468e ENGR00285446-3 [MX28] SAIF: Bit Shift in SAIF RX Data
>         1ea685a12f19 ENGR00285446-2 [MX28] SAIF: Bit Shift in SAIF RX Data
>         1ca899221d8b ENGR00285446-1 [MX28] SAIF: Bit Shift in SAIF RX Data
>
> in the Freescale vendor kernel (branch imx_2.6.35_maintain at
> git://git.freescale.com/imx/linux-2.6-imx.git). The kernel running on
> the machine in question is based on 3.10 with an impressive (that's
> negative) patch stack on top. I think patches -2 and -3 are not relevant
> for my setup because the two saif clocks are configured identically if
> I'm not mistaken. However implementing the soft reset as is done in

Please make sure that the two saif clocks are configured identically.

This was the most important part of the fix when we worked on this
problem on 2.6.35.

Unfortunately I have never had a chance to upstream this fix.

Regards,

Fabio Estevam
