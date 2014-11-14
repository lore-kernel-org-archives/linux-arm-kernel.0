From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Nov 2014 11:01:47 +0100
Subject: preferable method for pinctrl driver
In-Reply-To: <545C9C41.1090300@rempel-privat.de>
References: <54379C10.3050004@rempel-privat.de>
 <CACRpkdYG6sNEfKNJBdbYCn4AbGiX2OfQAVJorR64cbB_gsWDbw@mail.gmail.com>
 <545C846C.6090502@rempel-privat.de>
 <545C9C41.1090300@rempel-privat.de>
Message-ID: <CACRpkdZMX=HSpusLtPREufJpXuHOwH2MCtHrViASDR7Vbu_eMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 7, 2014 at 11:17 AM, Oleksij Rempel <linux@rempel-privat.de> wrote:

>> thank you for your previous response. One more question: how pins should
>> be numbered? Continuous or register offsets can be used?
>> Documentations for this soc use pin names encoded like this
>> #NAME_#BANK_#PIN. Register offset can be calculated by ((bank) * 32 +
>> (pin) * 4)
>> In this case i need to have extra array to convert pin number to offset,
>> or use offset as pin number.
>
> Never mind, i think i found the answer:
> This enumeration was arbitrarily chosen, in practice you need to think
> through your numbering system so that it matches the layout of registers
> and such things in your driver, or the code may become complicated. You
> must also consider matching of offsets to the GPIO ranges that may be
> handled by the pin controller.

Yeah you're right :)

There is some resoning in Documentation/pinctrl.txt but it needs some
intuition etc.

Yours,
Linus Walleij
