From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 5 Jul 2012 10:08:52 -0300
Subject: [PATCH 1/1] mfd: Fix runtime warning caused by duplicate device
 registration
In-Reply-To: <1341316788-12730-1-git-send-email-lee.jones@linaro.org>
References: <1341316788-12730-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CAOMZO5BQuJzAYPe+B792aNYv+xew3O0wp-UOjwggV28MbSZr9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Tue, Jul 3, 2012 at 8:59 AM, Lee Jones <lee.jones@linaro.org> wrote:
> We register the ab8500 as an MFD device from db8500 code during Device Tree
> boot in order to solve some limitations of DT. However, when Device Tree is
> not enabled, we still want to allow platform code to register the ab8500 in
> the normal way. Here we force MFD device registration of the ab8500 only
> when booting with Device Tree enabled.
>
> Solves this issue:
> WARNING: at fs/sysfs/dir.c:526 sysfs_add_one+0x88/0xb0()
> sysfs: cannot create duplicate filename '/bus/platform/devices/ab8500-core.0'

Does the following patch fix your issue?
http://www.spinics.net/lists/arm-kernel/msg182827.html

Regards,

Fabio Estevam
