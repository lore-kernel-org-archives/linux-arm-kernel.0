From: stigge@antcom.de (Roland Stigge)
Date: Mon, 18 Jun 2012 19:00:14 +0200
Subject: [PATCH 1/2] sound: tegra_wm8903: Adjust to of_get_named_gpio()
 change
In-Reply-To: <20120618164659.GV3974@opensource.wolfsonmicro.com>
References: <1340037743-12924-1-git-send-email-stigge@antcom.de>
 <20120618164659.GV3974@opensource.wolfsonmicro.com>
Message-ID: <4FDF5E9E.6060803@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2012 06:46 PM, Mark Brown wrote:
> On Mon, Jun 18, 2012 at 06:42:21PM +0200, Roland Stigge wrote:
>> of_get_named_gpio() was changed to return -EPROBE_DEFER in case of
>> gpios not probed yet. This patch adjusts tegra_wm8903 to this.
> 
> So, I saw from the other thread that this didn't actually happen yet - I
> guess the best thing is to merge this along with the changes for
> introducing -EPROBE_DEFER.

Basically, yes. But this would mean that doing via gpio, we would need
to pull other stuff from the sound tree over to gpio to build upon
because "my" tegra_* sound patches won't apply to the gpio branch currently.

Any hint welcome.

Thanks in advance,

Roland
