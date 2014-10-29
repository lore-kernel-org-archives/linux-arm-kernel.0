From: abrestic@chromium.org (Andrew Bresticker)
Date: Wed, 29 Oct 2014 09:37:14 -0700
Subject: [PATCH RESEND V4 5/9] of: Add NVIDIA Tegra xHCI controller binding
In-Reply-To: <20141029094338.GA28356@ulmo.nvidia.com>
References: <1414535277-15645-1-git-send-email-abrestic@chromium.org>
 <1414535277-15645-6-git-send-email-abrestic@chromium.org>
 <20141029094338.GA28356@ulmo.nvidia.com>
Message-ID: <CAL1qeaEf0mTQfMgnY8jHGDBvbQ7ivtzAQRWaE9K24TJ86hWYMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 29, 2014 at 2:43 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Tue, Oct 28, 2014 at 03:27:50PM -0700, Andrew Bresticker wrote:
> [...]
>> diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt
> [...]
>> +Optional properties:
>> +-------------------
>> +- vbus-{0,1,2}-supply: VBUS regulator for the corresponding UTMI pad.
>> +- vddio-hsic-supply: VDDIO regulator for the HSIC pads.
>> +- nvidia,usb3-port-{0,1}-lane: PCIe/SATA lane to which the corresponding USB3
>> +  port is mapped.  See <dt-bindings/pinctrl/pinctrl-tegra-xusb.h> for the list
>> +  of valid values.
>
> I dislike how we now need to provide a list of all pins in the header
> file, where previously we used strings for this. This could become very
> ugly if the set of pins changes in future generations of this IP block.
>
> Could we instead derive this from the pinmux nodes? For example you have
> this in the example below:
>
>         usb3p0 {
>                 nvidia,lanes = "pcie-0";
>                 ...
>         };
>
> Perhaps what we need is to either key off the node name or add another
> property, such as:
>
>         nvidia,usb3-port = <0>;
>
> This would match the nvidia,usb2-port property that you've added below.

That is actually how I described the USB3 port to SS lane mapping
originally, but in review of an earlier version of this series,
Stephen suggested that I make it a separate, not pinconfig property
since it wasn't a value written directly to the hardware.  I'm fine
with changing it back as the pinconfig property makes more sense to me
as well.
