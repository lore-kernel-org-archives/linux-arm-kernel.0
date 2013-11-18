From: jonathan@jonmasters.org (Jon Masters)
Date: Mon, 18 Nov 2013 15:54:56 -0500
Subject: ACPI vs DT at runtime
In-Reply-To: <20131118190929.GA5886@quad.lixom.net>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <5289A356.4060004@jonmasters.org> <20131118190929.GA5886@quad.lixom.net>
Message-ID: <528A7EA0.9050101@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 11/18/2013 02:09 PM, Olof Johansson wrote:
> Jon,
> 
> On Mon, Nov 18, 2013 at 12:19:18AM -0500, Jon Masters wrote:
>> Olof, thanks for starting this thread. Mark, thanks for the followup.
> 
> Your mailer is dropping all ccs to your emails, so I didn't get a copy of this
> in my inbox. You might want to check the configuration at your end.

I need to shoot Thunderbird for all kinds of reasons unrelated to this.
I actually am having to alternate with another laptop right now to do
email because this Thunderbird build I am running is just so sluggish
and nasty (and the other laptop setup is what is broken). But anyway,
that's something I need to fix, thanks for fixing the CCs.

> I've added back the cc recipients.
> 
>> Comments on both inline, below. But before I reply to the specific
>> points, let me add that this is clearly an emotional topic for many.
> 
> I'm sorry that it's so emotional. Let's keep to technical arguments.

I agree with you. I got worried on Friday when I saw a discussion
effectively leading with (what I read as) "let's ban all ACPI", which
really got me concerned. But then again, I've been in bed most of the
weekend sick, so I probably miss-read your intention. I apologize.

>> There are a great many companies involved in ARMv8 on servers, and a
>> great many have yet to say anything in public. I am trying to strike a
>> balance constantly by being fair to those who have announced and those
>> who have yet to do so. But regardless, we have one chance here to make a
>> good server platform that can challenge the incumbent architectures. If
>> I weren't utterly convinced of that, and of the need for such standards
>> as UEFI and ACPI, then I wouldn't be so vocal about it. Given who is
>> involved in this space, regardless of a decision to adopt ACPI now or
>> later, it is coming. It can be done right now, or not.
> 
> And what I am saying here is that "not right now" is the right answer
> for the linux kernel. For technical reasons.

I believe we can skip a lot of other conversation if I can summarize
something from this thread. Is it the case that you believe there is
room for both codepaths to exist in the upstream kernel, and for ACPI to
mature over time as it becomes "more ready"?

If the above is the case, then I don't think we disagree at all! I don't
want to kill DeviceTree, I just know (or think I do) that ACPI is going
to be the dominant force on v8 server systems. It worries me if there's
no way to let ACPI code be merged upstream until it's completely figured
out. I hope I am reading the rest of the thread correctly and understand
instead that you're saying there can be a path for both, and perhaps
those of us who require ACPI can simply state that up front and work
with partners to ensure support for those ACPI platforms is available -
and binding fixes to the standard made - while those same server
platforms might also be supported by a DeviceTree at the same time for a
period of whatever transition is required. That seems totally
acceptable. I don't see any reason why the same binary kernel image
can't boot with either a DTB or an ACPI table and indeed that would be
my preference. Some of us can require it be ACPI by policy, but others
can build kernels that use DTB on v8 servers if that's what they need
while the whole thing shakes itself out.

>> In the Enterprise space myself and others *need* it
>> (along with UEFI) to have a scalable solution that doesn't result in an
>> onslaught of customer support calls, which a non-standards body backed
>> moving target of DTB will do. And besides all of the big boys are going
>> to be using ACPI whether it's liked much or not.
> 
> I'm glad you've found your home with the big boys. Meanwhile, us low-lifes
> working on the kernel have a job to do, which is to make sure the lower parts
> of the stack will be successful on these new environments long-term,
> which might have short-term difficult trade-offs. ACPI is not realistic
> today, for all the reasons explained above.

Gah. I didn't mean to come across as offensive. Just worried. I'm in an
uncomfortable position that there are limits on what I can share about
what people are doing. I don't like or enjoy this one bit. I am pushing
for various things to change. I know it sounds like I'm sitting in a big
room with a Dr. Evil style conference table going on, but that's not the
reality. I *really* truly want ARM servers to be successful in the
marketplace and I know it will only happen (longer term) with ACPI. But
I agree the ACPI story is very much a work in progress right now. I just
want to know that there can be an upstream dual/stack ACPI story while
this is figured out - waiting years for that is going to be very
unfortunate to the overall cause. I wouldn't sound so passionate about
this if I weren't totally convinced of this reality.

Jon.
