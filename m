From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 7 May 2013 18:32:44 +0200
Subject: [PATCH 1/3] clk: mvebu: add gate ctrl for Prestera kirkwood
 variants
In-Reply-To: <518927C0.6070600@free-electrons.com>
References: <1367941941-19152-1-git-send-email-valentin.longchamp@keymile.com>
 <1367941941-19152-2-git-send-email-valentin.longchamp@keymile.com>
 <518927C0.6070600@free-electrons.com>
Message-ID: <20130507163244.GD9994@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 07, 2013 at 06:11:44PM +0200, Gregory CLEMENT wrote:
> On 05/07/2013 05:52 PM, Valentin Longchamp wrote:
> > The kirkwood device found in the Prestera SoCs does not have all the
> > peripherals of its the usual kirkwood SoCs. There are hence missing
> > clocks in the SoCs.
> > 
> > This patch registers another gate controller for the kirkwood that
> > registers only the available clocks of this kirkwood variant.
> 
> Hi Valentin,
> 
> Overall the patch set looks OK, however I don't understand why you need
> to declare a new gate controller. The list you delcared seemed to be
> just a subset of the Kirkwood one, why can't you use this one?

Hi Gregory

Take a look at the code which gets deleted in patch 3/3.

       /*
        * Our variant of kirkwood (integrated in the Bobcat) hangs on accessing
        * SATA bits (14-15) of the Clock Gating Control Register. Since these
        * devices are also not present in this variant, their clocks get
        * disabled because unused when clk_disable_unused() gets called.
        * That's why we change the flags to these clocks to CLK_IGNORE_UNUSED
        */

By not defining these clocks in the first place, they never get turned
off...

	Andrew
