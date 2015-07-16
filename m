From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Jul 2015 16:09:42 +0200
Subject: [PATCH 1/2] ARM: ux500: define serial port aliases
In-Reply-To: <CACRpkdaL6DHChx7mSWiGk65LZNxkMGtw=aef2zyHaE7dDhXz8A@mail.gmail.com>
References: <1436520735-23692-1-git-send-email-linus.walleij@linaro.org>
 <2120032.PN20RpmoKe@wuerfel>
 <CACRpkdaL6DHChx7mSWiGk65LZNxkMGtw=aef2zyHaE7dDhXz8A@mail.gmail.com>
Message-ID: <2694937.qjRpGCMvqj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 July 2015 16:03:18 Linus Walleij wrote:
> On Tue, Jul 14, 2015 at 10:53 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 13 July 2015 10:21:51 Linus Walleij wrote:
> >>
> >> Since the original code just defined all three serial ports
> >> for all boards by them including ste-dbx500.dtsi I first made
> >> the patch to that file, and then as you said it had to be done
> >> on a per-toplevel file, I did it in the individual DTS files instead.
> >
> > I'm not following here. If you have boards that want port 1 to be
> > disabled, shouldn't you remove that alias?
> 
> No, that is done by not changing status = "disabled"; to
> status = "okay"; on a per-board basis.
> 
> This is what the second patch is doing.
> 
> The aliases are set also to disabled ports to ensure enumeration
> for the cases where a board file enabled a previously disabled
> UART.
> 

Well, both really. The status property tells the kernel to not
ever touch a device, while the alias is what traditionally gets
used to assign an OS visible device name to a device in the tree.
This is more true for MacOS and AIX than Linux, which sometimes
does its own naming, but we really should not have an alias pointing
at a disabled device node.

	Arnd
