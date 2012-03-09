From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Fri, 9 Mar 2012 10:32:30 +0100
Subject: [RFC] i.MX: drop secondary clocks
In-Reply-To: <1331242949-22780-1-git-send-email-s.hauer@pengutronix.de>
References: <1331242949-22780-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20313.52782.832292.580932@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sascha Hauer writes:
> Hi All,
> 
> On i.MX we currently have grouped clocks, also known as secondary clocks.
> These are clocks that get enabled when the primary clock gets enabled.  This
> doesn't integrate well into the generic clock framework. Also we often return
> the rate of one clock and really enable/disable another clock. I plan to get
> rid of these clocks by exposing the individual clocks to the drivers. The
> following is meant as an example how this can be done. I have a more complete
> series internally but this conflicts with Richards clk_prepare series.
> 
> Thanks to the nature of clk_get we can simply clk_get the individual clocks in
> the drivers and the current clock implementation will always return the one
> with con_id = NULL. Then with the generic clk implementation the drivers will
> finally get the individual clocks.
> 
> So unless there are objections I will follow up on this after the next merge
> window.
> 
I think that's a bad idea! Drivers should not have to know intimate
details about the clock logic of the CPU core they are running on!

They should simply request a clock for the unit they operate on and
the clock core code should figure out which other clocks need to be
enabled on a specific machine to get the unit working.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
