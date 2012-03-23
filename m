From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Fri, 23 Mar 2012 11:05:12 -0400
Subject: ioremap to a specific virtual address
In-Reply-To: <4F6C8E15.5050104@antcom.de>
References: <CAKON4Ox5YXvbGwbsYRetOPxV+HVDwmEd-mbqj2fyDfnCcBjaRA@mail.gmail.com>
 <alpine.LFD.2.02.1203230023060.24151@xanadu.home>
 <CAKON4Ox6sp5YMryr2jzOAqYNmJG9RyahLTusrHZ_jcNQ40DAfQ@mail.gmail.com>
 <201203231407.00686.arnd@arndb.de> <4F6C8E15.5050104@antcom.de>
Message-ID: <CAKON4Oz8465uJnv8R_TgCeju9UqG8MTTxVSC_tfS4mP40ARp1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 23, 2012 at 10:52 AM, Roland Stigge <stigge@antcom.de> wrote:
> Hi Jon,
>
> On 23/03/12 15:07, Arnd Bergmann wrote:
>> I think you should work together with Roland Stigge, who is currently
>> looking into doing the same for lpc32xx. My guess is that you can save
>> a lot of work by combining your efforts, while you would get conflicting
>> DT bindings if you don't. Note that Roland has done a lot of patches
>> already for nxp device drivers that will be part of v3.4. He has not yet
>> started on DT patches but wants to work on that for v3.5.
>
> You wrote about NXP's BSP from 3 years ago. At git.lpclinux.com, you can
> find lpc31xx's branches, updated only some weeks ago, based on Linux 2.6.33.

I've taken the 2.6.33 code and forward ported it to v3.3 in my git
tree. I've been incorporating the patches posted to lpclinux.com.

>
> Feel free to join my efforts for DT on lpc32xx. Don't know how much
> lpc31xx and lpc32xx have in common, and I currently don't have access to

Bangaragiri --- which peripherals do the lpc31xx and the lpc32xx
families have in common?

I know I2C is common and the lpc31xx uses the common driver.
LCD is completely different.
No Ethernet on the lpc31xx.

What about USB? There is code for a NXP variation on EHCI in the
lpc31xx port, does the lpc32xx use the same EHCI block?

Does the lpc32xx have the same event router for interrupts?

What about the rest of the peripherals?

> an lpc31xx device. However, I will post patches for DT support on
> lpc32xx, based on the patches I already have at git.antcom.de and
> antcom.de/lpc32xx/ (some of which already go into v3.4).
>
> Thanks,
>
> Roland



-- 
Jon Smirl
jonsmirl at gmail.com
