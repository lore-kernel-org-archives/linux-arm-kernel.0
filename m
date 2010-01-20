From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Wed, 20 Jan 2010 10:57:08 +0100
Subject: [PATCH/RFC v1 0/2] Human readable performance event	description in
	sysfs
In-Reply-To: <1263978999.4283.823.camel@laptop>
References: <1263978706-15499-1-git-send-email-t.fujak@samsung.com>
	<1263978999.4283.823.camel@laptop>
Message-ID: <op.u6tslipz7p4s8u@pikus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> The following patches provide a sysfs entry with hardware event human
>> readable description in the form of "0x%llx\t%lld-%lld\t%s\t%s" %
>> (event_value, minval, maxval, name, description) and means to populate
>> the file.
>>
>> The intended use is twofold: for users to read the list directly and
>> for tools (like perf).

On Wed, 20 Jan 2010 10:16:39 +0100, Peter Zijlstra <peterz@infradead.org> wrote:
> Why do this in kernel space? Listing available events seems like
> something we can do from userspace just fine.

IMO kernel knows better what hardware it's running on and user space
should not care and if this list were to be kept in user space it
would have to detect the processor it's running on and act accordingly.

Also, keeping the list in user space could lead to different software
maintaining separate lists which would get out of sync.  I think it's
easier to update a single list in kernel then wait till all the
software packages update theirs.

This also means that different tools would use different names and
descriptions for the events which would only increase confusion.

Moreover, since kernel already does the hard work of detecting CPU
it may provide a list as well.

But I'm just a humble coder, what do I know... ;)

-- 
Best regards,                                           _     _
  .o. | Liege of Serenely Enlightened Majesty of       o' \,=./ `o
  ..o | Computer Science,  Micha? "mina86" Nazarewicz     (o o)
  ooo +---[mina86 at mina86.com]---[mina86 at jabber.org]---ooO--(_)--Ooo--
