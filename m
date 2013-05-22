From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 22 May 2013 20:13:23 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130522180935.GJ31290@titan.lakedaemon.net>
References: <201305221633.46705.arnd@arndb.de> <20130522170643.54a2b9d2@skate>
 <201305221735.11815.arnd@arndb.de> <20130522180842.7edcc3ee@skate>
 <20130522163557.GC27348@1wt.eu> <20130522184250.1d5f2f10@skate>
 <20130522164936.GE31290@titan.lakedaemon.net>
 <20130522185757.60091a66@skate>
 <20130522171359.GG31290@titan.lakedaemon.net>
 <20130522200513.5e266edc@skate>
 <20130522180935.GJ31290@titan.lakedaemon.net>
Message-ID: <20130522201323.1c7ba6e0@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Wed, 22 May 2013 14:09:35 -0400, Jason Cooper wrote:

> > > Is this something users would experience?  I think it is fairly safe to
> > > say that once dt-able bootloaders are shipped, they will provide a dtb.
> > > So, OF_DT_MAGIC == new bootloader might hold true for users.
> > 
> > We could be tempted to say that, but since what users trying to do this
> > would experience is a completely silent kernel, no message, nothing,
> > I'm not sure I like this too much.
> 
> Ok, I buy that.  Having stared at blank terminals many times, that's
> not cool. :(  It really hurts to hear the HD spin down too.  It just
> sounds like something died a horrible agonizing death.

The other day, I was precisely trying to boot a kernel in a DT-way from
a bootloader that was in fact not DT capable (but I hadn't realized
that). And the kernel had no earlyprintk support. It was really
frustrating. No message at all, nothing. If we can avoid that
experience to the users of the Marvell platforms, I'd prefer. Something
that fails later on during boot is less problematic because at least
you get an error message that you can copy/paste in Google, or that
gives you some initial clue of what's going on. But a completely silent
kernel is terrifying.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
