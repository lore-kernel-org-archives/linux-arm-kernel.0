From: linux@rempel-privat.de (Oleksij Rempel)
Date: Mon, 09 Feb 2015 11:41:13 +0100
Subject: preferable method for pinctrl driver
In-Reply-To: <CACRpkdZMX=HSpusLtPREufJpXuHOwH2MCtHrViASDR7Vbu_eMw@mail.gmail.com>
References: <54379C10.3050004@rempel-privat.de>	<CACRpkdYG6sNEfKNJBdbYCn4AbGiX2OfQAVJorR64cbB_gsWDbw@mail.gmail.com>	<545C846C.6090502@rempel-privat.de>	<545C9C41.1090300@rempel-privat.de>
 <CACRpkdZMX=HSpusLtPREufJpXuHOwH2MCtHrViASDR7Vbu_eMw@mail.gmail.com>
Message-ID: <54D88EC9.70409@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 14.11.2014 um 11:01 schrieb Linus Walleij:
> On Fri, Nov 7, 2014 at 11:17 AM, Oleksij Rempel <linux@rempel-privat.de> wrote:
> 
>>> thank you for your previous response. One more question: how pins should
>>> be numbered? Continuous or register offsets can be used?
>>> Documentations for this soc use pin names encoded like this
>>> #NAME_#BANK_#PIN. Register offset can be calculated by ((bank) * 32 +
>>> (pin) * 4)
>>> In this case i need to have extra array to convert pin number to offset,
>>> or use offset as pin number.
>>
>> Never mind, i think i found the answer:
>> This enumeration was arbitrarily chosen, in practice you need to think
>> through your numbering system so that it matches the layout of registers
>> and such things in your driver, or the code may become complicated. You
>> must also consider matching of offsets to the GPIO ranges that may be
>> handled by the pin controller.
> 
> Yeah you're right :)
> 
> There is some resoning in Documentation/pinctrl.txt but it needs some
> intuition etc.
> 
> Yours,
> Linus Walleij
> 

What is preferred method of handling gpio_request_enable in pinctrl
driver? My hw provide GPIO as one of mux variants for each controlled
pin.  if i see it correctly, pin subsystem will not prevent using one
pin as gpio and request for some other functionality? Should it be
prevented by driver?

Here is my current pinctrl driver, in case it help understand my point:
https://github.com/olerem/linux-2.6/commit/5d8963e24493db445207c29dec00a6a848d8e781

-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150209/d679592d/attachment.sig>
