From: davem@davemloft.net (David Miller)
Date: Tue, 15 Apr 2014 14:27:31 -0400 (EDT)
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140415180700.GB11690@redhat.com>
References: <20140415174900.GA11184@redhat.com>
 <20140415.135038.1703628429468655272.davem@davemloft.net>
 <20140415180700.GB11690@redhat.com>
Message-ID: <20140415.142731.2298870571726062338.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oleg Nesterov <oleg@redhat.com>
Date: Tue, 15 Apr 2014 20:07:00 +0200

> On 04/15, David Miller wrote:
>>
>> From: Oleg Nesterov <oleg@redhat.com>
>> Date: Tue, 15 Apr 2014 19:49:00 +0200
>>
>> > We do not want to write to, say, page cache if the probed application
>> > mmaps a file at the same vaddr.
>>
>> If user has write access to that page... not our problem.
> 
> Well, I am not sure.
> 
> Yes, this won't allow you to write the exploit. But if this actually
> happens because an application is buggy, this can lead to really
> hard-to-debug problems.

And this is different from a stray userland scribble onto such a page
how?

This is all so much simpler if you don't insist on doing all of this
hand-holding for the user, that's not the kernel's job.
