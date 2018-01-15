From: york.sun@nxp.com (York Sun)
Date: Mon, 15 Jan 2018 23:28:14 +0000
Subject: EDAC driver for ARMv8 L1/L2 cache
References: <20180112171251.4ricaz3lzditr7pi@pd.tnic>
 <VI1PR04MB2078B4491702765BA546C5539A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180112173802.kb32zrxc5uhsjlxk@lakrids.cambridge.arm.com>
 <VI1PR04MB20780EF853A0822A6EFCFE449A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180112180048.srniseo2ft7ytqve@lakrids.cambridge.arm.com>
 <VI1PR04MB2078FCB86150A2AABFE7AB439A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180113113156.nnmkuh25rilzwf4p@pd.tnic>
 <20180115142154.rj6cgnhlll7ivyew@lakrids.cambridge.arm.com>
 <20180115143249.tod4rqzn3udk6wmu@pd.tnic>
 <VI1PR04MB20786DE6AE24D4BB555E87C69AEB0@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180115232321.ojo3lfvces2q2qhm@pd.tnic>
Message-ID: <VI1PR04MB207883AE86B7685B9D9DE3029AEB0@VI1PR04MB2078.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/2018 03:23 PM, Borislav Petkov wrote:
> On Mon, Jan 15, 2018 at 04:19:09PM +0000, York Sun wrote:
>> I have different plan on the driver. Since I don't get interrupt on
>> correctable errors,
> 
> Is that something nxp-specific or generic ARM64 thing?
> 
> If it is the former, then you'd need a special driver for your hardware,
> as much as I don't like the idea of having per-vendor driver...
> 
It is generic ARM64 thing. I believe only SError interrupt is available.
But SError can be caused by many reasons. For L1/L2 only uncorrectable
errors trigger SError. My first step is to deal with correctable errors
and to raise a flag somehow (Haven't think that through yet) when
excessive errors are reported. Next step I will deal with the
uncorrectable errors with interrupt.

York
