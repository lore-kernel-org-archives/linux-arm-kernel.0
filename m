From: khilman@ti.com (Kevin Hilman)
Date: Tue, 31 May 2011 09:13:07 -0700
Subject: [PATCH] OMAP: don't trace functions called from sched_clock
In-Reply-To: <20110531115039.GZ11352@atomide.com> (Tony Lindgren's message of
	"Tue, 31 May 2011 04:50:40 -0700")
References: <1304846514-15641-1-git-send-email-rabin@rab.in>
	<87hb8fyj2p.fsf@ti.com> <8762ovvf5f.fsf@ti.com>
	<20110531115039.GZ11352@atomide.com>
Message-ID: <87oc2isvak.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@ti.com> [110527 17:28]:
>> Kevin Hilman <khilman@ti.com> writes:
>> 
>> > Rabin Vincent <rabin@rab.in> writes:
>> >
>> >> omap_readl() is used from the sched_clock() implementations and so must
>> >> be marked notrace to avoid recursion in ftrace.  Same thing with
>> >> mpu_read() for OMAP1.
>> >>
>> >> Signed-off-by: Rabin Vincent <rabin@rab.in>
>> >
>> > Acked-by: Kevin Hilman <khilman@ti.com>
>> 
>> I also meant to suggest this should probably queue for .40-rc series.
>
> Took a quick look and we should get rid of the omap_readl usage instead
> like I commented in another mail.

Agreed, that's a better approach.

Kevin
