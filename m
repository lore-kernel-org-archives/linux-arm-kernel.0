From: elder@linaro.org (Alex Elder)
Date: Tue, 13 Nov 2018 10:33:29 -0600
Subject: [RFC PATCH 02/12] soc: qcom: ipa: DMA helpers
In-Reply-To: <CAK8P3a3Hur9Kn=QLrn7XDn-Kpgfta1xTxvuwcBze4n2v7fsULw@mail.gmail.com>
References: <20181107003250.5832-1-elder@linaro.org>
 <20181107003250.5832-3-elder@linaro.org>
 <CAK8P3a3Hur9Kn=QLrn7XDn-Kpgfta1xTxvuwcBze4n2v7fsULw@mail.gmail.com>
Message-ID: <7eaef6a8-9d12-31bb-43fb-e710ad171c0f@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/7/18 6:17 AM, Arnd Bergmann wrote:
> On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
>>
>> This patch includes code implementing the IPA DMA module, which
>> defines a structure to represent a DMA allocation for the IPA device.
>> It's used throughout the IPA code.
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
> 
> I looked through all the users of this and couldn't fine one that actually
> benefits from it. I'd say better drop this patch entirely and open-code
> the contents in the callers. That will help readability since the dma
> API is well understood by many people.

Originally this was done to make it more obvious that all DMA allocations
were done with the same device pointer.  Previously there were several
separate devices, and it wasn't very obvious that only one was used (and
required).  Now that we're past that it's not difficult to do as you suggest.

I have now done that, and in the process identified a few more ways to
improve/simplify the code.  The net result is that more lines of code
were removed than were present in "ipa_dma.[ch]".  I see that as a
win (aside from your point below).

> Generally speaking, try not to wrap Linux interfaces into driver specific
> helper functions.

Agreed.  Thanks a lot for your review.

					-Alex

> 
>       Arnd
> 
