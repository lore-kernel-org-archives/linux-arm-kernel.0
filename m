From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 12 Jun 2014 14:39:05 -0600
Subject: [PATCH v2 2/4] pinctrl: Add NVIDIA Tegra XUSB pad controller
 support
In-Reply-To: <1402398708-10722-2-git-send-email-thierry.reding@gmail.com>
References: <1402398708-10722-1-git-send-email-thierry.reding@gmail.com>
 <1402398708-10722-2-git-send-email-thierry.reding@gmail.com>
Message-ID: <539A0FE9.1080802@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2014 05:11 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The XUSB pad controller found on NVIDIA Tegra SoCs provides several pads
> that lanes can be assigned to in order to support a variety of interface
> options: USB 2.0, USB 3.0, PCIe and SATA.
> 
> In addition to the pin controller used to assign lanes to pads two PHYs
> are exposed to allow the bricks for PCIe and SATA to be powered up and
> down by PCIe and SATA drivers.

Aside from the issue Andrew pointed out, this series looks good to me.
I'll apply once that one issue is fixed.

Linus,

Patch 2 (pinctrl driver) depends on patch 1 (binding header), and there
are other patches that will also depend on the binding header in patch
1. I guess I should apply patch 1 in a topic branch and send you a pull
request which you can merge before applying patch 2. Does that sound OK
to you?
