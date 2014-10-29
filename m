From: gnurou@gmail.com (Alexandre Courbot)
Date: Wed, 29 Oct 2014 14:52:45 +0900
Subject: [PATCH RESEND V4 0/9] Tegra xHCI support
In-Reply-To: <1414535277-15645-1-git-send-email-abrestic@chromium.org>
References: <1414535277-15645-1-git-send-email-abrestic@chromium.org>
Message-ID: <CAAVeFuJ0GhKENAERubGywAHOQp9=iohOxux6O=58xfXNcxG_dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 29, 2014 at 7:27 AM, Andrew Bresticker
<abrestic@chromium.org> wrote:
> This series adds support for xHCI on NVIDIA Tegra SoCs.  This includes:
>  - patches 1 and 2: adding a driver for the mailbox used to communicate
>    with the xHCI controller's firmware,
>  - patches 3 and 4: extending the XUSB pad controller driver to support
>    the USB PHY types (UTMI, HSIC, and USB3),
>  - patches 5 and 6: adding a xHCI host-controller driver, and
>  - patches 7, 8, and 9: updating the relevant DT files.
>
> The PHY and host drivers have compile-time dependencies on the mailbox
> driver, and the host driver has compile-time dependencies on the PHY
> driver.  It is probably best if these all get merged through the Tegra
> tree.  This series still needs ACKs from the relevant maintainers for
> the mailbox and xHCI host drivers and their device-tree bindings.
>
> Tested on Venice2, Jetson TK1, and Big with a variety of USB2.0 and
> USB3.0 memory sticks and ethernet dongles using controller firmware
> recently posted by Andrew Chew [0].
>
> Based on v3.18-rc2.  All other dependencies (xHCI modules and mailbox
> series) have been merged.

I do not feel comfortable enough with xHCI to give a reviewed-by tag,
but FWIW I have found nothing wrong with these patches.
