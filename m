From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 4 Feb 2011 12:01:21 +0000
Subject: [PATCH 2/2] ARM: Make CONFIG_FPE_NWFPE depend on
	!CONFIG_THUMB2_KERNEL
In-Reply-To: <20110204110342.GE15004@n2100.arm.linux.org.uk>
References: <1291895982-4775-1-git-send-email-dave.martin@linaro.org>
	<1291895982-4775-3-git-send-email-dave.martin@linaro.org>
	<20110204110342.GE15004@n2100.arm.linux.org.uk>
Message-ID: <AANLkTik5A0nKtOvV=Ga4mtUasJ0vhHem+nx00Rpo3JV2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 4, 2011 at 11:03 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Dec 09, 2010 at 11:59:42AM +0000, Dave Martin wrote:
>> Because the nwfpe support is unlikely to be used on new platforms
>> and requires CONFIG_OABI_COMPAT, which is not generally used with
>> ARMv7+, we shouldn't expect to build nwfpe support into a Thumb-2
>> kernel.
>>
>> At present, nwfpe contains assembly code which isn't Thumb-2
>> compatible, and for now it doesn't appear useful to port this
>> code.
>
> You might as well make OABI_COMPAT depend on !THUMB2_KERNEL. ?OABI
> userland is useless without FPA support.
>

Sure.  The original patch is already upstream, but I can roll a
supplementary patch for this.

Cheers
---Dave
