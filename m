From: abrestic@chromium.org (Andrew Bresticker)
Date: Sun, 31 Aug 2014 12:04:08 -0700
Subject: [PATCH v2 6/9] usb: xhci: Add NVIDIA Tegra xHCI host-controller
 driver
In-Reply-To: <20140830211558.GA13814@kroah.com>
References: <1408381705-3623-1-git-send-email-abrestic@chromium.org>
 <1408381705-3623-7-git-send-email-abrestic@chromium.org>
 <20140830211558.GA13814@kroah.com>
Message-ID: <CAL1qeaGhMQiWqEV7GwjFt-4xXSTceRFm8RcaVs9vvVHJ9U8hRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 30, 2014 at 2:15 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Aug 18, 2014 at 10:08:22AM -0700, Andrew Bresticker wrote:
>> Add support for the on-chip xHCI host controller present on Tegra SoCs.
>>
>> The driver is currently very basic: it loads the controller with its
>> firmware, starts the controller, and is able to service messages sent
>> by the controller's firmware.  The hardware supports device mode as
>> well as lower-power operating modes, but support for these is not yet
>> implemented here.
>
> So you are saying the device doesn't really work?  Can it handle USB
> transactions properly?

Huh?  It's just as functional as any other xHCI platform host.
Perhaps I should have been more clear about "lower-power operating
modes": this refers to the runtime powergating of the controller's
SuperSpeed and host-controller logic and has nothing to do with USB
link/hub/device power management.

> I have a jetson board here, is this the controller for that hardware?
> Can I test this series on that platform, or is it for something else?

Yup, that's the platform I primarily used for testing this series.

>> +static const struct tegra_xhci_soc_config tegra124_soc_config = {
>> +     .firmware_file = "nvidia/tegra124/xusb.bin",
>> +};
>> +MODULE_FIRMWARE("nvidia/tegra124/xusb.bin");
>
> Has this file been submitted to the linux-firmware tree?

It has been posted, see https://patchwork.ozlabs.org/patch/384013/
