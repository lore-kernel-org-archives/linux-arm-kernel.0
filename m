From: greg@kroah.com (Greg KH)
Date: Tue, 9 Nov 2010 14:40:12 -0800
Subject: [PATCH] pl011: added clock management feature
In-Reply-To: <1289316637-7828-1-git-send-email-linus.walleij@stericsson.com>
References: <1289316637-7828-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20101109224012.GA21992@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 09, 2010 at 04:30:37PM +0100, Linus Walleij wrote:
> From: Grzegorz Sygieda <grzegorz.sygieda@tieto.com>
> 
> This patch allows to control the pl011 clock using set_termios
> callback. Any positive baudrate passed enables clock, otherwise
> disables. This saves a lot of power on submicron designs since
> we can clock off and disable unused UARTs.

That's nice, but it seems like an overload of what people traditionally
think of when it comes to baud rates.  Why not just power down ports
that are not open instead?

thanks,

greg k-h
