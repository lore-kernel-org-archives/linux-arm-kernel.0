From: dev@lynxeye.de (Lucas Stach)
Date: Mon, 24 Nov 2014 22:41:39 +0100
Subject: serial: of-serial: fetch line number from DT
In-Reply-To: <CAOesGMhe8orqL6wSiouQvdM8y4N44p12n7M1opraSkAP=3ZB+A@mail.gmail.com>
References: <CAOesGMjzs=dThDv6S8Xvo+ym-XECaQhTQ8NV6t46fQZ1LoJnHw@mail.gmail.com>
 <20141111052407.GB24727@kroah.com>
 <CAOesGMhe8orqL6wSiouQvdM8y4N44p12n7M1opraSkAP=3ZB+A@mail.gmail.com>
Message-ID: <1416865299.2180.1.camel@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Am Dienstag, den 11.11.2014, 08:51 -0800 schrieb Olof Johansson:
> On Mon, Nov 10, 2014 at 9:24 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Mon, Nov 10, 2014 at 01:34:19PM -0800, Olof Johansson wrote:
> >> Greg,
> >>
> >> This commit:
> >>
> >> commit 1bd8324535ec1ff44aef55c0e40b9e7d56b310fb
> >> Author: Lucas Stach <dev@lynxeye.de>
> >> Date:   Mon Nov 3 23:16:54 2014 +0100
> >>
> >>     serial: of-serial: fetch line number from DT
> >>
> >>     The general agreed way to specify a fixed line number
> >>     for a serial console is to provide a "serial" alias
> >>     in the devicetree. Start parsing this property in
> >>     of_serial.
> >>
> >>     Signed-off-by: Lucas Stach <dev@lynxeye.de>
> >>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>
> >>
> >> Broke a whole lot of tegra boards in last night's -next here. In
> >> particular, I've been looking at tegra20-seaboard, which now doesn't
> >> boot with console any more.
> >>
> >> http://arm-soc.lixom.net/bootlogs/next/next-20141110/
> >>
> >> Unfortunately, tegra has for a long time been specifying the aliases
> >> as a fixed 1:1 mapping, but most environments rely on ttyS0 being the
> >> first _activated_ serial port. That's obviously going to break things
> >> here. :(
> >>
> >> Greg, can you please revert until we get the tegra-side fixes in for
> >> this, or we're in for a pretty lousy time w.r.t. bisecting problems
> >> across the two mergepoints?
> >>
> >> Stephen: I suppose the best way to handle this on tegra is to specify
> >> the aliases per-board instead of in the soc dtsi today.
> >>
> >> Apologies for not replying to the patch directly -- it was only ever
> >> posted to linux-serial and I don't seem to be subscribed.
> >
> > Now reverted, sorry for the problems.
> 
> No worries, it's what linux-next is for. Thanks for the revert!
> 
As 3.18-rc6 now landed the fix to avoid the regression on Tegra would
you please consider reapplying this patch?

Regards,
Lucas
