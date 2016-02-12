From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Feb 2016 21:35:26 +0100
Subject: [PATCH] Revert "ASoC: qcom: Specify LE device endianness"
In-Reply-To: <20160212200311.GB11402@sirena.org.uk>
References: <1455298217-15744-1-git-send-email-sboyd@codeaurora.org>
 <2686474.cvCA6vY47l@wuerfel> <20160212200311.GB11402@sirena.org.uk>
Message-ID: <4609707.AR30v8FONr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 February 2016 20:03:11 Mark Brown wrote:
> On Fri, Feb 12, 2016 at 08:48:58PM +0100, Arnd Bergmann wrote:
> 
> > which all look like they are regmap_mmio users as well. Do they 
> > suffer from the same problem?
> 
> Probably, yes.  It's only a problem if they're in systems that might
> otherwise run big endian successfully.
> 

The affected clock drivers seem to include all the qcom platforms,
so I assumed that whatever platform uses sound/soc/qcom/lpass-cpu.c
has to use one of those as well. Same thing for drivers/nvmem/qfprom.c.

lpc32xx probably won't support big-endian.

syscon is probably fine because it only sets that flag based on the
"little-endian" DT property and I don't see anything setting that
(except the one platform that did so incorrectly).

	Arnd
