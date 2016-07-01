From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 1 Jul 2016 09:47:19 +0200
Subject: [PATCH v2 06/14] ARM: sun8i: clk: Add clk-factor rate
 application method
In-Reply-To: <643c2648-ddd6-700a-68c0-2981134965c0@megous.com>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-7-megous@megous.com>
 <20160630204001.GC5485@lukather>
 <0b71ed7e-98c9-109e-85e6-ceb95131d88a@megous.com>
 <20160701073710.1a1fc684ae448577bad5b0db@free.fr>
 <643c2648-ddd6-700a-68c0-2981134965c0@megous.com>
Message-ID: <20160701094719.9f7e28d93595d9cf7820e7dd@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 1 Jul 2016 08:34:21 +0200
Ond?ej Jirman <megous@megous.com> wrote:

> > The documentation says that only the CPU and DDR PLLs can be dynamically
> > changed after boot.
> 
> The question is what exactly is meant by after boot. :) Anyway, if the
> kernel has no business changing some other PLLs, if there's code for
> changing them, should it be dropped?

No, because all the other PLLs may not be initialized by the U-boot
(audio, video, gpu...), and also, their rate may be changed safely by
stopping them (gate).

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
