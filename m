From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Wed, 4 Jan 2017 14:00:01 -0800
Subject: [PATCH v2 4/4] ARM: dts: keystone: Add "ti, da830-uart" compatible
 string
In-Reply-To: <1483561814-21953-5-git-send-email-david@lechnology.com>
References: <1483561814-21953-1-git-send-email-david@lechnology.com>
 <1483561814-21953-5-git-send-email-david@lechnology.com>
Message-ID: <93c4aed0-6faa-2c27-7931-454fc1f48e79@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/4/2017 12:30 PM, David Lechner wrote:
> The TI Keystone SoCs have extra UART registers beyond the standard 8250
> registers, so we need a new compatible string to indicate this. Also, at
> least one of these registers uses the full 32 bits, so we need to specify
> reg-io-width in addition to reg-shift.
>
> "ns16550a" is left in the compatible specification since it does work as
> long as the bootloader configures the SoC UART power management registers.
>
NAK!!
We can't break the booting boards with existing boot loaders.
I suggest you to first get the driver updated to take care of
the UART PM register and then enable the support for it.
