From: dianders@google.com (Doug Anderson)
Date: Thu, 8 May 2014 10:57:10 -0700
Subject: [PATCH] ARM: mm: Add workaround for erratum 763126
In-Reply-To: <20140508173853.GG8981@arm.com>
References: <1399528508-2806-1-git-send-email-arjun.kv@samsung.com>
 <CAD=FV=XeYdgqk3-CpS2NNXFAnn+uGDC6844d-L6vfS=SYEuw-Q@mail.gmail.com>
 <20140508173853.GG8981@arm.com>
Message-ID: <CAD=FV=X0jQvmA07XZEKT-3FAOaE3p0qCLPUCJKR8Ux1=o46cVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

On Thu, May 8, 2014 at 10:38 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hi guys,
>
> On Thu, May 08, 2014 at 05:57:03PM +0100, Doug Anderson wrote:
>> On Wed, May 7, 2014 at 10:55 PM, Arjun.K.V <arjun.kv@samsung.com> wrote:
>> > From: "Arjun.K.V" <arjun.kv@samsung.com>
>> >
>> > Three processor exclusive access livelock.
>> > In a system with three or more coherent masters that all use
>> > the ldrex/strex synchronization primitives to access a semaphore
>> > in coherent cacheable memory, there is a possibility of a
>> > livelock condition where two masters continuously attempt
>> > and fail to get the lock while the third master
>> > continuously reads the lock.
>
> Tentative NAK. You're paraphrasing the bug to make it sound worse than it
> is -- whilst two of the cores need to be in a ldrex/strex loop, the third
> needs to be issuing snoops from a normal load (to get the line into a shared
> state). Please can you point me at the code in Linux which is triggering
> this issue?

Arjun can correct me if I'm wrong, but I don't think there is any
known way to trigger the issue.  We haven't landed this fix locally in
our tree because there has been no evidence showing that it increases
stability.  If you guys say that it's a correct fix then we'll still
land it, but if (as you say) it's impossible to trigger in Linux then
it's a good reason to skip it!  :)

-Doug
