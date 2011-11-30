From: khilman@ti.com (Kevin Hilman)
Date: Wed, 30 Nov 2011 15:39:16 -0800
Subject: [PATCH-V4 0/3] Introducing TI's New SoC/board AM335XEVM
In-Reply-To: <1320946837-32507-1-git-send-email-hvaibhav@ti.com> (Vaibhav
 Hiremath's message of "Thu, 10 Nov 2011 23:10:34 +0530")
References: <1320946837-32507-1-git-send-email-hvaibhav@ti.com>
Message-ID: <878vmxxjrv.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> This patch set adds support for AM335x device having
> Cortex-A8 MPU.
>
> Official website - http://www.ti.com/product/am3359
>
> AM335X is treated as another OMAP3 variant, where,
> along with existing cpu class OMAP34XX, new cpu class AM33XX is created
> and the respective type is AM335X, which is newly added device in
> the family.
> This means, cpu_is_omap34xx(), cpu_is_am33xx() and
> cpu_is_am335x() checks return success for AM335X.
>
> Also, I have validated OMAP3 boot test with this patch-series on OMAP3EVM.

After fixing the minor comment on patch 3/3, feel free to add:

Reviewed-by: Kevin Hilman <khilman@ti.com>

Also, I was surprised to discover that this booted on my (recently
arrived) BeagleBone.  It seems that u-boot (from Angstrom) is passing
the machine ID of the AM335x EVM[1], even though there is another
machine ID for the BeagleBone[2].  Is that expected?

I also see that the mach-types for this are in Russell's for-next
branch.  In order for us to merge this into Tony's master branch, we'll
need to see if Russell can pull the mach-types updates into
devel-stable.  Russell?

Kevin

[1] http://www.arm.linux.org.uk/developer/machines/list.php?id=3589
[2] http://www.arm.linux.org.uk/developer/machines/list.php?id=3808
