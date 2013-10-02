From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 2 Oct 2013 10:51:16 -0300
Subject: Armada XP doesn't boot in v3.12-rc3
In-Reply-To: <20131002124320.GL31178@titan.lakedaemon.net>
References: <CAFJTrDvNYa2g-TFPjii5WpCgnX8kc8r9v3+jzL7gkHCwRV-obg@mail.gmail.com>
 <20131002124320.GL31178@titan.lakedaemon.net>
Message-ID: <20131002135115.GA2423@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 02, 2013 at 08:43:20AM -0400, Jason Cooper wrote:
> On Wed, Oct 02, 2013 at 11:39:53AM +0100, Matthew Minter wrote:
> > Hi,
> > 
> > I am having the same issue as
> > "Re: mvebu: Armada XP doesn't boot in v3.12-rc1".
> > except that I am running rc3.
> > 
> > I am wondering if the mentioned patch was ever released as I currently
> > have an un-bootable board.
> 
> Yes, it's:
> 
>   7b0dd72 arm: clocksource: mvebu: Use the main timer as clock source from DT
> 
> which made it into v3.12-rc3.
> 
> We'll need more information in order to diagnose your problem.  You've
> either stumbled across a different problem, or need to try a clean
> build.  But I'm just guessing since I'm not in front of your box ;-)
> 

The latest DT timer fixes you pushed to arm-soc, doesn't appear to be
in v3.12-rc3. I'll fetch the mail and ping Olof.

Matthew, in case you need the commits:

commit c1bbd430d617faa2bc610c5404486b01d72c34bc
Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Date:   Tue Aug 20 12:45:50 2013 -0300

    ARM: mvebu: Add the reference 25 MHz fixed-clock to Armada XP

commit 3a3c07001b0d4a5eec83bb87284048cd75b81510
Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Date:   Tue Aug 20 12:45:51 2013 -0300

    ARM: mvebu: Add clock properties to Armada XP timer node

Which you can pick from git://git.infradead.org/linux-mvebu.git fixes.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
