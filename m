From: tony@atomide.com (Tony Lindgren)
Date: Mon, 6 Jul 2015 05:16:10 -0700
Subject: [PATCH] Revert "ARM: dts: am335x-boneblack: disable RTC-only
 sleep"
In-Reply-To: <1434032318-3557-1-git-send-email-johan@kernel.org>
References: <20150601200137.GC30984@atomide.com>
 <1434032318-3557-1-git-send-email-johan@kernel.org>
Message-ID: <20150706121609.GD10705@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Johan Hovold <johan@kernel.org> [150611 07:20]:
> This reverts commit 3d76be5b933e2a66d85a2f7444e68e99e8a48ad4.
> 
> The latest revision of Beaglebone Black does not support RTC-only mode.
> 
> To avoid potential hardware damage, RTC-only mode was disabled by
> default by commit 7a6cb0abe1aa ("ARM: dts: am335x-boneblack: disable
> RTC-only sleep to avoid hardware damage").
> 
> Unfortunately, an incorrect fix had already been applied, which instead
> of just disabling RTC-only mode, prevents the Beaglebone from powering
> down at all.
> 
> Revert this patch to fix the power-off regression.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
> 
> The offending patch was incorrectly applied after Matthijs initial fix
> was posted and before the final fix (which only added some comments) was
> applied.
> 
> Note that the final version of the fix 7a6cb0abe1aa ("ARM: dts:
> am335x-boneblack: disable RTC-only sleep to avoid hardware damage")
> indicates that it should be backported to 3.12 even though RTC-only mode
> was first enabled in 3.19.

Applying this now into omap-for-v4.2/fixes.

Regards,

Tony
