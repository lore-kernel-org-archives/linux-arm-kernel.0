From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Feb 2016 23:14:28 -0800
Subject: [PATCH 6/8] drivers/pinctrl: make sunxi/pinctrl-sun[4-9]*
 explicitly non-modular
In-Reply-To: <1456778924-20730-7-git-send-email-paul.gortmaker@windriver.com>
References: <1456778924-20730-1-git-send-email-paul.gortmaker@windriver.com>
 <1456778924-20730-7-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <20160301071428.GK8418@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 03:48:42PM -0500, Paul Gortmaker wrote:
> None of the Kconfigs for any of these drivers are tristate,
> meaning that they currently are not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the drivers there is no doubt they are builtin-only.  All
> drivers get the exact same change, so they are handled in batch.
> 
> Changes are (1) use builtin_platform_driver, (2) use init.h header
> (3) delete module_exit related code, (4) delete MODULE_DEVICE_TABLE,
> and (5) delete MODULE_LICENCE/MODULE_AUTHOR and associated tags.
> 
> Since module_platform_driver() uses the same init level priority as
> builtin_platform_driver() the init ordering remains unchanged with
> this commit.
> 
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> 
> We also delete the MODULE_LICENSE etc. tags since all that information
> is already contained at the top of each file in the comments.
> 
> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Vishnu Patekar <vishnupatekar0510@gmail.com>
> Cc: linux-gpio at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160229/8a9d8149/attachment.sig>
