From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 26 May 2015 13:51:55 +0200
Subject: [PATCH 1/2] PWM: atmel: fix incorrect CDTY value after enabling
In-Reply-To: <5564366D.9090707@atmel.com>
References: <1432559996-4415-1-git-send-email-alexandre.belloni@free-electrons.com>
 <5564366D.9090707@atmel.com>
Message-ID: <20150526115155.GF3199@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/05/2015 at 11:01:33 +0200, Nicolas Ferre wrote :
> Le 25/05/2015 15:19, Alexandre Belloni a ?crit :
> > CUPD is not flushed before enabling the channel so it will update CDTY/CPRD just
> > after one period. So we always set CUPD, even when the channel is not enabled.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> BTW, is a "stable tag" needed for this one?
> 

I had a look and both can probably be backported up to 3.14.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
