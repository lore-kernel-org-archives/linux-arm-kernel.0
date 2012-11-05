From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Mon, 5 Nov 2012 14:14:48 +0530
Subject: [PATCHv2 3/7] i2c: omap: remove the dtrev
In-Reply-To: <20121105075320.GD32468@arwen.pp.htv.fi>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
 <1352025873-27492-4-git-send-email-shubhrajyoti@ti.com>
 <20121105075320.GD32468@arwen.pp.htv.fi>
Message-ID: <50977C80.8090000@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 November 2012 01:23 PM, Felipe Balbi wrote:
> Hi,
>
> On Sun, Nov 04, 2012 at 04:14:29PM +0530, Shubhrajyoti D wrote:
>> The dtrev is used only for the comments. Remove the same and use
>> the scheme instead to know if it is version2.
>>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> I would drop dtrev completely and not use scheme to "emulate" it.
However for ver2 ie omap4plus and previous versions the
register map is different.

So the scheme may still be required.
>  dtrev
> is wrong and unnecessary; it was only created due to the wrong
> assumption that HW revision register was wrong. Looks like that
> assumption was made based on the driver which is clearly wrong wrt
> revision detection.
>
> Also, when dropping dtrev, also drop it from platform_data and
> omap_hwmod database (could be done on a separate patch).
OK would do that.
>
