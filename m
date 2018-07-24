From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 25 Jul 2018 01:23:21 +0800
Subject: [linux-sunxi] Re: [PATCH v2 00/18] Allwinner R40 HDMI refactoring
In-Reply-To: <2421648.YmhYGBseh5@jernej-laptop>
References: <20180710203511.18454-1-jernej.skrabec@siol.net>
 <20180724123741.bbkjgy2uwmzsj45k@flea>
 <f77bcb551d60e9d5332dad20c1ef1a1e83ddcc5b.camel@aosc.io>
 <2421648.YmhYGBseh5@jernej-laptop>
Message-ID: <706812FC-7DE2-476E-845C-8429AECC797A@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?7?25? GMT+08:00 ??1:20:42, "Jernej ?krabec" <jernej.skrabec@siol.net> ??:
>Dne torek, 24. julij 2018 ob 18:04:49 CEST je Icenowy Zheng napisal(a):
>> ? 2018-07-24?? 14:37 +0200?Maxime Ripard???
>> 
>> > On Sun, Jul 22, 2018 at 04:43:56PM +0200, Jernej ?krabec wrote:
>> > > Hi Maxime,
>> > > 
>> > > Dne sreda, 11. julij 2018 ob 10:30:36 CEST je Maxime Ripard
>> > > 
>> > > napisal(a):
>> > > > On Tue, Jul 10, 2018 at 10:34:53PM +0200, Jernej Skrabec wrote:
>> > > > > This series fixes several issues found in R40 HDMI patch
>series
>> > > > > after
>> 
>> > > > > it was applied. Conversation can be found here:
>>
>http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/586011.htm
>> 
>> > > > > l
>> > > > > 
>> > > > > Patches are based on latest linux-next (next-20180710) and
>are
>> > > > > ordered
>> > > > > in such way that they don't break R40 HDMI at any time.
>Because
>> > > > > of that
>> > > > > I suggest that whole series goes through drm-misc to preserve
>> > > > > that order.
>> > > > > 
>> > > > > I also tested those patches on H3 to make sure it doesn't
>break
>> > > > > other
>> > > > > platforms. However, it would be nice to test for regressions
>> > > > > also on
>> > > > > older SoCs (with DE1).
>> > > > > 
>> > > > > Best regards,
>> > > > > Jernej
>> > > > 
>> > > > Applied all patches but the patch 10, thanks!
>> > > > Maxime
>> > > 
>> > > It seems that you forgot to merge some patches:
>> > > 
>> > > [PATCH v2 12/18] drm/sun4i: tcon: Add another way for matching
>> > > mixers with
>> > > tcon
>> > > [PATCH v2 13/18] drm/sun4i: tcon: Add support for R40 TCON
>> > > 
>> > > Without them, R40 display pipeline can't work.
>> > > 
>> > > Maybe they are in your spam folder?
>> > 
>> > Thanks for telling me, I'm not quite sure what happened.
>> > 
>> > I've applied them.
>> 
>> BTW without them the board cannot boot because of dead loop in
>> sun4i_drv_probe().
>
>Does it work for you now?

Yes, although it cannot output 1920x1200 to my father's DVI
monitor, but if it output a smaller resolution (e.g. 1024x600, by
insert my WaveShare LCD first then the monitor) it works.

>
>> 
>> > Sorry,
>> > Maxime
>> > 
>> > _______________________________________________
>> > linux-arm-kernel mailing list
>> > linux-arm-kernel at lists.infradead.org
>> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
>
>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
