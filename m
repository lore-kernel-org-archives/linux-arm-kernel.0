From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 20 Jan 2010 10:16:39 +0100
Subject: [PATCH/RFC v1 0/2] Human readable performance event
	description in sysfs
In-Reply-To: <1263978706-15499-1-git-send-email-t.fujak@samsung.com>
References: <1263978706-15499-1-git-send-email-t.fujak@samsung.com>
Message-ID: <1263978999.4283.823.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-01-20 at 10:11 +0100, Tomasz Fujak wrote:
> Hi,
> 
> While I managed to build and run the early version (back from
> December), I was unable to find the newest sources (infra + ARMv6,
> ARMv7 support).
> Where do I find them?
> 
> The following patches provide a sysfs entry with hardware event human
> readable description in the form of "0x%llx\t%lld-%lld\t%s\t%s" %
> (event_value, minval, maxval, name, description) and means to populate
> the file.
> The version posted contains ARMv6, ARMv7 (Cortex-A[89]) support in
> this matter.
> 
> The intended use is twofold: for users to read the list directly and
> for tools (like perf).
> 
> This series includes:
> [PATCH v1 1/2] perfevent: Add performance event structure definition
> and 'extevents' sysfs entry
> [PATCH v1 2/2] [ARM] perfevent: Event description list for ARMv6,
> Cortex-A8 and Cortex-A9 exported

Why do this in kernel space? Listing available events seems like
something we can do from userspace just fine.
