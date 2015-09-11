From: yvo@apm.com (Y Vo)
Date: Fri, 11 Sep 2015 18:24:47 +0700
Subject: [PATCH 2/2] Documentation: gpio: Update description for X-Gene
 standby GPIO controller DTS binding
In-Reply-To: <11539535.sS04eUgSdg@wuerfel>
References: <1441963332-13329-1-git-send-email-yvo@apm.com>
 <1441963332-13329-3-git-send-email-yvo@apm.com>
 <11539535.sS04eUgSdg@wuerfel>
Message-ID: <CAL4ahLepjn-VG9WCLEovzjwc=8fpncP6xTS68gRO2VtVaEDc1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 4:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 11 September 2015 16:22:12 Y Vo wrote:
>>  There are 20 GPIO pins from 0..21. There is no GPIO_DS14 or GPIO_DS15,
>> -only GPIO_DS8..GPIO_DS13 support interrupts. The IRQ mapping
>> +only GPIO_DS8..GPIO_DS13 support external interrupts. The IRQ mapping
>>  is currently 1-to-1 on interrupts 0x28 thru 0x2d.
>> +GPIO pins from GPIO_DS8 to GPIO_DS13 are configured as external interrupt
>> +by default. If one wish not to use any of these pins as external interrupts,
>> +the corresponding interrupt resource for those pins should be removed.
>
> According to this description, I fail to see how one would specify
> a missing interrupt for one of the pins that is not the last one in
> the list.
>
All GPIO_DS8..GPIO_DS13 are configured as external IRQ by default. So
if anyone want to use one of them as gpio mode, they can drop add the
sbgpio node to their DTB board-specific, and remove that GPIO from
interrupts property. As example below I want to leave GPIO_DS8 as gpio
mode, so I remove it as below:

/* Board-specific: exclude GPIO_DS8 to leave it as GPIO */
&sbgpio {
       interrupts =    <0x0 0x29 0x1>,         /* GPIO_DS9 */
                       <0x0 0x2a 0x1>,         /* GPIO_DS10 */
                       <0x0 0x2b 0x1>,         /* GPIO_DS11 */
                       <0x0 0x2c 0x1>,         /* GPIO_DS12 */
                       <0x0 0x2d 0x1>;         /* GPIO_DS13 */
}

>         Arnd
