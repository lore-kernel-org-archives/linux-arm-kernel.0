From: scottwood@freescale.com (Scott Wood)
Date: Thu, 10 Jan 2013 16:40:12 -0600
Subject: [kvmarm] [PATCH v5.1 0/2] KVM: ARM: Rename KVM_SET_DEVICE_ADDRESS
In-Reply-To: <20130110222801.GB17111@amt.cnet> (from mtosatti@redhat.com on
 Thu Jan 10 16:28:01 2013)
Message-ID: <1357857612.27576.19@snotra>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2013 04:28:01 PM, Marcelo Tosatti wrote:
> On Wed, Jan 09, 2013 at 10:37:20PM +0100, Alexander Graf wrote:
> >
> > >
> > >> >> We can start to introduce (and fix ARM) with a generic ioctl  
> in the MPIC patches then.
> > >> >
> > >> > The ioctl is already generic, except for its name.
> > >> It's making a few wrong assumptions:
> > >>  * maximum size of value is u64
> > >
> > > This is tolerable IMHO.
> > >
> > >>  * combining device id (variable) with addr type id (const) into  
> a single field. It could just be split into multiple fields
> > >
> > > I agree, but that could be lived with as well.
> > >
> > > I get that there's a tradeoff between getting something in now,  
> versus waiting until the API is more refined.  Tagging it with a  
> particular ISA seems like an odd way of saying "soon to be  
> deprecated", though.  What happens if we're still squabbling over the  
> perfect replacement API when we're trying to push PPC MPIC stuff in?
> 
> As mentioned, i fail to see the benefit in sharing 0.0x% of the code  
> (the
> interface), while the remaining code is not shared.

Pointlessly making things architecture-specific just makes more work  
for people who later need the functionality on another architecture.   
It might not be much in this case (unless a particular device ends up  
being used on multiple architectures), but the principle still  
applies.  It's also more work for tools like strace, and could get in  
the way of the userspace caller using common code.

> > Then we're the ones who have to come up with a good interface.
> 
> Or just have KVM_SET_PPC_DEVICE_ADDRESS. Is there a downside to that?

Besides the above, and my original complaint that it shouldn't be  
specific to addresses?

-Scott
