From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 17 May 2018 00:39:37 -0500
Subject: [PATCH 2/4] pid: Export find_task_by_vpid for use in external
 modules
In-Reply-To: <20180510194422.GX16141@n2100.armlinux.org.uk> (Russell King's
 message of "Thu, 10 May 2018 20:44:22 +0100")
References: <20180508140640.0e312dba025df75cbf205cdb@arm.com>
 <87d0y5toed.fsf@xmission.com> <20180509152505.GA25559@xps15>
 <87k1scs0f8.fsf@xmission.com>
 <20180510084057.GT16141@n2100.armlinux.org.uk>
 <CANLsYkwaNmZCUjwJXK0X1ia+RnzumfbpB8EvZJ-HDtOHj8rafQ@mail.gmail.com>
 <20180510194422.GX16141@n2100.armlinux.org.uk>
Message-ID: <87k1s2j0x2.fsf@xmission.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@armlinux.org.uk> writes:

> On Thu, May 10, 2018 at 01:39:18PM -0600, Mathieu Poirier wrote:
>> Hi Russell,
>> 
>> On 10 May 2018 at 02:40, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
>> > This does not leak information from other namespaces because of the
>> > uniqueness of the global PID.  However, what it does leak is the value
>> > of the global PID which is meaningless in the namespace.  So, before
>> > the event stream is delivered to userspace, this value needs to be
>> > re-written to the namespace's PID value.
>> 
>> Unfortunately that can't be done.  The trace stream is compressed and
>> needs to be decompressed using an external library.  I think the only
>> option is to return an error if a user is trying to use this feature
>> from a namespace.
>
> That sounds like a sensible approach, and that should get rid of the
> vpid stuff too.
>
> Eric, would this solve all your concerns?

It does, and I have given my ack to the respin.

I am moderately concerned about using the global pid with hardware.  But
pids are a core abstraction that aren't going anywhere.  As long as
hardware does not impose constraints on pids that software already does
not we should be fine.

Eric
