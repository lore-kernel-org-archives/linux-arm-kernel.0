From: error27@gmail.com (Dan Carpenter)
Date: Wed, 2 Jan 2013 08:10:36 +0300
Subject: [PATCH RESEND 6/6] clk: s5p-g2d: Fix incorrect usage of
 IS_ERR_OR_NULL
In-Reply-To: <50E32C06.5020104@gmail.com>
References: <1355852048-23188-1-git-send-email-linux@prisktech.co.nz>
 <1355852048-23188-7-git-send-email-linux@prisktech.co.nz>
 <50D62BC9.9010706@mvista.com> <50E32C06.5020104@gmail.com>
Message-ID: <CA+_b7DK2zbBzbCh15ikEAeGP5h-V9gQ_YcX15O-RNvWxCk8Zfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_get() returns NULL if CONFIG_HAVE_CLK is disabled.

I told Tony about this but everyone has been gone with end of year
holidays so it hasn't been addressed.

Tony, please fix it so people don't apply these patches until
clk_get() is updated to not return NULL.  It sucks to have to revert
patches.

regards,
dan carpenter
