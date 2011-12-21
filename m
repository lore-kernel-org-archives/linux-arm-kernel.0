From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 21 Dec 2011 16:24:49 +0400
Subject: [PATCH v2] davinci: DA850 EVM: OHCI platform code
In-Reply-To: <4EF1CB8A.10309@mvista.com>
References: <1324452002-8388-1-git-send-email-prakash.pm@ti.com>
 <DF0F476B391FA8409C78302C7BA518B6051CB9@DBDE01.ent.ti.com>
 <4EF1CB8A.10309@mvista.com>
Message-ID: <4EF1D011.8060103@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 21-12-2011 16:05, I wrote:

>> On Wed, Dec 21, 2011 at 12:50:02, Manjunathappa, Prakash wrote:
>>> From: Ajay Kumar Gupta<ajay.gupta@ti.com>

>>> On this board the OHCI port's power control and over-current signals from
>>> TPS2065 power switch are connected via GPIO2[4] and GPIO6[13] respectively,
>>> so we can implement the DA8xx OHCI glue layer's hooks for overriding the
>>> root hub port's power and over-current status bits.

>>> We also have to properly set up the clocking mode in the CFGCHIP2 register,
>>> so that internal 24 MHz reference clock is fed to the USB 2.0 (MUSB) PHY and
>>> its output is used to clock the USB 1.1 (OHCI) PHY...

>>> Signed-off-by: Ajay Kumar Gupta<ajay.gupta@ti.com>
>>> Signed-off-by: Manjunathappa, Prakash<prakash.pm@ti.com>

>> This is the third copy of OHCI platform setup code which is almost
>> the same except for the GPIO numbers.

> Well, in my counting, it's only second, DA830 EVM being the first one.
> What's the third?

    Ah, I missed Hawkboard... :-)

 >    I designed the hub interface to be as abstract as I could, and now you're
 > proposing to add GPIO to it? No, I have no clear idea how to keeep it
 > abstract and add GPIO support at the same time. I would have been grateful to
 > TI if I didn't have to invent this at all and they stop saving on OHCI pins.

    Well, I have one idea. We can create a separate module in 
arch/arm/mach-davinci/, named say ohci.c, put the shared code there and pass 
to it the GPIOs actually used via a function call. Or maybe use existing 
arch/arm/mach-davinci/usb.c.

WBR, Sergei
