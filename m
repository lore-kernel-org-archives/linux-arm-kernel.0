From: will.deacon@arm.com (Will Deacon)
Date: Thu, 9 Feb 2017 14:33:31 +0000
Subject: Memory Incoherence Issue
In-Reply-To: <989deba2-f1fb-550c-afdd-e7732d97583c@gmail.com>
References: <989deba2-f1fb-550c-afdd-e7732d97583c@gmail.com>
Message-ID: <20170209143331.GD19397@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

On Thu, Feb 02, 2017 at 06:00:02PM -0800, Doug Berger wrote:
> We have a device that is based on a dual-core A15 MPCore host CPU
> complex that has been exhibiting a problem with very infrequent memory
> corruption when exercising a user space memory tester program
> (memtester) in a system designed around a v3.14 Linux environment.
> Unfortunately, it is not possible to update this system to the latest
> kernel version for testing at this time.

So what are the options for changing the kernel being used here? Are you
using v3.14, or a stable variant?

There have been many fixes since 3.14 (e.g. 8e6480667246 ("ARM: 8299/1:
mm: ensure local active ASID is marked as allocated on rollover") and
so you could simply be hitting a known, fixed issue.

Will
