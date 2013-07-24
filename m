From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Jul 2013 17:29:58 +0100
Subject: [PATCH 06/14] ARM: twd: data endian fix
In-Reply-To: <51EFED92.2050408@codethink.co.uk>
References: <1374661682-9349-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374661682-9349-7-git-send-email-ben.dooks@codethink.co.uk>
 <20130724144923.GO11072@mudshark.cambridge.arm.com>
 <51EFED92.2050408@codethink.co.uk>
Message-ID: <20130724162958.GU11072@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 04:06:58PM +0100, Ben Dooks wrote:
> On 24/07/13 15:49, Will Deacon wrote:
> > On Wed, Jul 24, 2013 at 11:27:54AM +0100, Ben Dooks wrote:
> >> Ensure the twd driver uses the correct calls to access the hardware
> >> to ensure that we do not end up with data in the wrong endian format.
> >>
> >> Signed-off-by: Ben Dooks<ben.dooks@codethink.co.uk>
> >
> > Reviewed-by: Will Deacon<will.deacon@arm.com>
> >
> > There are a bunch of other __raw_* users under arch/arm/, but I suppose we
> > can let other people move those over as they see fit. It wouldn't hurt to
> > fix arch/arm/include/asm/{cti,hardware/coresight.h} though.
> 
> I didn't think to look for things under there.
> 
> Do people think it would be worth just changing __raw_read/__raw_write
> functions to also take into account endian-ness?

That's probably a bit too far and will likely break some of the many drivers
which use these accessors. It also puts us at odds with other architectures
offering these accessors, so we're better off just fixing the callsites as
appropriate.

Will
