From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 1 May 2014 13:46:33 +0100
Subject: [PATCH V3 0/2] PTE fixes for ARM LPAE
In-Reply-To: <1396016554-5843-1-git-send-email-steve.capper@linaro.org>
References: <1396016554-5843-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20140501124632.GA5606@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 02:22:32PM +0000, Steve Capper wrote:
> This series fixes a couple of problems that I have come across on ARM
> with LPAE.
>  1) Some pte accessors can have their results cancelled out by a
>     downcast. This is addressed by the first patch.
> 
>  2) It is impossible to distinguish between clean writable ptes and
>     read only ptes. This is addressed by the second patch.
> 
> The big change in V3 is going back to the pte_isset macros, also an
> additional macro, pte_isclear, is introduced. For cases where the bits
> to be tested are in the lower 32-bits of the pte, the double logical
> invert is dropped.

Hello,
Just a ping on this series.

If no-one has any objections, I was going to put this into the patch
system?

Thanks,
-- 
Steve
