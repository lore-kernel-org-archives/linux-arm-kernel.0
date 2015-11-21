From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 20 Nov 2015 19:48:48 -0500 (EST)
Subject: [PATCH] mtd: maps: kill DC21285 driver
In-Reply-To: <1448058755-45834-1-git-send-email-computersforpeace@gmail.com>
References: <1448058755-45834-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <alpine.LFD.2.20.1511201942420.22569@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Nov 2015, Brian Norris wrote:

> This driver wouldn't build for over 5 years, between commit:
> 
>   bd31b85960a7 ("locking, ARM: Annotate low level hw locks as raw")
> 
> and
> 
>   e5babdf928e5 ("mtd: dc21285: use raw spinlock functions for nw_gpio_lock")
> 
> Also, it's unsafe to build into arbitrary kernels, as it might just
> start probing around memory, whether or not there's a compatible flash
> there. See comments here, last time someone tried to enable it:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/347133.html
> 
> So, let's kill it. I bet no one will notice.

Waow.  And I'm apparently the author.  Last time I had access to 
hardware that could use it was in 2001.

Now I suppose this depends if there are still people with Netwinders out 
there, and if they're interested in having mainline running on it.


Nicolas
