From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 May 2010 11:16:16 +0100
Subject: [RFC] Initial attempt to make ARM use LMB
In-Reply-To: <AANLkTikZvfvjY9e2QNWRwVcJcTvn58Ly_DgzrcXKu2iJ@mail.gmail.com>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
	<20100505150209.GC2606@n2100.arm.linux.org.uk>
	<20100513174023.GB13001@n2100.arm.linux.org.uk>
	<20100513211951.GH3428@atomide.com>
	<20100513215825.GC13001@n2100.arm.linux.org.uk>
	<20100513220139.GO3428@atomide.com>
	<20100513221229.GD13001@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C54F0247@dbde02.ent.ti.com>
	<AANLkTikZvfvjY9e2QNWRwVcJcTvn58Ly_DgzrcXKu2iJ@mail.gmail.com>
Message-ID: <20100514101615.GF10339@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 14, 2010 at 01:11:43PM +0300, Grazvydas Ignotas wrote:
> It seems you are using DSS2/CONFIG_FB_OMAP2, looks like this patch is
> for DSS1/CONFIG_FB_OMAP.
> 
> DSS2 does have a problem on linux-next after 'ARM: Prohibit ioremap()
> on kernel managed RAM'

I'm going to drop that patch out - but that's not to say it won't return
(it will.)

> because it also uses reserve_bootmem() in
> drivers/video/omap2/vram.c and later ioremap on RAM. Perhaps LMB can
> be used to fix that too?

WTF is reserve_bootmem doing in a driver?
