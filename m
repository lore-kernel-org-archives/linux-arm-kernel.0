From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 31 May 2012 20:46:14 +0000
Subject: [RFC PATCH 0/5] omap: add ocp2scp as a misc driver
In-Reply-To: <CAAe_U6J3p9Lh9g82tSSLxOJ7nqrozdRe11zV_v2rqTuMYPjbyA@mail.gmail.com>
References: <1338375394-16268-1-git-send-email-kishon@ti.com>
 <201205310922.18550.arnd@arndb.de>
 <CAAe_U6J3p9Lh9g82tSSLxOJ7nqrozdRe11zV_v2rqTuMYPjbyA@mail.gmail.com>
Message-ID: <201205312046.14823.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 31 May 2012, ABRAHAM, KISHON VIJAY wrote:
> > I would mark the multiplexed device compatible with "simple-bus", which
> > results in the child devices automatically getting added.
> 
> hmm.. ocp2scp has a sysconfig register and it also has a module mode
> by which it can be enabled/disabled. I was making use of pm_runtime
> API's to control these registers (Apart from creating child devices,
> the driver also has a call to pm_runtime_enable). 

I see. 

> I'm not sure if with
> "simple-bus" we'll be able to do those. I have to check on that.

How about making it compatible with both "simple-bus" and something
that handles the pm_runtime requirements?

I don't understand enough of what needs to be done for pm_runtime
across a lot of devices, but I'd hope that it should be possible
to do that in a generic way based on the device definition.

	Arnd
