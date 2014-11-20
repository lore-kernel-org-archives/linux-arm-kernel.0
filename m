From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 20 Nov 2014 10:16:32 -0800
Subject: [arm-soc:next/soc 1/1] WARNING: vmlinux.o(.text+0x730e38): Section
 mismatch in reference from the function brcmstb_gisb_arb_probe() to the
 function .init.text:hook_fault_code()
In-Reply-To: <70798892.n4gYya0yuK@wuerfel>
References: <22844091.DkblDJL9Ph@wuerfel>
 <CACRpkdZ6AovXUVvvdyeUczVpGfkexLHMOaA+F3eiBG=W8gtBGg@mail.gmail.com>
 <70798892.n4gYya0yuK@wuerfel>
Message-ID: <546E3000.4040309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2014 02:33 AM, Arnd Bergmann wrote:
> On Wednesday 12 November 2014 11:27:20 Linus Walleij wrote:
>> On Tue, Nov 11, 2014 at 11:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>>> The problem was introduced by f1bee783dd37 "bus: brcmstb_gisb: register the
>>> fault code hook", as hook_fault_code is an __init function and is now
>>> called from a probe function.
>>
>> I hope it's not my fault, it doesn't seem to have my name on it 
> 
> No, it's not. The reason that the build bot sent it to you is that you
> fixed another problem that prevented the kernel from getting built, so
> now it builds again and we see the new warning that was introduced while
> the kernel didn't build.

I just sent a fix for this as
1416507286-14083-1-git-send-email-f.fainelli at gmail.com

Thanks!
--
Florian
