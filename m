From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 20 Dec 2011 08:26:08 -0800
Subject: [PATCH] arm/tegra: boards: more __init/__initdata annotations
In-Reply-To: <1324353802-31774-1-git-send-email-olof@lixom.net>
References: <1324353802-31774-1-git-send-email-olof@lixom.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF176BE92CFB@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Monday, December 19, 2011 9:03 PM:
> Silence a bunch of section warnings, and mark some of the init functions as
> __init.

Is it correct to mark these as __init?

With my recent patch "arm/tegra: Use bus notifiers to trigger pinmux
setup", this data all gets used at pinmux/GPIO device probe time. Still,
I suppose that does all get triggered by tegra_dt_init() which is __init,
so if a device is guaranteed to probe as soon as a device registration
and driver exist for it, then everything you've marked as __init really
is guaranteed to be used then.

-- 
nvpublic
