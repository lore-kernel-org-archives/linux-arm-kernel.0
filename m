From: graeme.gregory@linaro.org (Graeme Gregory)
Date: Thu, 19 Dec 2013 11:30:51 +0000
Subject: [Linaro-acpi] [RFC part1 PATCH 1/7] ACPI: Make ACPI core running
 without PCI on ARM64
In-Reply-To: <20131217112914.GB32118@arm.com>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <201312091735.05014.arnd@arndb.de> <20131209165548.GE19163@arm.com>
 <201312091820.23006.arnd@arndb.de> <20131209180155.GG19163@arm.com>
 <20131216205133.GI5617@xora-haswell.xora.org.uk>
 <20131217112914.GB32118@arm.com>
Message-ID: <20131219113051.GL2736@xora-haswell.xora.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 11:29:14AM +0000, Catalin Marinas wrote:
> Hi Graeme,
> 
> On Mon, Dec 16, 2013 at 08:51:33PM +0000, Graeme Gregory wrote:
> > So the real question now is how do we progress with these ACPI patches? After
> > repeated incorrect accusations of developing behind closed doors I am loath
> > to dissapear back into linaro with them for another few months.
> 
> Well, just follow the Linux community process, no need to disappear
> back. There was feedback that needs to be addressed, work on getting
> acks from maintainers. The first version has only been posted two weeks
> ago, I don't see any reason to panic ;).
> 

Ok, thanks for that, we will continue to work on v2, v3, ... as normal then

> Reviews/acks is the first step and you are on the right track here. The
> following step would be upstreaming with good arguments on why and when
> the code needs to be merged. Code quality on its own is not an argument
> for merging. Backlog in Linaro's trees is not an argument either. You
> could of course start upstreaming clean-up code that is necessary
> whether you have ACPI on arm64 or not.
>

Yes coming out of the reviews some of the patches which we initially thought
were ARM64 work turned out to be general cleanups and they will go via
the appropriate channel.

> So while waiting to debate the good arguments for when to merge the code
> (once reviewed), I have several concerns which I want addressed before
> enabling ACPI for arm64:
> 
> - Does anyone have a wider view of how ACPI on ARM looks like? There is
>   a lot of effort going into the next version of ACPI but for now I
>   don't see how we can enable a feature and hope we sort it out later.
> - Who is coordinating the non-standard ACPI descriptors being pushed to
>   various drivers in the kernel? Do we trust the hw vendors to do the
>   right thing (and also talk to each other)?
> - What if two hw vendors have different descriptors for the same device?
> - Have we agreed what we do about clocks, voltage regulators?
> - Do we actually have a real platform which requires ACPI at this point?
> 
> Just to be clear, I'm not against ACPI for arm64 and I am aware of
> hardware vendors requiring this. But I'm looking forward to them being
> more open and explain what (rather than why) they need because I don't
> think ACPI solves anything for the ARM kernel community. It's rather a
> favour we do to them and OS distros.
> 

You have some good points here, obviously we are currently working on
preperation work based on the RTSM/FVP (whatever they are called next week)
models which currently are not a good representation of an armv8 server.

Hopefully the documenation of what real armv8 server architecture will look
like will come in the new year. Things like regulators and clocks I do not
have answers to yet as obviously in Intel world these things are hidden
from view, I do not know what the plan is for armv8 silicon/motherboards.

On the multiple venders same hardware issue I guess Intel guys must have
already seen this happen. We shall have to ask them what their solution was?

Graeme
