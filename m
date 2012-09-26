From: tim.bird@am.sony.com (Tim Bird)
Date: Wed, 26 Sep 2012 07:48:06 -0700
Subject: [RFC PATCH 0/3] ARM: uncompress.h multi-platform enablement
In-Reply-To: <201209261417.18883.arnd@arndb.de>
References: <1348613212-21897-1-git-send-email-swarren@wwwdotorg.org>
 <20120926104421.GA7040@n2100.arm.linux.org.uk> <506307A0.7010701@am.sony.com>
 <201209261417.18883.arnd@arndb.de>
Message-ID: <506315A6.3090300@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2012 07:17 AM, Arnd Bergmann wrote:
> On Wednesday 26 September 2012, Tim Bird wrote:
>> Will those of us not interested in a single kernel binary
>> that works everywhere be able to configure an ARM kernel image
>> without a lot of bloat?
> 
> I'm not aware of increase in code size from the single kernel
> image yet. If you find something, let us know.

I have been assuming that the device tree conversion
added a small overhead to both the kernel size and
the boot time.  You are correct that I should measure
this before complaining. :-)  I'll try to do that when
I have some time.  Unfortunately, before and after
size snapshots are a little difficult to obtain --
it appears that support for device tree involves other
refactoring.

My main issue is to avoid requiring the loading of
drivers and features that are not required for a
platform, if the platform does not need it (or the
developer chooses to omit it).  I may have mis-read
this thread, but it sounded like the uncompress
code was going to be moved to a common area and
not be configurable.

Sorry if this is not the case.
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Workgroup of the Linux Foundation
Senior Staff Engineer, Sony Network Entertainment
=============================
