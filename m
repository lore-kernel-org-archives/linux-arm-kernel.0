From: slash.tmp@free.fr (Mason)
Date: Mon, 2 Nov 2015 12:55:45 +0100
Subject: CPU_METHOD_OF_DECLARE() with Linux as non-secure OS
In-Reply-To: <20151102101750.GS8644@n2100.arm.linux.org.uk>
References: <5630C143.5080103@free.fr> <yw1xio5pd5mf.fsf@unicorn.mansr.com>
 <56325C67.8000007@free.fr> <yw1xeggdd007.fsf@unicorn.mansr.com>
 <5633CF2A.4040504@free.fr> <yw1xpozvavui.fsf@unicorn.mansr.com>
 <20151102101750.GS8644@n2100.arm.linux.org.uk>
Message-ID: <56374F41.3000402@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2015 11:17, Russell King - ARM Linux wrote:

> Eg, you could have the FLZ bit set in the L2 cache auxiliary register
> if its wired to a Cortex A9 CPU and the FLZ signal is wired.  That
> would be perfectly reasonable, provided the FLZ bit in the Cortex
> A9's control register is disabled when the L2 cache is otherwise
> disabled.
> 
> (I guess I ought to quieten down the pr_err() in that case...)

Based on the pr_err(), I thought it was considered an error, so
I asked the firmware author to leave L2AUX.FLZ cleared, and only
set it just before the cache is enabled, and clear it after the
cache is disabled.

Do you remember why you considered it an error at the time?

Regards.
