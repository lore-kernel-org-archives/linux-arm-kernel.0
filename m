From: arun.ramamurthy@broadcom.com (Arun Ramamurthy)
Date: Tue, 17 Feb 2015 12:00:49 -0800
Subject: [PATCH 1/2] phy: usbphy: Add dt documentation for Broadcom Cygnus
 USB PHY driver
In-Reply-To: <8242260.cl4QTECoeX@wuerfel>
References: <1424200821-16368-1-git-send-email-arun.ramamurthy@broadcom.com>
 <1424200821-16368-2-git-send-email-arun.ramamurthy@broadcom.com>
 <8242260.cl4QTECoeX@wuerfel>
Message-ID: <54E39DF1.50409@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you for the review Arnd.
On 15-02-17 11:41 AM, Arnd Bergmann wrote:
> On Tuesday 17 February 2015 11:20:20 Arun Ramamurthy wrote:
>> +       /* This nodes declares  port 0
>> +       and port 1 as host*/
>> +
>> +       ehci0: usb at 0x18048000 {
>> +               compatible = "generic-ehci";
>> +               reg = <0x18048000 0x100>;
>> +               interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>> +               phys = <&usbphy0 0 1 &usbphy0 1>;
>
> The second reference in the example is missing the last cell,
> as you have #phy-cells = <2>.
>
I am missing a 1 for the port number, will update in next patchset, 
thank you
>> +               phy-names = "usbp0","usbp1";
>> +               status = "okay";
>> +       };
>
> Further, the binding for "generic-ehci" requires the name to be "usb",
> not "usbp0". You should probably update that binding if you can have
> multiple references to mention that.
>
> Can you make both names "usb"? If not, we should document a common
> naming scheme that the driver can use.
>
Arnd, I patched the ehci and ohci driver to accept multiple phys so they 
require different names and cannot both be "usb". That patch was 
accepted by Alen Stern but I did not update the bindings documentation.
I will send out another patch for that. Could we go with the naming 
scheme of "usb" + "p" + port number or do you have other suggestions?


> 	Arnd
>
