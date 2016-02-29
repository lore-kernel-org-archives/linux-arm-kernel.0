From: ramesh.shanmugasundaram@bp.renesas.com (Ramesh Shanmugasundaram)
Date: Mon, 29 Feb 2016 14:06:21 +0000
Subject: [PATCH 1/2] can: rcar_can: Add r8a7795 support
In-Reply-To: <56D43DC8.8010409@pengutronix.de>
References: <1456737661-20538-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1456737661-20538-2-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <56D411A5.9070706@pengutronix.de>
 <SG2PR06MB10380FC567E038EA92D5401EC3BA0@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56D416A9.6080608@pengutronix.de> <56D43DC8.8010409@pengutronix.de>
Message-ID: <SG2PR06MB1038B0596DFE68AFE1B7E83BC3BA0@SG2PR06MB1038.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

> On 02/29/2016 11:00 AM, Marc Kleine-Budde wrote:
> > I think it's better to fix the algorithm. I'll look into it.
> 
> What about:
> 
> > ./can-calc-bit-timing -c 39999998 rcar_can
> > Bit timing parameters for rcar_can with 39.999998 MHz ref clock
> > nominal                                 real Bitrt   nom  real SampP
> > Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP Bitrate Error SampP SampP Error
> CiBCR
> > 1000000    125   2    3    2   1   5  999999  0.0% 75.0% 75.0%  0.0%
> 0x40040100
> >  800000    125   3    4    2   1   5  799999  0.0% 80.0% 80.0%  0.0%
> 0x60040100
> >  500000    125   6    7    2   1   5  499999  0.0% 87.5% 87.5%  0.0%
> 0xc0040100
> >  250000    250   6    7    2   1  10  249999  0.0% 87.5% 87.5%  0.0%
> 0xc0090100
> >  125000    500   6    7    2   1  20  124999  0.0% 87.5% 87.5%  0.0%
> 0xc0130100
> >  100000    625   6    7    2   1  25   99999  0.0% 87.5% 87.5%  0.0%
> 0xc0180100
> >   50000   1250   6    7    2   1  50   49999  0.0% 87.5% 87.5%  0.0%
> 0xc0310100
> >   20000   3125   6    7    2   1 125   19999  0.0% 87.5% 87.5%  0.0%
> 0xc07c0100
> >   10000   6250   6    7    2   1 250    9999  0.0% 87.5% 87.5%  0.0%
> 0xc0f90100
> 

I think, it should be correct. Can I have the patch please(can-utils or kernel)? I'll give it a go.

Manual e.g. shows, for 1Mbps and 40MHz clock, two settings are possible
10Tq -> BRP 4
20Tq -> BRP 2

Condition is TSEG1 > TSEG2 >= SJW & bitrate = clock freq/(brp * number of Tq)

Your e.g. satisfies the condition and hopefully it should be OK.

Thanks,
Ramesh
