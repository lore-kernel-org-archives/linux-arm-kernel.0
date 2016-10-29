From: agraf@suse.de (Alexander Graf)
Date: Sat, 29 Oct 2016 20:55:11 +0200
Subject: [PATCH 0/3] Support userspace irqchip with arch timers
In-Reply-To: <1154342410.9324183.1477747141878.JavaMail.zimbra@redhat.com>
References: <20160927190806.22988-1-christoffer.dall@linaro.org>
 <3e85d538-2539-f190-0d17-a2ecfe7b48ce@suse.de> <20160930154335.GB7996@cbox>
 <71b0ae9d-baea-1f65-3c01-5d87f4f4746f@suse.de>
 <3928feee-cb23-8635-20bd-4c068b649a1d@arm.com>
 <7500DEDE-EC21-4287-9B11-04C058A48747@suse.de>
 <56812724-4bac-8265-b6f6-b1ff00308ec0@arm.com>
 <554F7514-1900-41B4-8DDC-36C00B903164@suse.de>
 <1154342410.9324183.1477747141878.JavaMail.zimbra@redhat.com>
Message-ID: <5D593F44-F76B-4E2C-B2F8-CA08DFE2D87F@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 29 Oct 2016, at 15:19, Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
>>>>> What the status of userspace for this thing? Are QEMU patches being
>>>>> posted and reviewed?
>>>> 
>>>> I didn't see a notification that the patches were merged. Are they in
>>>> Linus' tree yet? Then I can post enablement to qemu-devel.
>>> 
>>> I think you got it backward. I have no intention of merging them until I
>>> see a vague consensus on the userspace API, and a set of patches ready
>>> to be merged in QEMU.
>> 
>> That's not how kvm apis are made.
> 
> Actually I think it's always been like this, depending on what Marc meant for
> "ready to be merged in QEMU".  It doesn't make sense to merge KVM APIs without
> having userspace patches at least posted as RFC to qemu-devel, and without
> having at least a positive response from the QEMU architecture maintainer.

I halfway agree. I do agree that there needs to be a reference implementation that proves the API to make sense. That bit is referenced in the cover letter of the patch set.

Peter as the QEMU architecture maintainer has been part of the review process and involved from the beginning. In fact, the current approach was his idea.

Do we need to fly the loop over qemu-devel? I doubt it, but if it makes you happy I can post an RFC there too.

> ARM does require a bit more care because there's no overlap between kernel
> and userspace maintainers, so perhaps that's the source of the confusion?
> 
> Now, of course merging the patches in QEMU may take a month or two depending
> on the timing (because you have to wait for the patches to be merged into
> Linus's tree and for the KVM headers to be updated in QEMU---which is not
> going to happen during freeze of course).  So of course the KVM patch thus
> can be committed even if QEMU is in freeze, as long as the QEMU architecture
> maintainer gives an overall green light.

Right. My plan was to make sure that people agree on the KVM interface. Then directly send non-RFC patches to qemu-devel, which can only happen when the KVM patches are merged. I didn?t see any reason why that approach would be controversial, since everyone who really cared was involved.

But again, I don?t care strongly enough to make a fuss. If people are happier with RFC patches on the ML rather than a github link to RFC patches, I?ll send them.


Alex
