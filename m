From: agraf@suse.de (Alexander Graf)
Date: Wed, 9 Jan 2013 23:30:13 +0100
Subject: [kvmarm] [PATCH v5.1 0/2] KVM: ARM: Rename KVM_SET_DEVICE_ADDRESS
In-Reply-To: <1357769438.18196.5@snotra>
References: <1357769438.18196.5@snotra>
Message-ID: <97E481BC-F14D-4866-B44B-878833CA81DC@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 09.01.2013, at 23:10, Scott Wood wrote:

> On 01/09/2013 03:37:20 PM, Alexander Graf wrote:
>> Am 09.01.2013 um 22:15 schrieb Scott Wood <scottwood@freescale.com>:
>> > I get that there's a tradeoff between getting something in now, versus waiting until the API is more refined.  Tagging it with a particular ISA seems like an odd way of saying "soon to be deprecated", though.  What happens if we're still squabbling over the perfect replacement API when we're trying to push PPC MPIC stuff in?
>> Then we're the ones who have to come up with a good interface.
> 
> How about another bad one, with PPC in the name, and some pleas to hurry things up? :-)

Then I'd be the maintainer of that one and tell you whatever I think would be reasonable given the circumstances :).

> It's not as if there haven't been last-minute requests for API changes on the PPC side in the past...

I don't remember a full PPC target merge ever relying on an API change like this.

In fact, in this particular case one could merge all of the patches except for the particular ioctl implementation and just give the respective addresses default values until there is an API to set them, similar to how we did things with PVR in the beginning.

But this is something that's always up to the respective maintainers and I'm not going to interfere with how they do their job :).

> 
>> > Perhaps the threshold for an API becoming "permanent" should not be acceptance into the tree, but rather the removal of an "experimental" tag (including a way of shutting off experimental APIs to make sure you're not depending on them).  Sort of like CONFIG_EXPERIMENTAL, except actually used for its intended purpose (distributions should have it *off* by default), and preferably managed at runtime.  Sort of like drivers/staging, except for APIs rather than drivers.  Changes at that point should require more justification than before merging, but would not have the strict compatibility requirement that non-experimental APIs have.  This would make collaboration and testing easier on APIs that aren't ready to be permanent.
>> This tag does exist. It's called "not in Linus' tree" :).
> 
> Which makes it a pain for multiple people to work on a new feature, especially when it spans components such as KVM and QEMU, and means that it gets less testing before the point of no return.

I agree, but we're not going to solve this one now :). In fact, it'd be even harder to solve (with questionable results) than the actual ioctl in question.


Alex
