From: jlinton@redhat.com (Jeremy Linton)
Date: Mon, 23 Nov 2015 08:48:40 -0600
Subject: [PATCH] [PATCH] arm64: Boot failure on m400 with new cont PTEs
In-Reply-To: <20151123134911.GB28293@leverpostej>
References: <1447858999-26665-1-git-send-email-jeremy.linton@arm.com>
 <20151118152044.GD10644@leverpostej> <564CA29A.9050905@arm.com>
 <20151118162932.GA13355@leverpostej> <564CB1DA.4090304@arm.com>
 <20151118180434.GB13355@leverpostej> <564CD206.9040402@arm.com>
 <20151119112923.GA24570@leverpostej> <20151120195243.GC14942@leverpostej>
 <20151123121514.GB32300@e104818-lin.cambridge.arm.com>
 <20151123134911.GB28293@leverpostej>
Message-ID: <56532748.4010508@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/2015 07:49 AM, Mark Rutland wrote:
> Jeremy, for reference, have you tried kasan on m400? Or DEBUG_RODATA?


No, because the machine has a list of issues that keep it from booting a 
mainline kernel in a functional state. Once those are cleared up I will 
revisit this patch.

The goal was to create a conceptually safe fix for the problem, which 
isn't all this hypothetical stuff being discussed, but the fact that the 
TLBs are not being flushed properly (with or without the CONT bit stuff) 
resulting in a tlb conflict fault long after this code path has finished 
executing.
