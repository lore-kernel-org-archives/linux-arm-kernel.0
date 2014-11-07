From: linux@rempel-privat.de (Oleksij Rempel)
Date: Fri, 07 Nov 2014 11:17:37 +0100
Subject: preferable method for pinctrl driver
In-Reply-To: <545C846C.6090502@rempel-privat.de>
References: <54379C10.3050004@rempel-privat.de>
 <CACRpkdYG6sNEfKNJBdbYCn4AbGiX2OfQAVJorR64cbB_gsWDbw@mail.gmail.com>
 <545C846C.6090502@rempel-privat.de>
Message-ID: <545C9C41.1090300@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 07.11.2014 um 09:35 schrieb Oleksij Rempel:
> Am 13.10.2014 um 11:05 schrieb Linus Walleij:
>> On Fri, Oct 10, 2014 at 10:42 AM, Oleksij Rempel <linux@rempel-privat.de> wrote:
>>
>>> Looks like there is at least two pinctrl driver types:
>>> - imx23 which makes function description insight of DT;
>>> - tegra with function descrption in the source code.
>>> which way is preferable?
>>
>> The Tegra way. The driver should know about all groups
>> and functions, the DT should just configure the functions to
>> groups relation.
>>
>> The i.MX driver happened before the DT use for pin controllers
>> was thought through.
>>
>>> Other question, i didn't found exact same HW, do it make sense to merge
>>> this driver with existing one? Are there some similarities with this one?:
>>> http://pastebin.com/hW82Xupq
>>
>> No idea, that's very little HW information. However
>> silicon vendors often du their I/O cell layout themselves
>> so many pin controllers are very unique.
>>
>> Yours,
>> Linus Walleij
> 
> Hi,
> thank you for your previous response. One more question: how pins should
> be numbered? Continuous or register offsets can be used?
> Documentations for this soc use pin names encoded like this
> #NAME_#BANK_#PIN. Register offset can be calculated by ((bank) * 32 +
> (pin) * 4)
> In this case i need to have extra array to convert pin number to offset,
> or use offset as pin number.

Never mind, i think i found the answer:
This enumeration was arbitrarily chosen, in practice you need to think
through your numbering system so that it matches the layout of registers
and such things in your driver, or the code may become complicated. You
must also consider matching of offsets to the GPIO ranges that may be
handled by the pin controller.

-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141107/9b3e5c31/attachment.sig>
