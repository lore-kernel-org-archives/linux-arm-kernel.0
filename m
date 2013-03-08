From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 7 Mar 2013 22:02:28 -0300
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130307230516.GA28975@obsidianresearch.com>
References: <1362577426-12804-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306190821.GA4689@obsidianresearch.com>
 <20130306202710.15a6aa2c@skate>
 <20130306202447.GA4916@obsidianresearch.com>
 <20130306214036.62fc93b9@skate>
 <20130306215031.GB4916@obsidianresearch.com>
 <20130306222712.GP23237@titan.lakedaemon.net>
 <20130306230412.GA5870@obsidianresearch.com>
 <20130307222004.GA2450@localhost>
 <20130307230516.GA28975@obsidianresearch.com>
Message-ID: <20130308010227.GA19029@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Thu, Mar 07, 2013 at 04:05:16PM -0700, Jason Gunthorpe wrote:
> On Thu, Mar 07, 2013 at 07:20:05PM -0300, Ezequiel Garcia wrote:
> > Now that the Device Bus driver is posted I think we have a nice example
> > on how address decoding windows would be allocated through the mbus
> > driver, *without* touching the child driver (i.e. NOR driver).
> 
> No, that isn't the case. Your device bus driver *is* the child driver,
> and you have touched it by adding mbus window code :)
> 
> In fact, looking at what you've done - with the DTs you've proposed
> your driver does *nothing* but make a call to the mbus driver to setup
> the windows for its children. Without timing parameters from the DT the
> driver does nothing else!
> 

Yes, setting aside the timings parameters, the Device Bus driver is only
charge of allocating the windows; perhaps we can say nothing more, nothing less :)

> > In conclusion: there is absolutely no need to change the NOR driver,
> > and there is no need to explictly add an explicit description of the
> > NOR window in the device tree.
> 
> As I've said, a DT that has child nodes without an associated address
> map is broken.
> 

Mmm... could explain me better, why you think it's *broken*?

Perhaps I'm slower than most people around here, but I still
don't fully understand this brokenness.

Thanks,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
