From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue, 14 Jan 2014 09:17:41 +0100
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20140113174420.GC6934@e102568-lin.cambridge.arm.com>
References: <1389554441-27335-1-git-send-email-broonie@kernel.org>
 <1389554441-27335-2-git-send-email-broonie@kernel.org>
 <20140113161059.GA32720@e102568-lin.cambridge.arm.com>
 <20140113163045.GB29039@sirena.org.uk>
 <20140113174420.GC6934@e102568-lin.cambridge.arm.com>
Message-ID: <CAKfTPtDHjytSWYBiqxECJ4TqDN6RL1uT+Vx5tCjzjdBL6N9+5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 January 2014 18:44, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> On Mon, Jan 13, 2014 at 04:30:45PM +0000, Mark Brown wrote:
>> On Mon, Jan 13, 2014 at 04:10:59PM +0000, Lorenzo Pieralisi wrote:
>> > On Sun, Jan 12, 2014 at 07:20:38PM +0000, Mark Brown wrote:
>>
>> > > +struct cpu_topology {
>> > > + int thread_id;
>> > > + int core_id;
>> > > + int socket_id;
>>
>> > Is there any reason why we can't rename socket_id to cluster_id ? It won't
>> > change our lives but at least we kind of know what it means in ARM world.
>>
>> I really don't care, whatever you guys want.
>
> s/socket_id/cluster_id
>
> unless we have a compelling reason to keep the socket_id naming, I do
> not see it, given that cpu_topology is arch specific anyway.
>
> socket_id means really nothing in ARM world.
>
> Again, Vincent if you see a compelling reason to keep socket_id as in arm32
> that I am missing please shout.

I don't have any compellingreason, i have just used the same name than
other platform.

Vincent

>
>>
>> > > +#define mc_capable()     (cpu_topology[0].socket_id != -1)
>> > > +#define smt_capable()    (cpu_topology[0].thread_id != -1)
>>
>> > Are the two macros above still required in the kernel ? I can't see any
>> > usage at present.
>> >
>> > Vincent, do you know why they were not removed in commit:
>> >
>> > 8e7fbcbc22c12414bcc9dfdd683637f58fb32759
>> >
>> > I am certainly missing something.
>>
>> They're defined by a bunch of other architectures (including x86).  If I
>> had to guess I'd say the architectures are still providing the
>> information so we don't need to go round adding it again if someone
>> comes up with a use for it in the core.
>
> Yes, let's keep the macros, just wanted to make sure I got it right.
>
> Lorenzo
>
