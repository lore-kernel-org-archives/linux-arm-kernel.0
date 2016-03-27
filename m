From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 27 Mar 2016 23:30:21 +0200
Subject: [PATCH] ARM: dts: veyron: enable the tsadc on pinky board
In-Reply-To: <56F48D19.1050702@gmail.com>
References: <1450607434-6733-1-git-send-email-wxt@rock-chips.com>
 <2324215.uYLQVgh5FL@diego> <56F48D19.1050702@gmail.com>
Message-ID: <2666341.7YP6MciD7F@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Am Freitag, 25. M?rz 2016, 08:58:01 schrieb Caesar Wang:
> ? 2016?03?25? 05:12, Heiko St?bner ??:
> > Am Sonntag, 20. Dezember 2015, 18:30:34 schrieb Caesar Wang:
> >> I think the tsadc is fakly hand on pinky board,
> >> maybe that's fixed in newest kernel.
> >> As the following patch is a example:
> >> https://patchwork.kernel.org/patch/7472051/
> >> 
> >> I don't have meet this issue on pinky board.
> >> Let me know if that's still hanging on pinky board.
> >> 
> >> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> > 
> > I just gave that a try again on my pinky-rev2. And while the tsadc did
> > produce some results and didn't hang the system in my tries, the
> > temperature values seemed to be frozen (only changing once on every
> > reboot).
> > 
> > Running the same kernel on a Jerry produced the expected results of the
> > temperature changing over time and differing cpu frequencies.
> > 
> > Pinky also is a sort of dinosaur and only you and me seem to still like
> > them> 
> > :-) . And something is definitly strange here, and I'd tend to keep the
> > :tsadc> 
> > disabled for the time being.
> 
> I remember the same issue on
> https://code.google.com/p/chrome-os-partner/issues/detail?id=35060 in
> the past
> 
> "thermal can 't work if  the hardware C1106 isn't removed in the
> attachment."
> 
> So I think you can change this early board.

As I'm a total noob when it comes to soldering (especially on such a tiny 
scale), I don't think that is an option ;-) .

Reading that bug report again, brought back memories, that exactly this was 
the issue why suspend didn't work correctly for me then.

So I still think I'll keep the tsadc on pinky as it is now - as I said before, 
it looks like you and me are the only people still caring for pinky and 
everybody else most likely put theirs into the trash already, so nothing 
terrible important is affected by this :-)


Heiko
