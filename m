From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 27 Apr 2012 14:12:53 +0400
Subject: [PATCH] arm: davinci: pdctl next bit position incorrect
In-Reply-To: <4F99870A.6080201@ti.com>
References: <1334745664-19275-1-git-send-email-m-karicheri2@ti.com>
 <4F8F22D1.8080309@ti.com> <4F8FECD6.6050105@mvista.com>
 <4F9042CA.7050305@ti.com> <4F917C12.8080306@mvista.com>
 <4F99870A.6080201@ti.com>
Message-ID: <4F9A7125.6050802@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 26-04-2012 21:34, Sekhar Nori wrote:

>> On 04/19/2012 08:52 PM, Sekhar Nori wrote:

>>>>>> The PDCTL NEXT bit is incorrectly set to bit 1 instead of bit 0. This
>>>>>> patch fixes this issue

>>>>>> Signed-off-by: Murali Karicheri<m-karicheri2@ti.com>

>>>>> Applying this for v3.5.

>>>>      But why not to 3.4? It concerns turning on DSP domain on DM644x.

>>> Yes, but I think as you noted sometime before, no one is really
>>> depending on kernel to turn on DSP domain on DM644x.

>>     Looks like you're right (though I don't remember noting it :-).

>>> Its probably being
>>> done from U-Boot or ROM code. This is not a v3.4 regression either.

>>     U-Boot does it only when DSPLINK support is not desired.

> Okay. Since DSPLink existed long before this code to turn on domain was
> introduced by Murali,

    The code to turn on DSP domain wasn't introduced by Murali, it was there 
originally. Ah, you probably mean that the code was checking PDSTAT0, not 
PDSTAT1 before doing the DSP domain switch?

> it must be having its own private code to do this.
> So, looks like this should not really be a regression for anyone.

    It seems you're right.

> Thanks,
> Sekhar

WBR, Sergei
