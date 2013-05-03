From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 14:02:59 +0200
Subject: [PATCH 1/5 v2] dmaengine: ste_dma40: Allow memcpy channels to be
 configured from DT
In-Reply-To: <20130503115739.GJ24153@gmail.com>
References: <1367336497-10650-1-git-send-email-lee.jones@linaro.org>
 <20130501095243.GD25256@gmail.com>
 <CACRpkdZtOtnUYvLm7BPA98oMOLAMPHpJ9GLoyMXOKW1nsTDYiQ@mail.gmail.com>
 <20130503115739.GJ24153@gmail.com>
Message-ID: <CACRpkdb-_pf=9cm_Hy25nzFWKSTKc6OmmG9rhN2T1wR1=2tddg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 1:57 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Fri, 03 May 2013, Linus Walleij wrote:
>
>> On Wed, May 1, 2013 at 11:52 AM, Lee Jones <lee.jones@linaro.org> wrote:
>>
>> > At this moment in time the memcpy channels which can be used by the D40
>> > are fixed, as each supported platform in Mainline uses the same ones.
>> > However, platforms do exist which don't follow this convention, so
>> > these will need to be tailored. Fortunately, these platforms will be DT
>> > only, so this change has very little impact on platform data.
>> >
>> > Cc: Vinod Koul <vinod.koul@intel.com>
>> > Cc: Dan Williams <djbw@fb.com>
>> > Cc: Per Forlin <per.forlin@stericsson.com>
>> > Cc: Rabin Vincent <rabin@rab.in>
>> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>
>> Real nice!
>>
>> But can you split this in two patches: one that changes
>> drivers/dma/ste_dma40* and one sequel patch that changes
>> Documentation/* and arch/arm/boot/dts/* so I can merge them
>> out-of-order?
>>
>> I am trying this development cycle to split changes to the
>> device trees and bindings off from the rest of the patches
>> becaused it caused me a mess last cycle.
>
> I was under the impression that the documentation went with the
> bindings, rather than the Device Tree. Am I wrong?

No you're right. The documentation with the bindings and the
patch to the driver...

Then just arch/arm/boot/dts/* separately.

The latter is where I have all my trouble and screwup...

(However when we break the devicetree data out of the kernel
and into its own git we will have to follow the pattern above with
a patch of bindings+DT changes and another one in parallell
changing the kernel, but that is for a more advanced age.)

Yours,
Linus Walleij
