From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 23 Aug 2013 10:07:35 -0300
Subject: [PATCH 7/7] watchdog: orion: Update device-tree binding
 documentation
In-Reply-To: <52175C21.603@gmail.com>
References: <1377182518-12554-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377182518-12554-8-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130823012621.GD13964@titan.lakedaemon.net>
 <20130823100450.GA2389@localhost> <20130823125311.GH2389@localhost>
 <52175C21.603@gmail.com>
Message-ID: <20130823130734.GI2389@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 02:57:05PM +0200, Sebastian Hesselbarth wrote:
> On 08/23/13 14:53, Ezequiel Garcia wrote:
> > On Fri, Aug 23, 2013 at 07:04:51AM -0300, Ezequiel Garcia wrote:
> >> On Thu, Aug 22, 2013 at 09:26:21PM -0400, Jason Cooper wrote:
> >>> On Thu, Aug 22, 2013 at 11:41:58AM -0300, Ezequiel Garcia wrote:
> >>>> diff --git a/Documentation/devicetree/bindings/watchdog/orion-wdt.txt b/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
> >>>> index 5dc8d30..bb7f1a2 100644
> >>>> --- a/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
> >>>> +++ b/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
> >>>> @@ -13,7 +16,9 @@ Example:
> >>>>
> >>>>   	wdt at 20300 {
> >>>>   		compatible = "marvell,orion-wdt";
> >>>> -		reg = <0x20300 0x28>;
> >>>> +		reg = <0x20300 0x4
> >>>> +		       0x20324 0x4
> >>>> +		       0x20108 0x4>;
> >>>
> >>> I don't like this.  It reaches outside of the wdt register.  I think a
> >>> more clean way to do this is to do a provider/consumer relationship as
> >>> in reset.txt.  eg, here you would retain the original reg binding, and
> >>> add a reset phandle.
> >>
> >> Mmm... I can't see how this fits a reset-controller usage.
> >>
> >> The watchdog simply "enables" the RSTOUT bit that allows the whole SoC
> >> to be reset when the watchdog counter expires.
> >>
> >> The reset-controller seems to be meant to send reset signals to devices,
> >> which is not this case.
> >>
> >> What am I missing?
> >
> > Another possible solution is to simply "enable" the RSTOUT bit for
> > watchdog somewhere in mach-{kirkwood,mvebu,...} at board boot-up time.
> >
> > Do you think that would have any drawbacks?
> 
> IMHO, it should be fine to always enable watchdog reset -> rstout_n
> assertion. The watchdog driver does it unconditionally anyway.
> We can move it to arch specific code now, and reset API handler later.
> 

Indeed, that's more or less what I was thinking about :-)
I'll re-send then with these modifications.

Thanks,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
