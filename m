From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Sat, 13 Sep 2014 13:03:23 +0100
Subject: [PATCH 3.17-rc4 v5 2/6] arm: fiq: Replace default FIQ handler
In-Reply-To: <20140912171404.GO12361@n2100.arm.linux.org.uk>
References: <1410272111-30516-1-git-send-email-daniel.thompson@linaro.org>
 <1410435078-28462-1-git-send-email-daniel.thompson@linaro.org>
 <1410435078-28462-3-git-send-email-daniel.thompson@linaro.org>
 <20140912171404.GO12361@n2100.arm.linux.org.uk>
Message-ID: <5414328B.6010307@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/14 18:14, Russell King - ARM Linux wrote:
> On Thu, Sep 11, 2014 at 12:31:14PM +0100, Daniel Thompson wrote:
>> This patch introduces a new default FIQ handler that is structured in a
>> similar way to the existing ARM exception handler and result in the FIQ
>> being handled by C code running on the SVC stack (despite this code run
>> in the FIQ handler is subject to severe limitations with respect to
>> locking making normal interaction with the kernel impossible).
>>
>> This default handler allows concepts that on x86 would be handled using
>> NMIs to be realized on ARM.
> 
> Okay, lastly... I sent you my version of this change, which contained
> the changes I've detailed in the previous three emails, which are absent
> from your version.
> 
> However, you've taken on board the "trace" thing to svc_entry, and
> renamed it to "call_trace".
> 
> Now if I add this to usr_entry, "call_trace" doesn't make any sense,
> nor does the .if/.endif placement because it's not just trace_hardirqs_off
> which needs to be disabled there, but also ct_user_exit as well.
> 
> I'm beginning to wonder why I tried to be nice here... it would've been
> a lot faster for me to take your patch, make my own changes and commit
> that instead.

I did not do a side by side diff of your FYI patch with my current code
and hence overlooked all these changes.

Sorry. I should have done that.
