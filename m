From: marcel@holtmann.org (Marcel Holtmann)
Date: Wed, 10 Dec 2014 18:42:33 +0100
Subject: BCM2048 bluetooth connected over OMAP serial
In-Reply-To: <CAL_Jsq+dy+5Fsg_oasP_hN3RuL1Wk7fOcQjyp+UdaJZyGa=uEg@mail.gmail.com>
References: <20141210164333.GA3154@amd>
 <CAL_Jsq+dy+5Fsg_oasP_hN3RuL1Wk7fOcQjyp+UdaJZyGa=uEg@mail.gmail.com>
Message-ID: <5C56C73A-1D8E-4ACC-B1B7-3E8D49943A70@holtmann.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

>> So, there's bluetooth chip that's connected to the SoC by UART and some
>> GPIOs. What would be right representation in the device tree?
>> Something like this?
>> 
>>        bluetooth {
>>                  compatible = "broadcom,bcm2048";
>>                  uart = <&uart2>;
>>                  reset-gpios = <&gpio3 27 GPIO_ACTIVE_HIGH>; /* want 91 */
>>                  host-wakeup-gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>; /* want 101 */
>>                  bluetooth-wakeup-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>; /* want 37 */
>>                  chip-type = <3>;
>>                  bt-sysclk = <2>;
>>                  reset-gpio-shared = <0>;
>>        };
>> 
>> Is there some way to prevent OMAP tty driver from binding to the
>> device and exporting the device to userspace?
> 
> Isn't the normal way for BT to work is the uart is exposed to
> userspace and the BT stack is all in userspace? This is how other
> Broadcom BT/WiFi combo parts work.

not on Linux actually. The Bluetooth core layer (including the HCI transport) are all in kernel space.

However UART based Bluetooth chips are exposed as TTY and then the N_HCI line discipline is used to attach it to the kernel Bluetooth subsystem.

Regards

Marcel
