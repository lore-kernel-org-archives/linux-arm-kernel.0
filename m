From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 10 Aug 2012 20:50:08 +0100
Subject: Lockups reading from i.MX51 SSI registers
Message-ID: <20120810195005.GP24328@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm trying to use -next to test AC'97 register I/O on an i.MX51 board
but I'm seeing the CPU hang during probe at:

	lreg = (reg & 0x7f) <<  12 ;
	writel(lreg, base + SSI_SACADD);

in imx_ssi_ac97_read().  I'm somewhat suspicious this might be because
the IP block isn't clocked properly, I do notice the recent conversion
to the clock API which looks rather involved but it's possible something
else broke.  Does anyone have any bright ideas what might be going on
here?  The board doesn't have the reste functions defined so this is the
first interaction with the hardware block AFAICT.

Thanks,
Mark
