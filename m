From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 12 Feb 2018 15:56:53 +0100
Subject: [PATCH] acpi, spcr: Make SPCR available to x86
In-Reply-To: <1e69fffc-1c3b-8cc0-f1cb-695de5ccdcb5@redhat.com>
References: <20180118150951.28964-1-prarit@redhat.com>
 <20180212133429.GC25314@hirez.programming.kicks-ass.net>
 <1e69fffc-1c3b-8cc0-f1cb-695de5ccdcb5@redhat.com>
Message-ID: <20180212145652.GM25181@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 08:47:57AM -0500, Prarit Bhargava wrote:
> 
> 
> On 02/12/2018 08:34 AM, Peter Zijlstra wrote:
> > On Thu, Jan 18, 2018 at 10:09:51AM -0500, Prarit Bhargava wrote:
> >>  config ACPI_SPCR_TABLE
> >> +	bool "ACPI Serial Port Console Redirection Support"
> >> +	default y if X86
> >> +	help
> >> +	  Enable support for Serial Port Console Redirection (SPCR) Table.
> >> +	  This table provides information about the configuration of the
> >> +	  earlycon console.
> > 
> > I just got asked this by oldconfig, which left me rather puzzled, WTF
> > does this do?
> 
> Odd -- I thought I had taken care of that :(  My apologies Peter.
> 
> ACPI SPCR is used by a vendor to define the serial console for a system.  If
> SPCR exists a user can add kernel parameter "earlycon" (no extra kernel
> parameters) and the console will work out-of-the-box.
> 
> The serial console configuration varies from vendor to vendor.  This takes the
> guess-work out of defining a serial console.

But when I specify "earlyprintk=serial,ttyS0,115200" this SPCR crud will
not interfere?
