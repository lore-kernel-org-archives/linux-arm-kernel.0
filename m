From: poorarm@shoreis.com (Rob Emanuele)
Date: Tue, 9 Nov 2010 15:59:39 -0800
Subject: USB Serial Gadget was Re: at91sam9g45 USB OTG support?
Message-ID: <AANLkTimK_UEnFOJh54qtVY97EGTaUY5v6FTs6mhO9_Kd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas et al,

Thank you for the information.  For the moment I have a boot option to
use either 2 host ports or a host and a device port.  That would seem
to fit my needs except for the case that I'm loading the usb serial
gadget as a module and then specifying in the inittab that getty use
it as ttyGS0.  In that case connecting the device port to a host does
not seem to ever register on the host.  If I remove the getty line
from inittab and then run getty manually after it boots, it works
fine.  To add insult to injury, then it will work after reboot also
until a hard power down.

Anyone experience this?

Thank you,

Rob

On Tue, Nov 9, 2010 at 9:46 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> Le 05/11/2010 22:09, Rob Emanuele :
>> Greetings,
>>
>> We've been developing a at91sam9g45 product and it is finally available at:
>> https://www.crystalfontz.com/product/CFA910.html
>
> Very nice platform!
>
>> We are looking into supporting USB OTG on this device as the 'g45 has
>> the USB host/device port. ?As far at I can tell Atmel or anyone else
>> working on this platform has not made full use of this as an OTG
>> device.
>
> Indeed, it is not done for the moment...
>
>> ?I haven't found support in the USB or the OTG code for
>> reading the USB ID line to determine host or device mode.
>
> I am not sure USB ID is well supported by consumer cable providers and
> is a reliable way to determine host or device mode.
>
>> Am I missing something or is that an area that needs some code written for it?
>
> Anyway, using this port as host or device is a matter of
> 1/ driving or not VBUS pin
> 2/ dealing with loading the gadget driver (as the "Enable" of the usba
> IP is responsible for swithing to device mode).
>
> I think that determining if the port shall be used in host or device
> mode can be asked through the GUI... But note that I am not an USB expert...
> --
> Nicolas Ferre
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
