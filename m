From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 26 Jul 2012 22:05:51 +0000
Subject: Orion Pull request
In-Reply-To: <20120726183941.GC15626@lunn.ch>
References: <20120724081732.GR18778@lunn.ch>
 <201207260707.45157.arnd@arndb.de> <20120726183941.GC15626@lunn.ch>
Message-ID: <201207262205.52381.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 26 July 2012, Andrew Lunn wrote:
> So, here is what i think you mean....
> 
> The SPI pull request is here:
> 
> https://lkml.org/lkml/2012/7/25/204
> 
> and says
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git tags/spi-3.6
> 
> I cannot find a pull request for i2c-embedded for 3.6. For 3.5 it was:
> 
> git://git.pengutronix.de/git/wsa/linux.git i2c-embedded/for-next
> 
> I've no idea if this is stable or not. I need to ask Wolfram.

Right. 

> :~/B3/QNAP/linux$ git checkout v3.5-rc7   
> :~/B3/QNAP/linux$ git checkout -b v3.5-rc7-dt
> :~/B3/QNAP/linux$ git remote add spi git://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git
> :~/B3/QNAP/linux$ git fetch spi
> :~/B3/QNAP/linux$ git merge spi-3.6
> :~/B3/QNAP/linux$ git remote add i2c-embedded git://git.pengutronix.de/git/wsa/linux.git
> :~/B3/QNAP/linux$ git fetch i2c-embedded
> :~/B3/QNAP/linux$ git merge i2c-embedded/i2c-embedded/for-next

Note that it's also reasonable to base this on v3.5 rather than v3.5-rc7. The important
part is to use a tag from Linus as the base. A shortcut for the 'remote add', 'fetch',
'merge' is to use

'git pull git://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git tags/spi-3.6'.

> and then i have
> 
> ~/B3/QNAP/linux$ git log --oneline
> afddda0 Merge remote-tracking branch 'i2c-embedded/i2c-embedded/for-next' into v
> 0a6f855 Merge tag 'spi-3.6' into v3.5-rc7-dt
> 5db20c4 Revert "i2c: tegra: convert normal suspend/resume to *_noirq"
> b61d157 I2C: MV64XYZ: Add Device Tree support
> 8ceffa7 spi/orion: remove uneeded spi_info
> d76ea24 spi/bcm63xx: fix clock configuration selection
> f814f9a spi/orion: add device tree binding
> 24ab3275 spi/omap2: mark omap2_mcspi_master_setup as __devinit
> a3ce9a8 spi: omap2-mcspi: Fix the below warning
> b316590 spi: Add AD-FMCOMMS1-EBZ I2C-SPI bridge driver
> 6f535b9 i2c: stu300: use devm managed resources
> 84a1caf Linux 3.5-rc7
> ...
> 
> So if i understand you right, i can now cherry-pick my patches into
> this branch, test them and send you a pull request?

Yes.

	Arnd
