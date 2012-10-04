From: stigge@antcom.de (Roland Stigge)
Date: Thu, 04 Oct 2012 22:25:48 +0200
Subject: [PATCH RFC 1/2] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <CACRpkdYGePft_XvhhoNyRfBm484FD46WGagivQzjh5-OE3VJUA@mail.gmail.com>
References: <1348780923-27428-1-git-send-email-stigge@antcom.de>
 <CAOY=C6GG6jqqEAAGJjmDG-BFT2eq=9+ck+F_EOcthRgDCDv8=Q@mail.gmail.com>
 <50682402.8020402@antcom.de>
 <CACRpkdYGePft_XvhhoNyRfBm484FD46WGagivQzjh5-OE3VJUA@mail.gmail.com>
Message-ID: <506DF0CC.9000202@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/10/12 01:07, Linus Walleij wrote:
>> What do others think? JC? Linus? I'm considering this (unsigned int
>> data) a valid option.
> 
> I think we mostly use an unsigned long for such stuff as IRQ flags
> and ioctl() parameters in the kernel.
> 
> In this case it has the upside that it will be 32bit on 32bit systems
> and 64bit on 64bit systems if I'm not mistaken.

Fine. Will try to prepare a patch tomorrow, including fallback to single
GPIO handling (if the driver doesn't implement block operations) and
omitting the sysfs interface in the first patch.

Roland
