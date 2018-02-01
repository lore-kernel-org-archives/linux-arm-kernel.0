From: york.sun@nxp.com (York Sun)
Date: Thu, 1 Feb 2018 20:56:33 +0000
Subject: EDAC driver for ARMv8 L1/L2 cache
References: <20180112173802.kb32zrxc5uhsjlxk@lakrids.cambridge.arm.com>
 <VI1PR04MB20780EF853A0822A6EFCFE449A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180112180048.srniseo2ft7ytqve@lakrids.cambridge.arm.com>
 <VI1PR04MB2078FCB86150A2AABFE7AB439A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180113113156.nnmkuh25rilzwf4p@pd.tnic>
 <20180115142154.rj6cgnhlll7ivyew@lakrids.cambridge.arm.com>
 <20180115143249.tod4rqzn3udk6wmu@pd.tnic>
 <VI1PR04MB20786DE6AE24D4BB555E87C69AEB0@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180115232321.ojo3lfvces2q2qhm@pd.tnic>
 <VI1PR04MB207883AE86B7685B9D9DE3029AEB0@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180115235248.snzpl5cajfkudluw@pd.tnic>
Message-ID: <HE1PR04MB207371A103409F815745F49A9AFA0@HE1PR04MB2073.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/2018 03:52 PM, Borislav Petkov wrote:
> On Mon, Jan 15, 2018 at 11:28:14PM +0000, York Sun wrote:
>> It is generic ARM64 thing. I believe only SError interrupt is available.
> 
> So if it is, then I'd suggest you hammer out a proper design with the
> ARM folks.
> 

I made some progress and need some help on coding. On the platform I am
working on, it has A53 cores. Each A53 core has a signal nINTERRIRQ.
They are connected to one GIC interrupt. I managed to inject errors to
some safe address without triggering system error and I got the
interrupt. I will need to find out which core has errors by reading
register on each core (and clear the interrupt). How can I do this
within interrupt service routine? I tried to use
smp_call_function_single() but it doesn't like the IRQ being disabled.

Any suggestion is appreciated!

York
