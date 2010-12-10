From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 09 Dec 2010 16:14:44 -0800
Subject: [PATCH 13/11] OMAP2+: GPIO: ensure bank wakeups are enabled by
	default
In-Reply-To: <20101210000750.GM3054@atomide.com> (Tony Lindgren's message of
	"Thu, 9 Dec 2010 16:07:50 -0800")
References: <1290689318-10191-1-git-send-email-charu@ti.com>
	<1291923226-10112-1-git-send-email-khilman@deeprootsystems.com>
	<20101210000750.GM3054@atomide.com>
Message-ID: <87vd324h6z.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@deeprootsystems.com> [101209 11:33]:
>> As part of the GPIO conversion to platform_device/platform_driver,
>> commit 2fae7fbed072705d91e09ed393b2e580b2d895fc (OMAP: GPIO: prepare
>> for platform driver) removed hard-coded per-bank SYSCONFIG register
>> values in favor of using omap_hwmod to manage the SYSCONFIG register.
>> 
>> In the previous code, bank-level wakeups were enabled by default using
>> the SYSCONFIG.ENAWAKEUP bit, but omap_hwmod does not enable wakeups by
>> default.  Thus the above commit effectively disabled GPIO bank wakeups.
>> 
>> This patch enables GPIO bank level wakeups by default to preserve
>> previous functionality.
>
> So this patch is no longer needed, right?

Yup, you beat me to it.

This is actually a problem in the omap_hwmod core, and I posted a
separate patch[1] to fix that problem.

Kevin

[1] http://marc.info/?l=linux-omap&m=129193625420446&w=2
