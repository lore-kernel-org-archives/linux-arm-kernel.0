From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Jun 2016 11:24:16 +0200
Subject: [PATCH 1/3] i.MX: system.c: Convert goto to if statement
In-Reply-To: <1465797329-22537-1-git-send-email-andrew.smirnov@gmail.com>
References: <1465797329-22537-1-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <12670937.kESCsuxMaL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, June 12, 2016 10:55:27 PM CEST Andrey Smirnov wrote:
> Using goto here doesn't bring any advantages and only makes the code
> flow less clear. No functional changes.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

All three patches looks reasonable to me, but now that I looked at
the function, I wonder if we could do another cleanup on top and
not call this function for imx35 at all but instead set the
.l2c_aux_val/.l2c_aux_mask fields in its machine descriptor.

The call to l2x0_of_init(0, ~0) seems to be the only thing we
do on imx35 (where arm,pl310-cache is not present), and the kernel
can do it automatically.

	Arnd
