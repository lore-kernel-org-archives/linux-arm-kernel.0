From: treding@nvidia.com (Thierry Reding)
Date: Mon, 14 Mar 2016 13:18:24 +0100
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: enable CONFIG_PWM_ROCKCHIP=y
In-Reply-To: <1457787029-9168-1-git-send-email-andy.yan@kernel-upstream.org>
References: <1457787029-9168-1-git-send-email-andy.yan@kernel-upstream.org>
Message-ID: <20160314121823.GE22912@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 12, 2016 at 08:50:29PM +0800, Andy Yan wrote:
> All the current rk3066 based boards use pwm modulate vdd_logic
> voltage, the board may hang when the system boot and run to a higher
> frequency without pwm enabled, so enable it as builtin.

I don't understand the rationale here. Surely if the system can't safely
switch to a higher frequency because the regulator isn't available, then
it should be prevented from switching, shouldn't it?

Making this change alone will not prevent users from switching this back
to =m on their own. So either you need to add code to prevent a switch
to an unsupported frequency in the absence of the regulator, or you need
to change the PWM_ROCKCHIP Kconfig option to be bool instead, though the
latter is of course a somewhat ugly hack, whereas the former would be a
proper fix.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160314/ba929e88/attachment-0001.sig>
