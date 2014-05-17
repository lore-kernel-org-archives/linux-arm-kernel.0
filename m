From: thierry.reding@gmail.com (Thierry Reding)
Date: Sat, 17 May 2014 23:33:00 +0200
Subject: [PATCH 1/2] ARM: tegra: Mark Tegra124 HDMI compatible with
 Tegra114
In-Reply-To: <1400350881-22008-1-git-send-email-dgreid@chromium.org>
References: <1400350881-22008-1-git-send-email-dgreid@chromium.org>
Message-ID: <20140517213258.GE1046@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 17, 2014 at 11:21:20AM -0700, Dylan Reid wrote:
> The HDMI driver that handles Tegra114 can handle Tegra124 as well,
> mark Tegra124 as compatible.  This makes HDMI output work on Venice2.
> 
> Signed-off-by: Dylan Reid <dgreid@chromium.org>
> ---
>  arch/arm/boot/dts/tegra124.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

These patches don't seem to be based on linux-next. There are a couple
of patches in linux-next (queued for 3.16) that should fix these, in
particular:

	4b9701e02b3b drm/tegra: hdmi - Add Tegra124 support
	0d6696438d2c drm/tegra: hdmi - Add connector supply support

Could you try a recent linux-next to see if that fixes the issues you
are seeing? Note that Tegra doesn't boot on linux-next from the last few
days because of some cgroup regressions, but a fix was merged and should
be in Monday's linux-next, so unless new regressions are introduced that
would be a good candidate to test.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140517/9f5c0b36/attachment.sig>
