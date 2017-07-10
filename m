From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Mon, 10 Jul 2017 14:55:47 +0200
Subject: 4.13-rc0: stopped booting on Nokia N900
In-Reply-To: <20170710100250.GR3730@atomide.com>
References: <20170710074610.GA22846@amd> <20170710081334.GA29726@amd>
 <20170710100250.GR3730@atomide.com>
Message-ID: <20170710125547.4jkw3yhe5poyjkzs@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 10, 2017 at 03:02:50AM -0700, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [170710 01:14]:
> > > I tested linux-next relatively recently, and it worked ok.
> > > af3c8d98508d37541d4bf57f13a984a7f73a328c is broken.
> > > 650fc87 worked ok.
> > 
> > 2b97620 is broken.
> > 
> > commit a51166ce71844ffbb8f78d63647b44dd69e46cf1
> >     Add linux-next specific files for 20170628
> > 
> > was ok.
> 
> Not sure if it's the same issue, but I bisected down an issue with commit
> 46e48e257360 ("genirq: Move irq resource handling out of spinlocked region"),
> so adding Thomas.

I saw your message too late and also bisected the issue I saw to this:

46e48e257360f0845fe17089713cbad4db611e70 is the first bad commit
commit 46e48e257360f0845fe17089713cbad4db611e70
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Thu Jun 29 23:33:38 2017 +0200

    genirq: Move irq resource handling out of spinlocked region

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170710/89827dcc/attachment.sig>
