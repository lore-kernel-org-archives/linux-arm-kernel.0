From: rogerq@ti.com (Roger Quadros)
Date: Mon, 22 Apr 2013 10:23:57 +0300
Subject: linux-next ARM multi-platform randconfig errors
In-Reply-To: <20130419161257.GI10155@atomide.com>
References: <5170B4C6.1030300@gmail.com> <20130419161257.GI10155@atomide.com>
Message-ID: <5174E58D.8080800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-Kevin Hilman <khilman@ti.com>
+Kevin Hilman <khilman@deeprootsystems.com>

On 04/19/2013 07:12 PM, Tony Lindgren wrote:
> * Rob Herring <robherring2@gmail.com> [130418 20:11]:
>> Current errors in linux-next for ARM multi-platform randconfig builds.
>>
>> Rob
>>
>> arch/arm/mach-omap2/built-in.o:dss-common.c:(.init.text+0x6830): more undefined references to `usb_bind_phy' follow
> 
> Felipe & Roger, can you guys take a look at the usb_bind_phy issue
> in linux next? I have not seen that in the multiplatform randconfigs
> I've built, but I have had some omap2+ specific things enabled there.

These problems happen if USB_PHY is not enabled as a built-in driver.
I had pointed this out earlier [1] and Felipe should have a fix for it.

[1] https://lkml.org/lkml/2013/4/11/270

cheers,
-roger
