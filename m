From: treding@nvidia.com (Thierry Reding)
Date: Mon, 14 Mar 2016 13:21:05 +0100
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: enable CONFIG_REGULATOR_PWM=y
In-Reply-To: <1457787100-9221-1-git-send-email-andy.yan@kernel-upstream.org>
References: <1457787029-9168-1-git-send-email-andy.yan@kernel-upstream.org>
 <1457787100-9221-1-git-send-email-andy.yan@kernel-upstream.org>
Message-ID: <20160314122104.GF22912@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 12, 2016 at 08:51:40PM +0800, Andy Yan wrote:
> Some platform like Rockchip rk3066 use pwm as a regulator to modulate
> cpu voltage, so pwm regulator should be enabled at system boot time if
> the system want to run with high frequency.
> 
> Signed-off-by: Andy Yan <andy.yan@kernel-upstream.org>
> ---
> 
>  arch/arm/configs/multi_v7_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This really belongs in patch 1/2. But then the same comments hold true
and I think you'll need to come up with a proper fix that prevents the
switch to a higher frequency if don't have the necessary regulator, or
make the Kconfig symbol bool if all else fails.

If you make the Kconfig symbol bool I'd expect a really good explanation
in the commit message as to why it can't be fixed properly.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160314/e687abb1/attachment.sig>
