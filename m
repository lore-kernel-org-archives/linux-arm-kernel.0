From: rusty@rustcorp.com.au (Rusty Russell)
Date: Thu, 17 Jan 2013 12:41:52 +1030
Subject: [PATCH v5 03/14] KVM: ARM: Initial skeleton to compile KVM support
In-Reply-To: <20130116094444.GP23505@n2100.arm.linux.org.uk>
References: <20130108183811.46302.58543.stgit@ubuntu>
 <20130108183855.46302.40539.stgit@ubuntu>
 <20130114162415.GF23505@n2100.arm.linux.org.uk>
 <CANM98qLHao0dJU57MbAtopVpTJDOVdqNtw5JT-DXyQNa7iD_qw@mail.gmail.com>
 <877gndzvi6.fsf@rustcorp.com.au>
 <20130116094444.GP23505@n2100.arm.linux.org.uk>
Message-ID: <87hamgy2vr.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> On Wed, Jan 16, 2013 at 01:26:01PM +1030, Rusty Russell wrote:
>> Christoffer Dall <c.dall@virtualopensystems.com> writes:
>> 
>> > On Mon, Jan 14, 2013 at 11:24 AM, Russell King - ARM Linux
>> > <linux@arm.linux.org.uk> wrote:
>> >> On Tue, Jan 08, 2013 at 01:38:55PM -0500, Christoffer Dall wrote:
>> >>> +     /* -ENOENT for unknown features, -EINVAL for invalid combinations. */
>> >>> +     for (i = 0; i < sizeof(init->features)*8; i++) {
>> >>> +             if (init->features[i / 32] & (1 << (i % 32))) {
>> >>
>> >> Isn't this an open-coded version of test_bit() ?
>> >
>> > indeed, nicely spotted:
>> 
>> BTW, I wrote it that was out of excessive paranoia: it's a userspace
>> API, and test_bit() won't be right on 64 bit BE systems.
>
> So why is this a concern for 32-bit systems (which are, by definition,
> only in arch/arm) ?

Because this feature bitmap system is the same code which other archs
*should* be using for specifying kvm cpus :)

Cheers,
Rusty.
