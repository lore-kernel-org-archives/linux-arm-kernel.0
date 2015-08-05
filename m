From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 5 Aug 2015 18:21:55 +0200
Subject: Armadaxp GPIO interrupts
In-Reply-To: <CAG1O52VQPpeGkA8bqYbPMTiT9Mua1yHi3H3osqJsHqm-RRKzow@mail.gmail.com>
References: <CAG1O52Xg88OsifBzmpSdqvC8wQaOW78nC9nnfxugFv1VU1m1LQ@mail.gmail.com>
 <20150804153439.GA28673@lunn.ch>
 <CAG1O52W2Gy_6_DfewtUqoK_J+Y=KwVGyygNaPu2xyPM_ZkLfcQ@mail.gmail.com>
 <CAG1O52VQPpeGkA8bqYbPMTiT9Mua1yHi3H3osqJsHqm-RRKzow@mail.gmail.com>
Message-ID: <20150805162155.GE32760@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 05, 2015 at 08:31:27PM +0530, raghu MG wrote:
> Hi Andrew,
> 
> The issue I found was  irq_alloc_descs is called twice
> 1st time inside   mvebu_gpio_probe & 2nd time inside irq_domain_add_simple.

So i'm somewhat confused. I just tested on my Kirkwood and 370
platforms, and an Armada XP WRT1900AC using 4.2.0-rc5, all which use
the same gpio driver.

They boot fine, the gpio driver is loaded, and the interrupt for the
gpio connected to a button are listed in /proc/interrupts. The
gpio-key driver is also able to use the gpio and the input-events
program does show events when i press the button.

So what is different with your platform?

   Andrew
