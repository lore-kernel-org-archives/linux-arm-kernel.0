From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Mon, 30 Mar 2015 12:43:01 +0200
Subject: [PATCH RFC] ARM: BCM5301X: Add /device_id property including
 device ID string
In-Reply-To: <20150330103659.GD17971@leverpostej>
References: <1427667288-23903-1-git-send-email-zajec5@gmail.com>
 <20150330103659.GD17971@leverpostej>
Message-ID: <CACna6rykQq6AVSWzJh3qnHVNzPXbTD9TMGQf9D9p50pcbQkmng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 March 2015 at 12:37, Mark Rutland <mark.rutland@arm.com> wrote:
> For DT patches, please send to devicetree at vger.kernel.org; this affects
> more than just ARM.

Ofc, sorry.


> On Sun, Mar 29, 2015 at 11:14:48PM +0100, Rafa? Mi?ecki wrote:
>> Device vendors often assign IDs to their devices to allow comparing
>> firmware image with device model. This is required to prevent users
>> from flashing incompatible image and soft-bricking device.
>> Add device_id property to DTs to allow user space (and optionally
>> bootloader) verifying firmware images.
>
> This sounds like exactly what the "model" property is meant to be (per
> ePAPR) -- a string that specifices the manufacturer's model number of
> the device, ideally in "manufacturer,model" format.

What if manufacturer decided to use some totally unfriendly ID for
their low-level (firmware upgrade) model identification? I can't
really see us using
model = "U12H245T00_NETGEAR"
which would mean nothing compared to the current friendly:
model = "Netgear R6250 V1 (BCM4708)"
