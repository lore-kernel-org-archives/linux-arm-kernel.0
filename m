From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 30 Jun 2016 11:30:31 +0200
Subject: [PATCH 0/3] Fixes for Tegra XUSB
In-Reply-To: <1467198453-23406-1-git-send-email-jonathanh@nvidia.com>
References: <1467198453-23406-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <20160630093031.GB1776@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 12:07:30PM +0100, Jon Hunter wrote:
> Fixes for Tegra XUSB dt-binding documentation and the XUSB mailbox
> interrupt.
> 
> When testing XUSB on the Tegra210 Smaug, I found that USB connect and
> disconnect events were not being seen. I have debug this and found that
> the XUSB mailbox is incorrect and I was never receiving any interrupts
> from the XUSB mailbox. Interestingly, this behaviour is not seen on the
> Tegra210 Jetson TX1 despite the fact that there were no mailbox
> interrupts. The two boards have different USB connectors and so may be
> the connection is slightly different. After fixing the mailbox interrupt
> both boards now receive interrupts from the XUSB mailbox as expected.
> 
> Jon Hunter (3):
>   dt-bindings: phy: Fix description of Tegra210 PHY nodes
>   dt-bindings: usb: Fix Tegra XUSB example
>   arm64: tegra: Correct Tegra210 XUSB mailbox interrupt
> 
>  .../devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt       | 2 +-
>  Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt    | 8 ++++----
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi                          | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)

All applied to for-4.8/dt-bindings (1 and 2) and for-4.8/arm64 (3).

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160630/1317ddaf/attachment.sig>
