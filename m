From: scottwood@freescale.com (Scott Wood)
Date: Wed, 9 Jan 2013 13:50:07 -0600
Subject: [kvmarm] [PATCH v5.1 0/2] KVM: ARM: Rename KVM_SET_DEVICE_ADDRESS
In-Reply-To: <98D0981A-0EB4-4273-BFF8-B25C4BE5EE02@suse.de> (from
 agraf@suse.de on Wed Jan  9 10:48:47 2013)
Message-ID: <1357761007.18196.0@snotra>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/2013 10:48:47 AM, Alexander Graf wrote:
> 
> On 09.01.2013, at 17:26, Christoffer Dall wrote:
> 
> > Renames the KVM_SET_DEVICE_ADDRESS to KVM_ARM_SET_DEVICE_ADDR
> > to make it obvious that this is ARM specific in lack of a better  
> generic
> > interface.
> >
> > Once we agree on a better interface the KVM/ARM code can also take
> > advantage of that, but until then we don't want to hold up the  
> KVM/ARM
> > patches.
> 
> Works for me. Scott, are you happy with this one too?

Not really, given that it will stay around forever even after something  
new is introduced.

If you're going to change the name, why not just change it to  
KVM_SET_DEVICE_CONFIG?  Can we change the name later if nothing else  
changes (so it's still binary compatible)?

> We can start to introduce (and fix ARM) with a generic ioctl in the  
> MPIC patches then.

The ioctl is already generic, except for its name.

-Scott
