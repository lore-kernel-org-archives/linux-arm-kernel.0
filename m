From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 28 Mar 2013 12:30:50 +0000
Subject: [PATCH v3 12/12] clocksource: samsung-time: Add Device Tree
 support
In-Reply-To: <1362860601-18464-13-git-send-email-tomasz.figa@gmail.com>
References: <1362860601-18464-1-git-send-email-tomasz.figa@gmail.com>
 <1362860601-18464-13-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130328123049.GX18316@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 09, 2013 at 09:23:21PM +0100, Tomasz Figa wrote:

> +CLOCKSOURCE_OF_DECLARE(s3c24xx_timer,
> +				"samsung,s3c24xx-pwm", samsung_of_timer_init)
> +CLOCKSOURCE_OF_DECLARE(s3c64xx_timer,
> +				"samsung,s3c64xx-pwm", samsung_of_timer_init)

This doesn't build for me in a non-OF configuration, though this seems
to be something that CLOCKSOURCE_OF_DECLARE ought to fix rather than
your series - I've sent a patch for that.  

It also won't build in an OF configuration with latest -next I think
since commit 4d10f054 (clocksource: make CLOCKSOURCE_OF_DECLARE type
safe) removed the semicolon the macro provided - we need them at the end
of each line here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130328/3c19c7af/attachment-0001.sig>
