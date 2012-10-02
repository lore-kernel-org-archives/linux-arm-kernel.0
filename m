From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 2 Oct 2012 10:37:53 +0100
Subject: [alsa-devel] [PATCH 2/3] ASoC: Davinci: pcm: add support for
 sram-support-less platforms
In-Reply-To: <506A9C65.5040309@ti.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
 <1346417459-30042-3-git-send-email-gururaja.hebbar@ti.com>
 <20120922153313.GN4495@opensource.wolfsonmicro.com>
 <506A9C65.5040309@ti.com>
Message-ID: <20121002093753.GU4360@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2012 at 10:48:53AM +0300, Peter Ujfalusi wrote:

> I also agree that ifdef is not a good solution.
> It is better to have this information passed as device_data and via DT it can
> be decided based on the compatible property for the device.

That's not really the problem here - the problem is that the APIs used
to get the SRAM are DaVinci only so it's not possible to build on OMAP
or other platforms.  The SRAM code needs to move to a standard API.
