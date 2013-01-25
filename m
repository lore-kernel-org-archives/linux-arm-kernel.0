From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 25 Jan 2013 08:50:11 -0500
Subject: [BUG] panda board locks up on boot
In-Reply-To: <20130125085234.GY23505@n2100.arm.linux.org.uk>
References: <1359082886.21576.199.camel@gandalf.local.home>
 <20130125085234.GY23505@n2100.arm.linux.org.uk>
Message-ID: <1359121811.21576.217.camel@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-01-25 at 08:52 +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 24, 2013 at 10:01:26PM -0500, Steven Rostedt wrote:
> > I've recently started testing my work on arm boards and have found that
> > they both don't boot under the latest kernel anymore. I already posted
> > about my snowball board, but my panda board also locks up.
> 
> You need to enable DMA engine and the OMAP DMA engine driver.  I believe
> someone was going to work on adding PIO-mode support to the driver but
> I suspect as TI's OMAP division is being reorganized, all that is now
> uncertain.

Well, I be darn...


Yep, selecting DMA_OMAP which selects DMA_ENGINE makes everything
better. Who'da thunk?

Now only if there was a config option missing for my snowball?

Thanks!

-- Steve
