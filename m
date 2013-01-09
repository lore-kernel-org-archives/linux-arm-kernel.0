From: scottwood@freescale.com (Scott Wood)
Date: Wed, 9 Jan 2013 16:10:38 -0600
Subject: [kvmarm] [PATCH v5.1 0/2] KVM: ARM: Rename KVM_SET_DEVICE_ADDRESS
In-Reply-To: <4F8BA51C-1A21-4ED9-80CE-55ECB01C0AAD@suse.de> (from
 agraf@suse.de on Wed Jan  9 15:37:20 2013)
Message-ID: <1357769438.18196.5@snotra>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/2013 03:37:20 PM, Alexander Graf wrote:
> 
> 
> Am 09.01.2013 um 22:15 schrieb Scott Wood <scottwood@freescale.com>:
> 
> > I get that there's a tradeoff between getting something in now,  
> versus waiting until the API is more refined.  Tagging it with a  
> particular ISA seems like an odd way of saying "soon to be  
> deprecated", though.  What happens if we're still squabbling over the  
> perfect replacement API when we're trying to push PPC MPIC stuff in?
> 
> Then we're the ones who have to come up with a good interface.

How about another bad one, with PPC in the name, and some pleas to  
hurry things up? :-)

It's not as if there haven't been last-minute requests for API changes  
on the PPC side in the past...

> > Perhaps the threshold for an API becoming "permanent" should not be  
> acceptance into the tree, but rather the removal of an "experimental"  
> tag (including a way of shutting off experimental APIs to make sure  
> you're not depending on them).  Sort of like CONFIG_EXPERIMENTAL,  
> except actually used for its intended purpose (distributions should  
> have it *off* by default), and preferably managed at runtime.  Sort  
> of like drivers/staging, except for APIs rather than drivers.   
> Changes at that point should require more justification than before  
> merging, but would not have the strict compatibility requirement that  
> non-experimental APIs have.  This would make collaboration and  
> testing easier on APIs that aren't ready to be permanent.
> 
> This tag does exist. It's called "not in Linus' tree" :).

Which makes it a pain for multiple people to work on a new feature,  
especially when it spans components such as KVM and QEMU, and means  
that it gets less testing before the point of no return.

-Scott
