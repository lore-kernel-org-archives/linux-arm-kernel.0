From: pbonzini@redhat.com (Paolo Bonzini)
Date: Fri, 10 May 2013 10:11:39 +0200
Subject: [RFC PATCH 1/2] ARM: KVM: move GIC/timer code to a common location
In-Reply-To: <f816c184d2512dad242b383deac7453e@localhost>
References: <1367589773-5609-1-git-send-email-marc.zyngier@arm.com>
 <1367589773-5609-2-git-send-email-marc.zyngier@arm.com>
 <20130509181101.GA17253@gmail.com>
 <f816c184d2512dad242b383deac7453e@localhost>
Message-ID: <518CABBB.7050909@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 10/05/2013 09:23, Marc Zyngier ha scritto:
>> > 1. Should we have a namespace per arch in the include directory, as in
>> >    include/kvm/arm?
> So I thought of that at one point, but discarded the idea because it seems
> to convey the wrong message:
> We're moving the include files because they are architecture independent,
> and referring to an architecture name in the path feels a bit odd. Or maybe
> arm-common?

As I wrote in the other message, Linux in general has a shallow include/
tree, so I think putting them in include/kvm/ is good.

Is there any precedent for naming stuff that is common to arm and
aarch64?  I think to 99% of the world they will both be "arm", but of
course the remaining 1% is likely over-represented among KVM-ARM
maintainers. :)

Paolo
