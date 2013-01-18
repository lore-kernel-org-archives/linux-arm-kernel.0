From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 18 Jan 2013 10:55:10 +0800
Subject: [PATCH v4 1/1] ARM i.MX6: change mxs usbphy clock usage
In-Reply-To: <1358476685-28572-1-git-send-email-peter.chen@freescale.com>
References: <1358476685-28572-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20130118025508.GB31381@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 10:38:05AM +0800, Peter Chen wrote:
> This mxs usbphy is only needs to be on after system boots
> up, and software never needs to control it anymore.
> Meanwhile, usbphy's parent needs to be notified if usb
> is suspend or not. So we design below mxs usbphy usage:
> 
> - usbphy1_gate and usbphy2_gate:
> Their parents are dummy clock, we only needs to enable
> it after system boots up.
> - usbphy1 and usbphy2
> Usage reserved bit for this clock, in that case, the refcount
> will be updated, but without hardware changing.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

Applied, thanks.
