From: pbonzini@redhat.com (Paolo Bonzini)
Date: Tue, 04 Jun 2013 17:30:52 +0200
Subject: Planning the merge of KVM/arm64
In-Reply-To: <51AE00D7.9030607@arm.com>
References: <51ADDDAE.4040705@arm.com>
 <CAMJs5B_PB1pNVCO_EK7aTghN23L+d0RovAFi7inrVsJb5STWOA@mail.gmail.com>
 <51AE00D7.9030607@arm.com>
Message-ID: <51AE082C.6050907@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 04/06/2013 16:59, Marc Zyngier ha scritto:
>>> >> - Either I can rely on a stable branch from both KVM and KVM/ARM trees
>>> >> on which I can base my tree for Catalin/Will to pull,
>>> >> - Or I ask Catalin to only pull the arm64 part *minus the Kconfig*, and
>>> >> only merge this last bit when the dependencies are satisfied in Linus' tree.
>>> >>
>>> >> What do you guys think?
>>> >>
>> > I would think you would prefer option (1) to get the code in cleaner.
>> > Both the KVM/next tree is stable and I can provide you with a stable
>> > KVM/ARM tree. But I really don't feel strongly about this.
> That'd be my preferred choice too. Let's see what the KVM maintainers'
> position on that.

I wonder if Linus would complain about irrelevant KVM changes in
Will/Catalin's pull request.  The KVM/next tree has other patches below
the ones you need.

What we usually do for x86 is get an Acked-by from the other part.  If
there are no dependencies on other aarch64 core changes, it'd be better
to go through the KVM tree.  Otherwise separating the Kconfig change
should be okay (perhaps add it with depends on BROKEN, and remove the
dependency later?).

Paolo
