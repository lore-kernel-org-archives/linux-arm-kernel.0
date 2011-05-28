From: khilman@ti.com (Kevin Hilman)
Date: Fri, 27 May 2011 17:32:12 -0700
Subject: [PATCH] OMAP: don't trace functions called from sched_clock
In-Reply-To: <87hb8fyj2p.fsf@ti.com> (Kevin Hilman's message of "Fri, 27 May
	2011 13:39:10 -0700")
References: <1304846514-15641-1-git-send-email-rabin@rab.in>
	<87hb8fyj2p.fsf@ti.com>
Message-ID: <8762ovvf5f.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@ti.com> writes:

> Rabin Vincent <rabin@rab.in> writes:
>
>> omap_readl() is used from the sched_clock() implementations and so must
>> be marked notrace to avoid recursion in ftrace.  Same thing with
>> mpu_read() for OMAP1.
>>
>> Signed-off-by: Rabin Vincent <rabin@rab.in>
>
> Acked-by: Kevin Hilman <khilman@ti.com>

I also meant to suggest this should probably queue for .40-rc series.

Kevin
