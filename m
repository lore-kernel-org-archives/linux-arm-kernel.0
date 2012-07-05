From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 05 Jul 2012 14:13:57 +0100
Subject: [PATCH 1/1] mfd: Fix runtime warning caused by duplicate device
 registration
In-Reply-To: <CAOMZO5BQuJzAYPe+B792aNYv+xew3O0wp-UOjwggV28MbSZr9w@mail.gmail.com>
References: <1341316788-12730-1-git-send-email-lee.jones@linaro.org>
 <CAOMZO5BQuJzAYPe+B792aNYv+xew3O0wp-UOjwggV28MbSZr9w@mail.gmail.com>
Message-ID: <4FF59315.2040105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

> On Tue, Jul 3, 2012 at 8:59 AM, Lee Jones <lee.jones@linaro.org> wrote:
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
> Does the following patch fix your issue?
> http://www.spinics.net/lists/arm-kernel/msg182827.html

No, it's unrelated.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
