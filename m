From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 11 Feb 2014 15:35:29 +0100
Subject: [PATCH] ARM: dts: OMAP2+: Fix boot with multi_v7_defconfig
In-Reply-To: <52FA3102.7080407@ti.com>
References: <1392055835-6494-1-git-send-email-rogerq@ti.com>
 <52FA2B4F.3010408@ti.com> <52FA3102.7080407@ti.com>
Message-ID: <52FA3531.8090308@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/11/2014 03:17 PM, Nishanth Menon wrote:
> On 02/11/2014 07:53 AM, Roger Quadros wrote:
>> On 02/10/2014 08:10 PM, Roger Quadros wrote:
>>> The OMAP EHCI controller is not compatible with the EHCI
>>> platform HCD driver so don't claim that we are.
>>>
>>> This fixes boot on OMAP platforms with CONFIG_USB_EHCI_HCD_PLATFORM=y
>>> e.g. multi_v7_defconfig
>>>
>>> Reported-by: Nishanth Menon <nm@ti.com>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>
>> Please ignore this patch as Hans has agreed to do a more proper fix in
>>
>> http://article.gmane.org/gmane.comp.hardware.netbook.arm.sunxi/7015
> umm.. even then, drivers/usb/host/ehci-ppc-of.c claims compatibility
> with usb,ehci -> and we wont function with that driver either.

Right, but that has never been an issue as no kernel will ever include
both ppc and omap support.

Regards,

Hans
