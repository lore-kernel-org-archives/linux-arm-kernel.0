From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 17 Dec 2013 11:29:14 +0000
Subject: [Linaro-acpi] [RFC part1 PATCH 1/7] ACPI: Make ACPI core
 running without PCI on ARM64
In-Reply-To: <20131216205133.GI5617@xora-haswell.xora.org.uk>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <201312091735.05014.arnd@arndb.de> <20131209165548.GE19163@arm.com>
 <201312091820.23006.arnd@arndb.de> <20131209180155.GG19163@arm.com>
 <20131216205133.GI5617@xora-haswell.xora.org.uk>
Message-ID: <20131217112914.GB32118@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Graeme,

On Mon, Dec 16, 2013 at 08:51:33PM +0000, Graeme Gregory wrote:
> So the real question now is how do we progress with these ACPI patches? After
> repeated incorrect accusations of developing behind closed doors I am loath
> to dissapear back into linaro with them for another few months.

Well, just follow the Linux community process, no need to disappear
back. There was feedback that needs to be addressed, work on getting
acks from maintainers. The first version has only been posted two weeks
ago, I don't see any reason to panic ;).

> Also as Mark Brown has already pointed out the bigger the patchset gets
> while developed in Linaro trees the more strain it is going to put on
> maintainers for review.

Yes, that's correct, so just gather maintainer's acks in smaller steps.

> We have worked to try and keep the patchset as self contained as possible
> and to affect arch/arm64 in a minimal way. It should not affect it at all
> in the !CONFIG_ACPI case.

And this is great, I really don't have any complaints here.

> Currently Hanjun is busy preparing a v2 PATCH series which contains amendments
> for all the technical issues found in review so far. Should we continue with
> this process until all the neccessary Acks are in place?

Reviews/acks is the first step and you are on the right track here. The
following step would be upstreaming with good arguments on why and when
the code needs to be merged. Code quality on its own is not an argument
for merging. Backlog in Linaro's trees is not an argument either. You
could of course start upstreaming clean-up code that is necessary
whether you have ACPI on arm64 or not.

So while waiting to debate the good arguments for when to merge the code
(once reviewed), I have several concerns which I want addressed before
enabling ACPI for arm64:

- Does anyone have a wider view of how ACPI on ARM looks like? There is
  a lot of effort going into the next version of ACPI but for now I
  don't see how we can enable a feature and hope we sort it out later.
- Who is coordinating the non-standard ACPI descriptors being pushed to
  various drivers in the kernel? Do we trust the hw vendors to do the
  right thing (and also talk to each other)?
- What if two hw vendors have different descriptors for the same device?
- Have we agreed what we do about clocks, voltage regulators?
- Do we actually have a real platform which requires ACPI at this point?

Just to be clear, I'm not against ACPI for arm64 and I am aware of
hardware vendors requiring this. But I'm looking forward to them being
more open and explain what (rather than why) they need because I don't
think ACPI solves anything for the ARM kernel community. It's rather a
favour we do to them and OS distros.

-- 
Catalin
