From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 6 Sep 2016 18:59:15 +0200
Subject: [PATCH v2] kvm: arm: Enforce some NS-SVC initialisation
In-Reply-To: <8e0b62de-63dd-4635-14b3-a70726bc1798@arm.com>
References: <5322cdb9cb397741d15b60c6693ad39dbf74b6d5.1469101945.git.robin.murphy@arm.com>
 <6d030bee2db08c2fe1b7569e692e8f66800b1e4c.1471369569.git.robin.murphy@arm.com>
 <20160817113249.GA5909@cbox> <20160906164145.GD23592@cbox>
 <8e0b62de-63dd-4635-14b3-a70726bc1798@arm.com>
Message-ID: <CAMJs5B_jHSZ7KA1h_aCWfscQ3axpVi1MM58QwrugT0mjp3hx=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 6, 2016 at 6:44 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> Hi Christoffer,
>
> On 06/09/16 17:41, Christoffer Dall wrote:
>> On Wed, Aug 17, 2016 at 01:32:49PM +0200, Christoffer Dall wrote:
>>> Hi Russell,
>>>
>>> On Tue, Aug 16, 2016 at 06:49:18PM +0100, Robin Murphy wrote:
>>>> Since the non-secure copies of banked registers lack architecturally
>>>> defined reset values, there is no actual guarantee when entering in Hyp
>>>> from secure-only firmware that the Non-Secure PL1 state will look the
>>>> way that kernel entry (in particular the decompressor stub) expects.
>>>> So far, we've been getting away with it thanks to implementation details
>>>> of ARMv7 cores and/or bootloader behaviour, but for the sake of forwards
>>>> compatibility let's try to ensure that we have a minimally sane state
>>>> before dropping down into it.
>>>>
>>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>>
>>> Can we have your acked-by on this patch to merge it via the KVM tree or
>>> do you prefer merging this one directly yourself?
>>>
>> I have queued this via the KVM/ARM tree.  If you have any objections,
>> please let me know asap.
>
> Ah, I should have replied on this thread - I put this one into Russell's
> patch system the other week, and it's in -next already.
>
> Sorry for the lack of communication,

No worries, I removed it from the queue again.

-Christoffer
