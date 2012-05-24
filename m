From: lethal@linux-sh.org (Paul Mundt)
Date: Thu, 24 May 2012 23:59:03 +0900
Subject: [PATCH] Drop superfluous setting of i2c_board_info.type
In-Reply-To: <1337870303.22505.20.camel@x61.thuisdomein>
References: <1337870303.22505.20.camel@x61.thuisdomein>
Message-ID: <20120524145903.GF11860@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2012 at 04:38:23PM +0200, Paul Bolle wrote:
> Three instances of struct i2c_board_info have their "type" member set to
> "tsc2007" twice. First through the I2C_BOARD_INFO macro and then
> directly. Drop the superfluous second setting.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> 0) Entirely untested. I'm unsure what toolchain(s) is (are) needed to
> compile this and I am certain that I don't have the hardware.
> 
> 1) This is apparently legal. Doesn't gcc issue a warning for this?
> 
That's a new one to me. Seems legal enough. Using this feature you can
use macro initializion for the bulk of structure elements and then just
overload the ones you disagree with to save time, neat yet revolting at
the same time, there was definitely a committee involved in this.
