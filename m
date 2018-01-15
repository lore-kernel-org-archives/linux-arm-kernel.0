From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 15 Jan 2018 14:21:54 +0000
Subject: EDAC driver for ARMv8 L1/L2 cache
In-Reply-To: <20180113113156.nnmkuh25rilzwf4p@pd.tnic>
References: <VI1PR04MB20788AC2E71A3CFFC37B85BB9A100@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <bc8d7450-3f58-95c2-42c2-d16b2f7a76e4@linux.intel.com>
 <VI1PR04MB20786CC3E2981C0F60E095079A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180112171251.4ricaz3lzditr7pi@pd.tnic>
 <VI1PR04MB2078B4491702765BA546C5539A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180112173802.kb32zrxc5uhsjlxk@lakrids.cambridge.arm.com>
 <VI1PR04MB20780EF853A0822A6EFCFE449A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180112180048.srniseo2ft7ytqve@lakrids.cambridge.arm.com>
 <VI1PR04MB2078FCB86150A2AABFE7AB439A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180113113156.nnmkuh25rilzwf4p@pd.tnic>
Message-ID: <20180115142154.rj6cgnhlll7ivyew@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 13, 2018 at 12:31:56PM +0100, Borislav Petkov wrote:
> Btw,
> 
> I jus received a driver for this:
> 
> https://lkml.kernel.org/r/1515804626-21254-1-git-send-email-kyan at codeaurora.org
> 
> and I think you guys should first talk and do one version which works
> for all.

Unfortunately, in the asbence of the RAS extensions, any EDAC
functionality is IMPLEMENTATION DEFINED, and each CPU does it
differently, with different registers and no common programming model.

The driver linked above is *not* a generic ARMv8 EDAC driver. AFAICT< it
is specific to some Qualcomm Kryo CPUs. I'll reply there.

> 
> Adding Kyle to CC.
> 
> @Kyle: there's also a driver here: https://patchwork.kernel.org/patch/7513231
> 
> Also, looking at it, you probably should call it arm64_edac or so, to
> be clear what it is. armv8 - although known to ARM people - makes me go
> look at wikipedia to refresh what v8 was again.

I'm not sure it's possible to cover all potential EDAC implementations
behind the same driver.

If we need these drivers, they should be <cpuname>_edac or <soc>_edac.

Thanks,
Mark.
