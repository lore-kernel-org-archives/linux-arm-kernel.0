From: abrestic@chromium.org (Andrew Bresticker)
Date: Mon, 18 Aug 2014 12:35:42 -0700
Subject: [PATCH v2 0/9] Tegra xHCI support
In-Reply-To: <53F2381B.8020801@wwwdotorg.org>
References: <1408381705-3623-1-git-send-email-abrestic@chromium.org>
 <53F2381B.8020801@wwwdotorg.org>
Message-ID: <CAL1qeaGuMWbaZ4GQWATtrnYe-RjuTwLpFnrdhibWGNWm0iF+=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 10:30 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/18/2014 11:08 AM, Andrew Bresticker wrote:
>>
>> This series adds support for xHCI on NVIDIA Tegra SoCs.  This includes:
>>   - adding a driver for the mailbox used to communicate with the xHCI
>>     controller's firmware,
>>   - extending the XUSB pad controller driver to support the USB PHY
>>     types (UTMI, HSIC, and USB3), and
>>   - adding a xHCI host-controller driver.
>
>
> Can you please remind us what dependencies exist between the patches? In
> other words, is it possible to apply parts of the series to their usual
> subsystem branches, or does the whole thing need to go into a single topic
> branch in order to avoid compile-time problems, or run-time problems in
> features unrelated to the new functionality? Thanks.

The whole thing will probably need to go into one branch.  Patch 4/9
("pinctrl: tegra-xusb: Add USB PHY support") has compile-time
dependencies on patch 2/9 ("mailbox: Add NVIDIA Tegra XUSB mailbox
driver") and patch 6/9 ("usb: xhci: Add NVIDIA Tegra xHCI
host-controller driver") has compile-time dependencies on both patches
2/9 and 4/9.
