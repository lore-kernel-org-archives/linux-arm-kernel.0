From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Tue, 13 Dec 2016 13:20:19 +0100
Subject: [RFC v2 00/13] usb/mmc/power: Fix USB/LAN when TFTP booting
In-Reply-To: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <c956e27e-7e01-2a2f-0e35-796c4a6556ae@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

This still seems to be broken with the latest 4.9 kernel, right?

Has there been any progress on this? Do you have an updated patch series
for me to use?

Regards,

	Hans

On 05/05/16 14:34, Krzysztof Kozlowski wrote:
> Hi,
>
> This is a different, second try to fix usb3503+lan on Odroid U3 board
> if it was initialized by bootloader (e.g. for TFTP boot).
>
> First version:
> http://www.spinics.net/lists/linux-usb/msg140042.html
>
>
> Problem
> =======
> When Odroid U3 (usb3503 + smsc95xx + max77686) boots from network (TFTP),
> the usb3503 and LAN smsc95xx do not show up in "lsusb". Hard-reset
> is required, e.g. by suspend to RAM. The actual TFTP boot does
> not have to happen. Just "usb start" from U-Boot is sufficient.
>
