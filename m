From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 6 Feb 2012 16:09:07 +0000
Subject: [PATCH 1/4] i2c/gpio-i2c add: add DT support
In-Reply-To: <1328438337-21185-1-git-send-email-plagnioj@jcrosoft.com>
References: <1328438337-21185-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20120206160907.GG10173@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 05, 2012 at 11:38:53AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:

> +	- udelay: half clock cycle time in us (may depend on each platform)

> +	udelay = <2>;		/* ~100 kHz */

Why not specify this in kHz and do the conversion in the driver?  It
seems a more intuitive thing to be specifying.  I appreciate that the
platform data used udelay but it seems an entirely unintuitive thing
from a user point of view even if it's what the implementation wants.
