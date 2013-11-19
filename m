From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Tue, 19 Nov 2013 10:31:50 -0800
Subject: [BUG,REGRESSION?] 3.11.6+,3.12: GbE iface rate drops to few KB/s
In-Reply-To: <20131119174323.GH913@1wt.eu>
References: <87y54u59zq.fsf@natisbad.org> <20131112083633.GB10318@1wt.eu>
 <87a9hagex1.fsf@natisbad.org> <20131112100126.GB23981@1wt.eu>
 <87vbzxd473.fsf@natisbad.org> <20131113072257.GB10591@1wt.eu>
 <20131117141940.GA18569@1wt.eu>
 <1384710098.8604.58.camel@edumazet-glaptop2.roam.corp.google.com>
 <87li0kkhzx.fsf@natisbad.org>
 <1384869194.8604.92.camel@edumazet-glaptop2.roam.corp.google.com>
 <20131119174323.GH913@1wt.eu>
Message-ID: <1384885910.8604.110.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-11-19 at 18:43 +0100, Willy Tarreau wrote:

> - #define MVNETA_TX_DONE_TIMER_PERIOD 10
> + #define MVNETA_TX_DONE_TIMER_PERIOD (1000/HZ)
> 

I suggested this in a prior mail :

#define MVNETA_TX_DONE_TIMER_PERIOD 1

But apparently it was triggering strange crashes...

> This can only have any effect if you run at 250 or 1000 Hz, but not at 100
> of course. It should reduce the time to first IRQ.
