From: cdall@linaro.org (Christoffer Dall)
Date: Thu, 2 Mar 2017 13:29:06 +0100
Subject: [PATCH V2 2/2] KVM: arm64: Increase number of user memslots to 508
In-Reply-To: <CAGOz-0bKYbVB_Zu1J+fCnQ=icK9yNHjXjh_hBxj4AjATw7cEXg@mail.gmail.com>
References: <1486538141-30627-1-git-send-email-linucherian@gmail.com>
 <1486538141-30627-3-git-send-email-linucherian@gmail.com>
 <20170223101407.GB1409@cbox>
 <CAGOz-0bKYbVB_Zu1J+fCnQ=icK9yNHjXjh_hBxj4AjATw7cEXg@mail.gmail.com>
Message-ID: <20170302122906.GJ1409@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 26, 2017 at 12:36:58PM +0530, Linu Cherian wrote:
> On Thu, Feb 23, 2017 at 3:44 PM, Christoffer Dall <cdall@linaro.org> wrote:
> > On Wed, Feb 08, 2017 at 12:45:41PM +0530, linucherian at gmail.com wrote:
> >> From: Linu Cherian <linu.cherian@cavium.com>
> >>
> >> Having only 32 memslots is a real constraint for the maximum
> >> number of PCI devices that can be assigned to a single guest.
> >> Assuming each PCI device/virtual function having two memory BAR
> >> regions, we could assign only 15 devices/virtual functions to a
> >> guest.
> >>
> >> Hence increase KVM_USER_MEM_SLOTS to 508, so that KVM_MEM_SLOTS_NUM is
> >> 512 as done in other archs like x86 and powerpc.
> >
> > Actually on powerpc they just define KVM_USER_MEM_SLOTS as 512 directly.
> >
> > On x86 they define them as 509 and have 3 private mem slots.
> >
> > I don't understand the difference and as far as I can tell we don't have
> > any private memslots on arm/arm64, so this is just weird to me.
> >
> 
> Since the KVM_PRIVATE_MEM_SLOTS was already defined as 4, just kept
> it untouched. Should we remove this and keep KVM_USER_MEM_SLOTS as 512 ?

Do we have any use for KVM_PRIVATE_MEM_SLOTSA being 4?  I can't seem to
see this.

I think we should either get rid of the definition or at least make sure
we understand why we're doing things this way.

Thanks,
-Christoffer
