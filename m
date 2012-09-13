From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Sep 2012 10:36:29 +0000
Subject: [PATCH V3 5/5] ARM: bcm2708: instantiate console UART
In-Reply-To: <505133CB.1060906@wwwdotorg.org>
References: <1347423509-30647-1-git-send-email-swarren@wwwdotorg.org>
 <201209121045.39999.arnd@arndb.de> <505133CB.1060906@wwwdotorg.org>
Message-ID: <201209131036.29929.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 September 2012, Stephen Warren wrote:
> On 09/12/2012 04:45 AM, Arnd Bergmann wrote:
> > On Wednesday 12 September 2012, Stephen Warren wrote:
> >> From: Simon Arlott <simon@fire.lp0.eu>
> >>
> >> This patch was extracted from git://github.com/lp0/linux.git branch
> >> rpi-split as of 2012/09/08, and modified as follows:
> >>
> >> * Modified UART DT node to use a unit-address to differentiate UART node
> >>   names, rather than using different base names "uart0" and "uart1".
> >>   Note that UART 1 (the Broadcom "mini UART") is not yet present, but
> >>   I'm naming the DT node in anticipation that it will be added.
> >>
> > 
> > Shouldn't the selection be done using an alias like this?
> > 
> >       aliases {
> >               serial0 = &/uart at 20201000;
> >       };
> 
> The "differentiate" was more "ensure that node names in DT are unique"
> than anything to do with user-visible selection/identification.
> 
> I can certainly add the alias if you want, but I don't know what benefit
> it will have, since I've never used aliases before.

The idea of the aliases is that you can identify which port to use
if one passes an argument like "console=ttyS0" or opens a specific
/dev/tty* device node. I believe we don't actually use it that way
at the moment though.

	Arnd
