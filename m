From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 27 Aug 2012 11:08:25 -0700
Subject: [PATCH V2 4/6] ASoC: Davinci: McASP: add device tree support for
 McASP
In-Reply-To: <1346074004-22172-5-git-send-email-gururaja.hebbar@ti.com>
References: <1346074004-22172-1-git-send-email-gururaja.hebbar@ti.com>
 <1346074004-22172-5-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <20120827180824.GR4339@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2012 at 06:56:42PM +0530, Hebbar, Gururaja wrote:

> +- sram-size-playback : size of sram to be allocated during playback
> +- sram-size-capture  : size of sram to be allocated during capture

These smell like runtime/policy configuration rather than fixed
properties of the device so it probably shouldn't appear in the device
tree, ideally at some point in the future we'll be able to work out some
wonderful way of automatically allocating the resources.

That said if the rest of the series looks OK I'll apply this but it'd be
nice to get these numbers from somewhere else.
