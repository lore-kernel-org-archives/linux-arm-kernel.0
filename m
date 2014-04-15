From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 15 Apr 2014 09:14:35 +0200
Subject: [PATCH] tty/serial: atmel_serial: Fix device tree documentation
In-Reply-To: <20140414152212.GC2255@ldesroches-Latitude-E6320>
References: <1397487482-3816-1-git-send-email-richard.genoud@gmail.com>
 <20140414152212.GC2255@ldesroches-Latitude-E6320>
Message-ID: <CACQ1gAixK-SrcGCOV49xWivu5Y75zJkSahd9UTR08TTM=4EDxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-04-14 17:22 GMT+02:00 Ludovic Desroches <ludovic.desroches@atmel.com>:
> Hi Richard,
>
> On Mon, Apr 14, 2014 at 04:58:02PM +0200, Richard Genoud wrote:
>> RTS pin is an active low pin.
>> For now, this doesn't change anything as the ACTIVE_LOW flag is not
>> handled in atmel_serial, but it will be in 3.16.
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/serial/atmel-usart.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
>> index 17c1042b2df8..2f7aad71b3c9 100644
>> --- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
>> +++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
>> @@ -35,7 +35,7 @@ Example:
>>               clock-names = "usart";
>>               atmel,use-dma-rx;
>>               atmel,use-dma-tx;
>> -             rts-gpios = <&pioD 15 0>;
>> +             rts-gpios = <&pioD 15 GPIO_ACTIVE_LOW>;
>
> I was told we should not use macros here. If it is still the truth:
>
> rts-gpios = <&pioD 15 1>;
That's right !
I do not totally get why, but macros aren't used in the documentation
(maybe that macros names may change, whereas numbers wont').
I'll resend this.

Thanks !

Richard.
