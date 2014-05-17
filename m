From: thierry.reding@gmail.com (Thierry Reding)
Date: Sat, 17 May 2014 23:34:57 +0200
Subject: [PATCH 2/2] drm/tegra: Enable HDMI_5V_CON regulator
In-Reply-To: <1400350881-22008-2-git-send-email-dgreid@chromium.org>
References: <1400350881-22008-1-git-send-email-dgreid@chromium.org>
 <1400350881-22008-2-git-send-email-dgreid@chromium.org>
Message-ID: <20140517213456.GF1046@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 17, 2014 at 11:21:21AM -0700, Dylan Reid wrote:
> The DDC bus uses this for it's supply, enable it so EDID can be read.
> This eliminates I2C read timeouts on Venice2 and EDID can be verified
> with i2cdump.
> 
> Signed-off-by: Dylan Reid <dgreid@chromium.org>
> ---
>  drivers/gpu/drm/tegra/hdmi.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Like I said in reply to 1/2, this should be fixed by:

	0d6696438d2c drm/tegra: hdmi - Add connector supply support

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140517/1b4883bf/attachment.sig>
