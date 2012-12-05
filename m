From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 5 Dec 2012 15:15:57 +0000
Subject: [RFC PATCH 0/2] Add support for a fake, para-virtualised machine
In-Reply-To: <20121205150732.GJ22385@mudshark.cambridge.arm.com>
References: <1354557160-20144-1-git-send-email-will.deacon@arm.com>
 <50BD1F81.9080304@gmail.com>
 <20121204123001.GL23368@mudshark.cambridge.arm.com>
 <50BE04C6.4070602@gmail.com>
 <alpine.LFD.2.02.1212041142490.6589@xanadu.home>
 <20121204171129.GE5314@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1212041252290.6589@xanadu.home>
 <20121204181446.GJ5314@mudshark.cambridge.arm.com>
 <CAHkRjk5HgM=kL5Li_9qrwXfD+vJGvLLoha_ns6KFdxZW7gLwbA@mail.gmail.com>
 <20121205150732.GJ22385@mudshark.cambridge.arm.com>
Message-ID: <20121205151557.GE27057@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 05, 2012 at 03:07:32PM +0000, Will Deacon wrote:
> On Wed, Dec 05, 2012 at 02:52:57PM +0000, Catalin Marinas wrote:
> > Just for clarification, AArch32 with virtualisation mandates the
> > security extensions, so the SMC can be trapped. On AArch64 it is a bit
> > tricky since the presence of EL3 is not mandate, in which case SMC
> > would undef (don't as why ;). That's where we can have different
> > enable methods specified via the DT.
>
> Not entirely true: only ARMv7 mandates the security extensions in this
> manner. You can still have ARMv8 CPUs running AArch32 code without the
> security extensions.

Yes, I pretty much had the 32-bit and 64-bit ARM ports in mind. An
AArch32 guest OS running on an AArch64 KVM would indeed have this issue.

But HVC PSCI would still work for the mach-virt in all cases.

--
Catalin

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
