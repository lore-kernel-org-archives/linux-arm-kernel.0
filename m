From: tony@atomide.com (Tony Lindgren)
Date: Wed, 8 Feb 2012 10:56:50 -0800
Subject: [PATCH 15/16] ARM: omap: resolve nebulous 'Error setting
 wl12xx data'
In-Reply-To: <E1RvAZf-0006Hm-40@rmk-PC.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAZf-0006Hm-40@rmk-PC.arm.linux.org.uk>
Message-ID: <20120208185650.GO29796@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:09]:
> It's useful to print the error code when a called function fails so a
> diagnosis of why it failed is possible.  In this case, it fails because
> we try to register some data for the wl12xx driver, but as the driver
> is not configured, a stub function is used which simply returns -ENOSYS.
> 
> Let's do the simple thing for -rc and print the error code.
> 
> Also, the return code from platform_register_device() at each of these
> sites was not being checked.  Add some checking, and again print the
> error code.
> 
> This should be fixed properly for the next merge window so we don't
> issue error messages merely because a driver is not configured.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Looks right to me for -rc. Yes let's plan on fixing this for v3.4.

Acked-by: Tony Lindgren <tony@atomide.com>
