From: prarit@redhat.com (Prarit Bhargava)
Date: Mon, 12 Feb 2018 09:49:47 -0500
Subject: [PATCH] acpi, spcr: Make SPCR available to x86
In-Reply-To: <953565bd-436b-c1fe-d3c5-cde731dee83d@codeaurora.org>
References: <20180118150951.28964-1-prarit@redhat.com>
 <20180212133429.GC25314@hirez.programming.kicks-ass.net>
 <1e69fffc-1c3b-8cc0-f1cb-695de5ccdcb5@redhat.com>
 <953565bd-436b-c1fe-d3c5-cde731dee83d@codeaurora.org>
Message-ID: <7bd5897f-d6da-7e29-29c4-aa26d24f6355@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/12/2018 09:43 AM, Timur Tabi wrote:
> On 2/12/18 7:47 AM, Prarit Bhargava wrote:
>> ACPI SPCR is used by a vendor to define the serial console for a system.  If
>> SPCR exists a user can add kernel parameter "earlycon" (no extra kernel
>> parameters) and the console will work out-of-the-box.
> 
> "earlycon" is needed only for an *early* console.  You don't need any command
> line parameters for a normal console to work with SPCR.

That's true on ARM64.  I specifically did not enable the console by default on
x86.  There are users who do not want a console active during boot & runtime.

P.

> 
