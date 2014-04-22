From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Apr 2014 20:42:29 +0200
Subject: [PATCH] tty/serial: atmel_serial: Fix device tree documentation
In-Reply-To: <20140415080006.GE2255@ldesroches-Latitude-E6320>
References: <1397487482-3816-1-git-send-email-richard.genoud@gmail.com>
 <20140414152212.GC2255@ldesroches-Latitude-E6320>
 <534CE24F.9020703@gmail.com>
 <20140415080006.GE2255@ldesroches-Latitude-E6320>
Message-ID: <CACRpkdZdSCqgs7huAgp53V1T9+A_6ACgUXzCx4-nvgLP5VPxMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 10:00 AM, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:
> On Tue, Apr 15, 2014 at 09:39:59AM +0200, Richard Genoud wrote:
>> On 14/04/2014 17:22, Ludovic Desroches wrote:
>> > Hi Richard,
>> >
>> > On Mon, Apr 14, 2014 at 04:58:02PM +0200, Richard Genoud wrote:
>> >> RTS pin is an active low pin.
>> >> For now, this doesn't change anything as the ACTIVE_LOW flag is not
>> >> handled in atmel_serial, but it will be in 3.16.
>> >>
>> >> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>> >> ---
>> >>  Documentation/devicetree/bindings/serial/atmel-usart.txt | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
>> >> index 17c1042b2df8..2f7aad71b3c9 100644
>> >> --- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
>> >> +++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
>> >> @@ -35,7 +35,7 @@ Example:
>> >>            clock-names = "usart";
>> >>            atmel,use-dma-rx;
>> >>            atmel,use-dma-tx;
>> >> -          rts-gpios = <&pioD 15 0>;
>> >> +          rts-gpios = <&pioD 15 GPIO_ACTIVE_LOW>;
>> >
>> > I was told we should not use macros here. If it is still the truth:
>> >
>> > rts-gpios = <&pioD 15 1>;
>>
>> But I'd really like to know if macros are forbidden in DT documentation and why...
>> Because, IMHO, <&pioD 15 1> talks less that <&pioD 15 GPIO_ACTIVE_LOW>.
>> Which is a shame in a documentation.
>
> I don't remember who told me that but the reason was that device tree
> should not depend on Linux and macros are relative to Linux.

These macros are not Linux-specific.

They come from include/dt-bindings/* which is part of the OS-neutral
bindings, just in a machine-readable form.

Yours,
Linus Walleij
