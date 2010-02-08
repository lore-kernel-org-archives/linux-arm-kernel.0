From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 8 Feb 2010 19:05:08 +0100
Subject: [PATCH] input: mark {corgi,spitz,tosa}kbd driver deprecated
In-Reply-To: <f17812d71002041631o25e63574t4cf13d21dc759dff@mail.gmail.com>
References: <f17812d71002041631o25e63574t4cf13d21dc759dff@mail.gmail.com>
Message-ID: <20100208180507.GA1469@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

>     input: mark {corgi,spitz,tosa}kbd driver deprecated
> 
>     Provided that now keyboards on these devices are now fully supported
>     by generic GPIO based matrix keypad driver, mark these hardcoded, and
>     difficult to maintain drivers deprecated in favour of this.
> 
>     Cc: Richard Purdie <rpurdie@rpsys.net>
>     Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>     Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

ACK, but..

> @@ -329,13 +332,16 @@ config KEYBOARD_PXA930_ROTARY
>  	  module will be called pxa930_rotary.
> 
>  config KEYBOARD_SPITZ
> -	tristate "Spitz keyboard"
> +	tristate "Spitz keyboard (deprecated)"
>  	depends on PXA_SHARPSL
>  	default y

Default should be N, and config option probably should be removed
altogether -- with recent mach_spitz, keyboard_spitz will not be bound
to the hw, anyway... right?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
