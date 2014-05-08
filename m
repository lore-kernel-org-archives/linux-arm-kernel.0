From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 8 May 2014 08:59:31 -0700
Subject: [PATCH 1/2] input: fix ps2/serio module dependency
In-Reply-To: <1399560990-1402858-15-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-15-git-send-email-arnd@arndb.de>
Message-ID: <20140508155931.GA11672@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, May 08, 2014 at 04:56:26PM +0200, Arnd Bergmann wrote:
> @@ -71,7 +71,7 @@ config KEYBOARD_ATKBD
>  	default y
>  	select SERIO
>  	select SERIO_LIBPS2
> -	select SERIO_I8042 if X86
> +	select SERIO_I8042 if X86 || ARCH_MIGHT_HAVE_PC_SERIO

x86 also selects ARCH_MIGHT_HAVE_PC_SERIO so shouldn't this be

	select SERIO_I8042 if ARCH_MIGHT_HAVE_PC_SERIO

?

I can fix it up on my side if you agree.

Thanks.

-- 
Dmitry
