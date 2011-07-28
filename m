From: robherring2@gmail.com (Rob Herring)
Date: Thu, 28 Jul 2011 08:21:23 -0500
Subject: [RFC PATCH 0/3] ARM: Add default system.h and uncompress.h
In-Reply-To: <20110728095221.GA31473@n2100.arm.linux.org.uk>
References: <1311823934-29553-1-git-send-email-robherring2@gmail.com>
	<20110728095221.GA31473@n2100.arm.linux.org.uk>
Message-ID: <4E316253.1070601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28/2011 04:52 AM, Russell King - ARM Linux wrote:
> On Wed, Jul 27, 2011 at 10:32:11PM -0500, Rob Herring wrote:
>> One downside is you lose print capability in the decompressor. However,
>> I don't think the complexity that adds is worth the 1 line print.
> 
> You're wrong there - it's very very useful to have that from the
> decompressor.  It's saved many people (including us) a lot of wasted
> time caused by faulty hardware implementation.
> 
> Normally, if the design of the SDRAM connections is poor, the first
> thing which catches it is the decompressor, and so its that which we
> really want error information from.
> 
Agreed. I have seen that case as well, but generally only very early on
in board/chip bringup. Really, bootloaders need a decent memory test or
ability to load one.

> So no, losing that ability is not an option.  Really.

If a platform has an uncompress.h, then you don't lose anything. Is it
something that has to *always* be available? Are you opposed to a config
option here? It can be available only for single arch/machine builds
similar to DEBUG_LL.

Rob
