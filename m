From: mturquette@ti.com (Mike Turquette)
Date: Thu, 21 Jun 2012 10:54:43 -0700
Subject: [PATCH v3 0/4] DT clock bindings
In-Reply-To: <4FE33723.3040403@gmail.com>
References: <1339512111-11172-1-git-send-email-robherring2@gmail.com>
 <87bokd15x7.fsf@octavius.laptop.org> <4FE33723.3040403@gmail.com>
Message-ID: <20120621175443.GL4402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120621-10:00, Rob Herring wrote:
> On 06/21/2012 02:27 AM, Chris Ball wrote:
> > 
> > 2) Use alloc_bootmem() instead of kzalloc() in of_clk_add_provider(),
> >    because we need to set up clocks during .init_early on ARM (which
> >    happens pre-slab) so that they are available for platform init.
> 
> This depends on 1 as the common clock code would have the same issue.
> Generally, the first place clocks are needed is the timer init. At that
> point, you can call kzalloc. This is where all the clock init used to be
> done until init_early was added and some platforms have moved their
> clock init. I don't think there was really ever much reason to move it
> other than to make the timer init function only deal with timer setup.
> 

Hi Rob,

Just FYI I've been looking at using alloc_bootmem in the common clk code
as a way to get rid of the static initialization stuff (which only
existed due to very early initialization of timers).

The suggested change above to of_clk_add_provider would jive well with
my change to the common clk code.

Regards,
Mike
