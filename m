From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Dec 2016 19:16:51 +0000
Subject: [PATCH v3 11/12] arm64: dts: marvell: add sdhci support for
 Armada 7K/8K
In-Reply-To: <87bmwhdrx7.fsf@free-electrons.com>
References: <cover.e0137cef24a16a2c7d795548de554993595d4a98.1481279228.git-series.gregory.clement@free-electrons.com>
 <923c97f32a828b579756bf86946689ed54a0a174.1481279228.git-series.gregory.clement@free-electrons.com>
 <20161209200729.GO14217@n2100.armlinux.org.uk>
 <87bmwhdrx7.fsf@free-electrons.com>
Message-ID: <20161212191651.GV14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2016 at 05:37:56PM +0100, Gregory CLEMENT wrote:
> Hi Russell King,
>  
>  On ven., d?c. 09 2016, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> 
> > On Fri, Dec 09, 2016 at 11:30:07AM +0100, Gregory CLEMENT wrote:
> >> Also enable it on the Armada 7040 DB board
> >> 
> >> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >
> > Hi,
> >
> > Can this also be added to the cp110 on the 7k/8k SoCs as well, or does
> > it rely on other unmerged support?
> 
> I did not add this one because until now I had not the hardware setup
> available to test it.
> 
> But at least I can add the ressources in the device tree and now I can
> test it partially.

There's another option: add the DT resources in a separate patch, send
it out for someone else to test.  When it comes back with a tested-by,
then it can be included along with the rest of the patch set.

I'd send something, but I don't know what the GIC interrupt number
would be without using the CP110's ICU (which isn't supported in
mainline yet.)  I've already tested your previous patch set (along with
ICU support + needed DT bits) on the SR Macchiatobin board... it seems
to work fine.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
