From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Nov 2010 17:17:28 +0000
Subject: [PATCH 0/9] Clean up SMP IPI support
In-Reply-To: <1290013647.2351.62.camel@e102109-lin.cambridge.arm.com>
References: <20101115175553.GC31421@n2100.arm.linux.org.uk>
	<1290013647.2351.62.camel@e102109-lin.cambridge.arm.com>
Message-ID: <1290014248.2351.63.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-11-17 at 17:07 +0000, Catalin Marinas wrote:
> On Mon, 2010-11-15 at 17:55 +0000, Russell King - ARM Linux wrote:
> > This series is aimed at cleaning up our SMP IPI support.  As has been
> > recently pointed out, we have a spinlock in percpu data, which is not
> > very nice.
> > 
> > If we switch to using the GIC SGIs, one for each IPI function, then
> > we don't need the mask of ipi bits indicating what work needs to be
> > done.  This allows us to get rid of the troublesome spinlock in
> > send_ipi_message().
> 
> FWIW, the patches look fine to me (though I have tested them):
                                              ^^^^
I meant I have *not* tested them.

-- 
Catalin
