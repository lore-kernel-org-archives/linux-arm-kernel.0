From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 7 Sep 2015 13:06:10 +0200
Subject: [PATCH 1/4] ARM: multi_v7_defconfig: Enable common Rockchip
 devices/busses
In-Reply-To: <55ED6D35.6060704@rock-chips.com>
References: <1441570566-14001-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1441570566-14001-2-git-send-email-sjoerd.simons@collabora.co.uk>
 <55ED585B.9030009@osg.samsung.com> <1441621467.8778.26.camel@collabora.co.uk>
 <55ED6D35.6060704@rock-chips.com>
Message-ID: <55ED6FA2.4090903@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andy,

On 09/07/2015 12:55 PM, Andy Yan wrote:
> Hi
>     There are also many other devices like display and mmc and even
> the cpu(if the cpu want run a high frequency when boot up)need to
> get power supply from PMIC, so it is better to load PMIC as early as
> possible.Built-in is a better choice.
>

Please don't top post, it makes following the conversation much harder.

Yes, I know that many devices needs the regulators provided by the PMIC
but that it's also true for all the regulators in all the PMICs for all
the boards supported by multi_v7_defconfig.

So to keep the kernel binary on a reasonable size, the current multi_v7
policy is to enable as much as possible as a module so just saying that
many other devices are using regulators from this PMIC is not enough.

Saying that it will allow mounting a NFS rootfs without an initramfs as
Sjoerd said is a much better justification IMHO.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
