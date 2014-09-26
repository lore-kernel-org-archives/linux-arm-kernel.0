From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 26 Sep 2014 15:02:22 +0200
Subject: [GIT PULL] at91: soc for 3.18 #2
In-Reply-To: <201409261250.02565.arnd@arndb.de>
References: <1411391733-28891-1-git-send-email-nicolas.ferre@atmel.com>
 <201409261250.02565.arnd@arndb.de>
Message-ID: <20140926130222.GA4408@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 26/09/2014 at 12:50:02 +0200, Arnd Bergmann wrote :
> On Monday 22 September 2014, Nicolas Ferre wrote:
> 
> > Nicolas Ferre (4):
> >       ARM: at91: introduce basic SAMA5D4 support
> >       ARM: at91: SAMA5D4 SoC detection code and low level routines
> 
> This resulted in build failures both in at91x40_defconfig and some
> randconfigs with MMU disabled. I've applied the patch below on top
> to fix it.
> 
> I'm not exactly happy about the soc detection code anyway after I
> had to look at that. Why do you even hardcode the physical register
> location rather than getting it from DT?
> 
> Also, why do you care about which SoC version you have for the
> modern SAMA5 chips? All I see is a sama5d4_map_io() callback
> that maps a lot of completely unused registers along with
> the uart that you normally get from the implicit debug_ll_io_init,
> and the SRAM that should probably be turned into a normal driver.
> 

Yeah, there are upcoming patches that add more differences between
sama5d3 and sama5d4. Also, a huge cleanup is planned after all the
boards files have been removed and all the boards have been either
migrated to DT and CCF or dropped.

I'll owe you the drink of your choice if that is not done by 3.20 ;)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
