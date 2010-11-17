From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Nov 2010 17:07:27 +0000
Subject: [PATCH 0/9] Clean up SMP IPI support
In-Reply-To: <20101115175553.GC31421@n2100.arm.linux.org.uk>
References: <20101115175553.GC31421@n2100.arm.linux.org.uk>
Message-ID: <1290013647.2351.62.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-11-15 at 17:55 +0000, Russell King - ARM Linux wrote:
> This series is aimed at cleaning up our SMP IPI support.  As has been
> recently pointed out, we have a spinlock in percpu data, which is not
> very nice.
> 
> If we switch to using the GIC SGIs, one for each IPI function, then
> we don't need the mask of ipi bits indicating what work needs to be
> done.  This allows us to get rid of the troublesome spinlock in
> send_ipi_message().

FWIW, the patches look fine to me (though I have tested them):

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
