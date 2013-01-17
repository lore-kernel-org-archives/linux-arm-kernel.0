From: gerg@uclinux.org (Greg Ungerer)
Date: Thu, 17 Jan 2013 22:02:06 +1000
Subject: [PATCH 0/4] gpio: introduce descriptor-based interface
In-Reply-To: <CACRpkda6dqAj+DzrMCnKET7Z9PtuW0+k9ea3YDL8Z1D=oFVRpQ@mail.gmail.com>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com>
 <201301091046.13020.arnd@arndb.de> <2270940.DTxEYMZtED@percival>
 <201301101008.45091.arnd@arndb.de>
 <CACRpkda6dqAj+DzrMCnKET7Z9PtuW0+k9ea3YDL8Z1D=oFVRpQ@mail.gmail.com>
Message-ID: <50F7E83E.8000105@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

(My gerg at snapgear.com email no longer gets to me, gerg at uclinux.org is
the best direct email for me now).

On 01/17/2013 09:15 PM, Linus Walleij wrote:
> On Thu, Jan 10, 2013 at 11:08 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
>> I've tried to find platforms that don't yet use GPIOLIB and fortunately
>> there are very few left:
>>
>> I found two that provide the generic gpio interfaces when gpiolib
>> is disabled, but use gpiolib otherwise for the same hardware,
>> arch/m68k/include/asm/mcfgpio.h and arch/blackfin/include/asm/gpio.h.
>> I would assume that we can simply remove the non-gpiolib shortcut
>> here at cost of a small overhead.
> 
> Geert/Greg: interested in looking into this issue?
> 
> The GPIO maintainers want to get rid of non-gpiolib platforms.

Steven King did most of the ColdFire GPIO work (CC'ed on this).
Steven: are you happy to drop the non-gpiolib support?

Regards
Greg
