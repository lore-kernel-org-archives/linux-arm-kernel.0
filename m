From: jcm@redhat.com (Jon Masters)
Date: Tue, 15 Dec 2015 10:24:13 -0500
Subject: memcpy alignment
In-Reply-To: <20151215093406.GC19244@e104818-lin.cambridge.arm.com>
References: <566F92D6.8060103@redhat.com>
 <20151215093406.GC19244@e104818-lin.cambridge.arm.com>
Message-ID: <5670309D.1040309@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/2015 04:34 AM, Catalin Marinas wrote:
> On Mon, Dec 14, 2015 at 11:11:02PM -0500, Jon Masters wrote:
>> What's supposed to happen if the natural alignment of the pointers dst
>> and src is not the same? We don't seem to handle that case today, and
>> instead will base our access data type on the source alignment only.
> 
> The hardware takes care of the other one. The memcpy behaviour in the
> kernel is the same as the glibc one (the Cortex Strings library).

Not if you're dealing with Device memory. I accept that one could always
ensure that there's a non-Device mapping (I got the other replies) but I
don't think it's unreasonable to expect a memcpy to work in the presence
of misaligned addresses either.

Jon.
