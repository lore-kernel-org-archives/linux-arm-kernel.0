From: b32955@freescale.com (Huang Shijie)
Date: Fri, 1 Jul 2011 16:39:05 +0800
Subject: [PATCH v5 1/3] ARM: mxs: add GPMI-NFC support for imx23/imx28
In-Reply-To: <20110701080158.GB1922@pengutronix.de>
References: <1309406028-2924-1-git-send-email-b32955@freescale.com>	<201106301555.19440.arnd@arndb.de>	<19980.36638.134045.743619@ipc1.ka-ro>	<201107010022.26597.arnd@arndb.de>	<20110701060356.GA27039@pengutronix.de>	<4E0D7CE9.2030209@freescale.com>
	<20110701080158.GB1922@pengutronix.de>
Message-ID: <4E0D87A9.5040203@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi:
> On Fri, Jul 01, 2011 at 03:53:13PM +0800, Huang Shijie wrote:
>> Hi:
>>> Hi Arnd,
>>>
>>>> If you really want to call out obsceneties, how about the fact that this
>>>> driver comes with an 805 line patch to add a HAL for a single chip!
>>>>
>>>> Such abstractions should not be introduced as long as there is only
>>>> a single instance of the hardware.
>>> If I understood correctly, most if not all upcoming i.MX will have the GPMI
>>> (mx50, mx6). Huang, do you already have a draft for the mx50-hal?
>>>
>> I have finished the code for mx50's GPMI.
>> And I am coding for the MX6's GPMI recently.
>>
>> I need a separate mx50-hal (or mx60-hal) to make the code tidy.
>> The MX50 and mx60 support ONFI NAND and TOGGLE nand(which mx23/mx28
>> do not support),
>> they need a long code to initialize the TIMING register. What's
>> more, the READ/WRITE functions
>> are different from the mx23/mx28.
>>
>> Frankly speaking, I can merge the mxs-hal.c file to the gpmi-nfc.c,
>> but don't you think it too
>> messy?
> Is it possible to post the mx50 code (as RFC with a note saying that it
> is not ready yet and is not intended to be merged) so we can see better?
>
The attachment is for mx50 GPMI driver.
You can see the long timing initialization.

I will take a business trip in the following several days.
I will submit new version when i come back to office.


Best regards
Huang Shijie
