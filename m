From: adrian.wenl@gmail.com (Lei Wen)
Date: Tue, 8 Nov 2011 04:55:43 +0800
Subject: 2b034922 breaks kexec on ARM
In-Reply-To: <20111107192043.GT12913@n2100.arm.linux.org.uk>
References: <20111107185125.GA17464@mudshark.cambridge.arm.com>
 <20111107190314.GS12913@n2100.arm.linux.org.uk>
 <20111107191453.GC17464@mudshark.cambridge.arm.com>
 <20111107192043.GT12913@n2100.arm.linux.org.uk>
Message-ID: <CALZhoSRZu=fbsToqWQsxJBSQ6huwxtkR=M7iFZyJ576jeJ4FHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 8, 2011 at 3:20 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Nov 07, 2011 at 07:14:53PM +0000, Will Deacon wrote:
>> On Mon, Nov 07, 2011 at 07:03:15PM +0000, Russell King - ARM Linux wrote:
>> > Hmm, having looked at kernel/kexec.c, this patch is clearly wrong.
>> > There are two kernels which can be loaded into kexec - a crash kernel
>> > and a default kernel. ?These are kept entirely separately (and the
>> > per-kernel context is stored in 'image').
>> >
>> > However, this patch makes machine_kexec_prepare() store into some
>> > _global_ variables, which means if you've loaded a crash kernel
>> > followed by a default kernel, the values for the crash kernel will
>> > be corrupted.
>> >
>> > So yes, I think a revert of this patch is the right thing.
>>
>> Great. Would you like me to submit the revert to the patch system or are you
>> happy just to do it using git?
>
> I've reverted it myself (see the tip of the fixes branch). ?It's slightly
> annoying that the branch was only pulled last night.
>
>> > I think the only valid thing its doing is moving the copy of the
>> > reboot code earlier, but I don't see the value of moving just that.
>>
>> Neither can I. It seems to be happy enough with the patch reverted, so if it
>> ain't broke...
>
> I guess this is where the problems of poor commit descriptions crop up.
> We don't know _why_ the original author of the patch wanted to make the
> change - we don't know if they were seeing a problem.
>

Apologize for messing things up...
But we have make in-depth testing over that patch already in our local
code base...
Does this problem happens for the kernel is running on a SMP soc? Our current
testing haven't extend to SMP one, but only have test on non-smp.

Best regards,
Lei
