From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Thu, 25 Aug 2011 17:52:15 +0530
Subject: [PATCH v4] OMAP4: hwmod data: I2C: add flag for context restore
In-Reply-To: <87mxeyg98m.fsf@ti.com>
References: <1310906603-2673-1-git-send-email-shubhrajyoti@ti.com>	<4E54D012.6050708@ti.com>
	<87mxeyg98m.fsf@ti.com>
Message-ID: <4E563E77.6090200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 August 2011 08:14 PM, Kevin Hilman wrote:
> Shubhrajyoti<shubhrajyoti@ti.com>  writes:
>
>> On Sunday 17 July 2011 06:13 PM, Shubhrajyoti D wrote:
>>> Restore of context is not done for OMAP4. This patch
>>> adds the OMAP_I2C_FLAG_RESET_REGS_POSTIDLE in the OMAP4
>>> hwmod data which activates the restore for OMAP4.
>>> Currently the OMAP4 does not hit device off still the
>>> driver may have support for it.
>> Could this patch be queued as well?
> Paul is the maintainer for the hwmod data.   It is usually helpful to
> ensure the maintainer is specifically added to the To line.
yes thanks will take care henceforth . For now adding him for comments.
> Kevin
>
>>> Reviewed-by: Kevin Hilman<khilman@ti.com>
>>> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
>>> ---
>>> Applies on top of patches from Andy Green
>>> http://www.spinics.net/lists/linux-i2c/msg05632.html
>>> Tested on OMAP4430
>>>
>>>    arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 ++-
>>>    1 files changed, 2 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> index 0fe9556..5e2c748 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> @@ -2130,7 +2130,8 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
>>>    };
>>>
>>>    static struct omap_i2c_dev_attr i2c_dev_attr = {
>>> -	.flags  = OMAP_I2C_FLAG_BUS_SHIFT_NONE,
>>> +	.flags  = OMAP_I2C_FLAG_BUS_SHIFT_NONE |
>>> +			OMAP_I2C_FLAG_RESET_REGS_POSTIDLE,
>>>    };
>>>
>>>    /* i2c1 */
