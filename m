From: codekipper@gmail.com (Code Kipper)
Date: Wed, 3 Feb 2016 08:26:34 +0100
Subject: [PATCH v3 1/2] dt-bindings: add sun4i SPDIF transceiver bindings
In-Reply-To: <20160202223115.GE4652@lukather>
References: <1454424594-25208-1-git-send-email-codekipper@gmail.com>
 <1454424594-25208-2-git-send-email-codekipper@gmail.com>
 <20160202223115.GE4652@lukather>
Message-ID: <CAEKpxBnSAocmQX=x2mtzL2YtNziSZYRkNxsdaqW_mMsGcG=Z9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 February 2016 at 23:31, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Tue, Feb 02, 2016 at 03:49:53PM +0100, codekipper at gmail.com wrote:
>> From: Marcus Cooper <codekipper@gmail.com>
>>
>> Add devicetree bindings for the SPDIF transceiver found on
>> found on Allwinners A10 and A20 SoCs.
>>
>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>> ---
>>  .../devicetree/bindings/sound/sun4i,spdif.txt      | 46 ++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/sound/sun4i,spdif.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/sun4i,spdif.txt b/Documentation/devicetree/bindings/sound/sun4i,spdif.txt
>> new file mode 100644
>> index 0000000..55ed2f6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/sun4i,spdif.txt
>> @@ -0,0 +1,46 @@
>> +Allwinner Sony/Philips Digital Interface Format (S/PDIF) Controller
>> +
>> +The Allwinner S/PDIF audio block is a transceiver that allows the
>> +processor to receive and transmit digital audio via an coaxial cable or
>> +a fibre cable.
>> +
>> +Required properties:
>> +
>> +  - compatible               : should be one of the following:
>> +    - "allwinner,sun4i-a10-spdif": for the Allwinner A10 SoC
>> +
>> +  - reg                      : Offset and length of the register set for the device.
>> +
>> +  - interrupts               : Contains the spdif interrupt.
>> +
>> +  - dmas             : Generic dma devicetree binding as described in
>> +                       Documentation/devicetree/bindings/dma/dma.txt.
>> +
>> +  - dma-names                : Two dmas have to be defined, "tx" and "rx".
>> +
>> +  - clocks           : Contains an entry for each entry in clock-names.
>> +
>> +  - clock-names              : Includes the following entries:
>> +     "apb"             clock for the spdif bus.
>> +     "spdif"           clock for spdif controller.
>> +
>> +Optional:
>> +
>> +  - spdif-in         : Enable block for capturing an SPDIF signal.
>> +
>> +  - spdif-out                : Enable block for transmitting an SPDIF signal.
>
> Is that a generic property? What values can it hold?
Hi Maxime,

thanks for the review. I'm starting to prep a v4 patch series and I'm
here wondering if I should drop the spdif-in/out for now and just rely
on the status property to enable playback. It would simplify the
driver even more and it could be added back when someone gets around
to delivering spdif capture. I think that's going to be pretty low on
my list of things to do as I've only got one dev board where it's
possible.
BR,
Lazy Lazy CK
>
> Thanks,
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
