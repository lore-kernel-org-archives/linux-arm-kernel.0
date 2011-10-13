From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 13 Oct 2011 15:27:22 +0100
Subject: [PATCH 4/9] ARM: SPMP8000: Add ADC driver
In-Reply-To: <201110131619.39303.arnd@arndb.de>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<20111013113506.GJ1098@sirena.org.uk>
	<20111013121745.GU21648@n2100.arm.linux.org.uk>
	<201110131619.39303.arnd@arndb.de>
Message-ID: <20111013142722.GN1098@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 04:19:39PM +0200, Arnd Bergmann wrote:

> Of course, if the spmp8000 adc driver gets put into staging, all its
> dependencies (input, battery) also have to go there because no
> regular driver must link against interfaces provided by a staging
> driver.

Yes, that's the big problem with this - it blocks the actual drivers.
Putting it in drivers/misc would be another option that sidesteps that.
