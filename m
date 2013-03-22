From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 22 Mar 2013 13:05:21 -0600
Subject: [PATCH v8 00/14] Tegra114 clockframework
In-Reply-To: <1363956029-31873-1-git-send-email-pdeschrijver@nvidia.com>
References: <1363956029-31873-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <514CAB71.7020005@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2013 06:39 AM, Peter De Schrijver wrote:
> This is the eight version of the Tegra114 clockframework. It is based on the
> next-20130320-fixed branch of
> git://nv-tegra.nvidia.com/user/swarren/linux-2.6.git,

Hmmm. Basing this on v3.9-rcX would be better, since when I apply it to
the Tegra tree, that's what it will be based on. Luckily, it applies
there with trivial conflicts.

> http://patchwork.ozlabs.org/patch/229972/ and
> http://patchwork.ozlabs.org/patch/229978/

The series,

Tested-by: Stephen Warren <swarren@nvidia.com>

(based on my personal next-20130318-fixed branch, without
http://patchwork.ozlabs.org/patch/229972/ applied, but instead with the
audio clocks initialized per the patch I posted yesterday to do this).

I tested: serial console, eMMC for the root filesystem, audio playback
using different pll_a rates, reboot, and shutdown.

This version also solves the hard hang I was seeing with V7 during
shutdown or reboot. Now I don't have to rely on my filesystem journal:-)
