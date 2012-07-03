From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 03 Jul 2012 14:07:45 +0100
Subject: [PATCH 1/1] mfd: Fix runtime warning caused by duplicate device
 registration
In-Reply-To: <20120703123552.GC25995@sirena.org.uk>
References: <1341316788-12730-1-git-send-email-lee.jones@linaro.org>
 <20120703123552.GC25995@sirena.org.uk>
Message-ID: <4FF2EEA1.6080204@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/12 13:35, Mark Brown wrote:
> On Tue, Jul 03, 2012 at 12:59:48PM +0100, Lee Jones wrote:
>> We register the ab8500 as an MFD device from db8500 code during Device Tree
>> boot in order to solve some limitations of DT. However, when Device Tree is
>> not enabled, we still want to allow platform code to register the ab8500 in
>> the normal way. Here we force MFD device registration of the ab8500 only
>> when booting with Device Tree enabled.
>>
>> Solves this issue:
>> WARNING: at fs/sysfs/dir.c:526 sysfs_add_one+0x88/0xb0()
>> sysfs: cannot create duplicate filename '/bus/platform/devices/ab8500-core.0'
>
> Do we really want to create MFD cells like this (which are really Linux
> internal things and might vary if another OS or another version of Linux
> changes its internal abstractions) from the device tree?

We're not creating them. We're merely using current infrastructure.

Before, when we probed each device from Device Tree we came up against 
some fairly major limitations of the Device Tree. As a result, Arnd and 
I agreed that this was the way to go.

See c5395e7ed8f16cc7bb72a783de68659db5aed515 for a short description of 
the troubles we faced.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
