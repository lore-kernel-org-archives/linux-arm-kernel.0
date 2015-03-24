From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 24 Mar 2015 08:46:31 +0000
Subject: [RFC 2/4] arm64: kexec: fix kvm issue
In-Reply-To: <1427126213.27739.3.camel@infradead.org>
References: <1427111639-4575-1-git-send-email-takahiro.akashi@linaro.org>	
 <1427111639-4575-3-git-send-email-takahiro.akashi@linaro.org>
 <1427126213.27739.3.camel@infradead.org>
Message-ID: <55112467.207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/03/15 15:56, Geoff Levand wrote:
> On Mon, 2015-03-23 at 20:53 +0900, AKASHI Takahiro wrote:
>> The current kvm implementation keeps EL2 vector table installed even
>> when the system is shut down. This prevents kexec from putting the system
>> with kvm back into EL2 when starting a new kernel.
> 
> This is a kvm bug fix, so I think the subject should
> be something like 'arm64/kvm: Fix shutdown issue'.

Not quite. On its own, this doesn't fix anything in KVM. It simply plugs
a deficiency in the arm64 kexec implementation. If you want to be
completely true to the content of the patch, it should read:

"arm64: KVM: Allow EL2 context to be reset on shutdown"

Can we now drop the blame game and get back to the actual code?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
