From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 14 Dec 2013 12:30:24 -0500
Subject: [PATCH CRITICAL] ARM: s3c64xx: dt: Fix boot failure due to double
 clock initialization
In-Reply-To: <52AC4568.7030201@gmail.com>
References: <1386964779-29457-1-git-send-email-tomasz.figa@gmail.com>
 <201312140400.16794.arnd@arndb.de> <52AC4568.7030201@gmail.com>
Message-ID: <52AC95B0.7090303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 14 December 2013 06:47 AM, Sebastian Hesselbarth wrote:

[..]

> From 4ef4720c0d7ca9be57b06dc7ab1483c77a5ada1d Mon Sep 17 00:00:00 2001
> From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Date: Sat, 14 Dec 2013 12:21:01 +0100
> Subject: [PATCH] ARM: keystone: remove call to of_clk_init
> 
> Commit
> 
> 4178bac ARM: call of_clk_init from default time_init handler
> 
> added implicit call to of_clk_init(NULL) from default time_init callback.
> This causes double clock initialization on keystone, leading to boot
> failures.
> 
> This patch fixes boot failure on keystone by dropping the call to
> of_clk_init(NULL) in keystone_pm_runtime_init(), which is set as
> subsys_initcall and therefore called after arch-wide .init_time callback.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
I already have a patch [1] for this in my queue. Thanks

Regards,
Santosh
[1] http://www.spinics.net/lists/arm-kernel/msg288578.html
