From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Feb 2014 17:38:46 -0800
Subject: [PATCH v2 0/6] ARM: firmware: improvements to Trusted
 Foundations support
In-Reply-To: <1391747706-1847-1-git-send-email-acourbot@nvidia.com>
References: <1391747706-1847-1-git-send-email-acourbot@nvidia.com>
Message-ID: <20140212013846.GB7584@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 01:35:00PM +0900, Alexandre Courbot wrote:
> These (mostly minor) patches fix a few typos, improve points that
> were agreed upon when the Trusted Foundation series was initially
> submitted, and more importantly add support for a prepare_idle()
> firmware operation that informs the firmware a CPU is doing idle.
> Tegra's cpuidle driver is then also updated accordingly.
> 
> These patches should be the last step before device trees for NVIDIA
> SHIELD and Tegra Note 7 can be submitted.
> 
> Changes since v1:
> - Do not remove TF support from tegra_defconfig (will automatically be taken
>   care of during next configuration update)
> - Add a new prepare_idle() operation to firmware_ops that informs the firmware
>   a CPU is going idle (vs. asking the firmware to do it itself as do_idle()
>   does)
> - Fix idle states names in TF implementation of prepare_idle to sound less
>   Tegra-specific

1-5:

Acked-by: Olof Johansson <olof@lixom.net>

Stephen asked if he should merge through Russell's tree or ours; since
tegra is the only user I don't have a problem merging this (via tegra
pull requests) but I'm giving Russell veto power. :)


-Olof
