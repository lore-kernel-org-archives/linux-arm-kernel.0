From: olof@lixom.net (Olof Johansson)
Date: Wed, 26 Aug 2015 13:04:35 -0700
Subject: [PATCH 2/5] ARM: NSP: add minimal Northstar Plus device tree
In-Reply-To: <20150826184009.GA4171@broadcom.com>
References: <1440092804-25726-1-git-send-email-jonmason@broadcom.com>
 <CAOesGMhE40_mfZCD2PqcTObE_Gz_6rKFwhf3-6kZY4n9Yxn2rQ@mail.gmail.com>
 <20150826184009.GA4171@broadcom.com>
Message-ID: <CAOesGMif9Bxx=K5GQqkiJKg2SD7QvgU8=2PQa65mEbJHnhNQ8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 11:40 AM, Jon Mason <jonmason@broadcom.com> wrote:
> On Tue, Aug 25, 2015 at 04:36:45PM -0700, Olof Johansson wrote:
>> Hi,
>>
>> I'm not sure what the strategy behind your cc:ing on this patch set
>> is. I only got a couple of them in my inbox, and this one wasn't one
>> of them. :)
>
> I sent them to the people listed as maintainers in get_maintainer.pl.
> It didn't seem to include you in all of them, but I thought the
> mailing list would be enough of a catch all.  My apologies.  I'll CC
> everyone listed as a maintainer on all of the patches in the future.

No worries. Just pointing it out since you asked me to look at the
patches and, well, I hadn't received them all. :)

>> On Thu, Aug 20, 2015 at 10:46 AM, Jon Mason <jonmason@broadcom.com> wrote:
>> > Add a very minimalistic set of Northstar Plus Device Tree files which
>> > describes the SoC and the BCM958625 implementation.  The perpherials
>> > described are:
>> >
>> > ARM Cortex A9 CPU
>> > 2 8250 UARTs
>> > ARM GIC
>> > PL310 L2 Cache
>> > ARM A9 Global timer
>> >
>> > Signed-off-by: Jon Mason <jonmason@broadcom.com>
>> > Signed-off-by: Kapil Hali <kapilh@broadcom.com>
>> > Reviewed-by: Ray Jui <rjui@broadcom.com>
>> > Reviewed-by: Scott Branden <sbranden@broadcom.com>
>>
>> Seeing reviewed-by already attached to a v1 of a patchset has limited
>> value for someone on the outside.
>>
>> Reviewed-by is one of those tags that has a value that's mostly
>> dependent on who it comes from. By not actually seeing the review and
>> the feedback provided (and revisions made), less data is provided to
>> tell if it's a valuable review or not.
>>
>> Also, if you're posting the code you should probably have your name
>> below Kapil's, since you're the one signing off the origin of the
>> code. See Documentation/SubmittingPatches.txt for details on what
>> S-o-b actually means.
>
> We worked on it together, but I'll be happy to reorder as you suggest.
>
>>
>>
>> > --- /dev/null
>> > +++ b/arch/arm/boot/dts/bcm-nsp.dtsi
>> > @@ -0,0 +1,105 @@
>> > +/*
>> > + *  BSD LICENSE
>> > + *
>> > + *  Copyright(c) 2015 Broadcom Corporation.  All rights reserved.
>> > + *
>> > + *  Redistribution and use in source and binary forms, with or without
>> > + *  modification, are permitted provided that the following conditions
>> > + *  are met:
>> > + *
>> > + *    * Redistributions of source code must retain the above copyright
>> > + *      notice, this list of conditions and the following disclaimer.
>> > + *    * Redistributions in binary form must reproduce the above copyright
>> > + *      notice, this list of conditions and the following disclaimer in
>> > + *      the documentation and/or other materials provided with the
>> > + *      distribution.
>> > + *    * Neither the name of Broadcom Corporation nor the names of its
>> > + *      contributors may be used to endorse or promote products derived
>> > + *      from this software without specific prior written permission.
>> > + *
>> > + *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
>> > + *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>> > + *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
>> > + *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
>> > + *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
>> > + *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
>> > + *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
>> > + *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
>> > + *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
>> > + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
>> > + *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>> > + */
>>
>> I'm not sure we've seen BSD-only submissions before. I'll let DT
>> maintainers (or Ian) speak up in case this would cause problems.
>
> I was following the precedent in arch/arm/boot/dts/bcm-cygnus.dtsi.
> If this is preferred to be GPL v2, then I will happily comply.

No, we'd rather have BSD-only than GPL-only, so keeping it as it is
should be OK.

>> > +       chosen {
>> > +               stdout-path = "serial0:115200n8";
>> > +       };
>>
>> No way to mount a root filesystem yet? How much work remains for that
>> to be possible, and what's the plan for that?
>
> It mounts rootfs.  I am adding the rootfs to the kernel and device
> tree blob via the u-boot mkimage command.  It boots all the way to
> shell without issue.

Sure, any system with memory can use ramdisk for root, that's not what I meant.

Still, based on post from Scott it sounds like NAND support isn't far away.


-Olof
