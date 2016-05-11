From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 May 2016 10:40:57 +0100
Subject: [PATCH] arm64: cpuinfo: Missing NULL terminator in
 compat_hwcap_str
In-Reply-To: <5732FD9C.8000503@arm.com>
References: <1462891231-17605-1-git-send-email-julien.grall@arm.com>
 <20160510145441.GC10785@leverpostej> <5732FD9C.8000503@arm.com>
Message-ID: <20160511094057.GE26564@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 10:38:36AM +0100, Julien Grall wrote:
> Hi Mark,
> 
> On 10/05/2016 15:54, Mark Rutland wrote:
> >On Tue, May 10, 2016 at 03:40:31PM +0100, Julien Grall wrote:
> >>The loop that browses the array compat_hwcap_str will stop when a NULL
> >>is encountered, however NULL is missing at the end of array. This will
> >>result to overrun until one NULL is found somewhere in the memory.
> >
> >Probably worth adding something like:
> >
> >Note for backporting: commit 12d11817eaafa414 ("arm64: Move
> >/proc/cpuinfo handling code") moved this code. Prior to that commit, the
> >same change should be made in arch/arm64/kernel/setup.c.
> 
> I can resend the patch with this changes.

No need, I've already applied it locally with Mark's suggestions.

Will
