From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 14 Dec 2010 16:03:46 +0100
Subject: ulpi_check_integrity returning error
In-Reply-To: <AANLkTintiOa5mhcF_viNCzC5q1EEHjgTLHhYsJc5Un-5@mail.gmail.com>
	(Fabio Estevam's message of "Tue, 14 Dec 2010 12:47:59 -0200")
References: <AANLkTinxLr10X-EBGQHdhC5JyxbJOqcUz_+UMOCo+OFA@mail.gmail.com>
	<4D076E49.3020805@compulab.co.il>
	<AANLkTintiOa5mhcF_viNCzC5q1EEHjgTLHhYsJc5Un-5@mail.gmail.com>
Message-ID: <87d3p4e6r1.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio Estevam <festevam@gmail.com> writes:

Hi,

> Hi Igor,
>
> [Adding linux-arm-kernel]
>
> On Tue, Dec 14, 2010 at 11:16 AM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>> Hi Fabio,
>>
>> On 12/14/10 00:14, Fabio Estevam wrote:
>>> Hi,
>>>
>>> I am working on adding USB OTG host support for the mx31_3ds board
>>> (OTG PHY is a ISP1504).
>>
>> ISP1504 seems like ULPI compliant transceiver.
>>
>>> USB OTG in device mode works fine and I can only get OTG host mode to
>>> work if I force a 'return 0' into the ulpi_check_integrity function. I
>>> was wondering if anyone has any suggestions as to where to
>>> inspect/debug the fact that the read/write to the OTG PHY scratch
>>> register does not match.
>>
>> Both ULPI specifications (1.0 and 1.1) define the Scratch register as:
>> "an empty register byte for testing purposes. Software can read, write,
>> set and clear this register; and the functionality of the PHY will not be affected."
>> Therefore it should be implemented in the ISP1504 as such and according to
>> NXP's ISP1504 datasheet it should be there...
>>
>> What about the ID? Do you get the vendor/product ID value as expected?
>
> No, I am getting only zeros when reading vendor/product ID:
>
> ULPI transceiver vendor/product ID 0x0000/0x0000
>
> Even though the ULPI integrity check fails, if I force a 'return 0' in
> this function, then I am able to mount a USB stick and it is
> functional.
>
> There are other i.MX boards that support OTG in host mode via ULPI,
> such as pcm037, pca100, imx27_visstrim .
>
> I am curious to know if any of this boards can work in host mode OTG
> with current mainline kernel.

I guess you need to configure portsc register into ulpi mode in the
.init function of the mxc_usbh_platform_data otherwise, you won't be
able to reach the ulpi.

Thanks,
Arnaud
