From: graeme.gregory@linaro.org (Graeme Gregory)
Date: Mon, 16 Dec 2013 20:51:33 +0000
Subject: [Linaro-acpi] [RFC part1 PATCH 1/7] ACPI: Make ACPI core running
 without PCI on ARM64
In-Reply-To: <20131209180155.GG19163@arm.com>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <201312091735.05014.arnd@arndb.de> <20131209165548.GE19163@arm.com>
 <201312091820.23006.arnd@arndb.de> <20131209180155.GG19163@arm.com>
Message-ID: <20131216205133.GI5617@xora-haswell.xora.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 06:01:55PM +0000, Catalin Marinas wrote:
> On Mon, Dec 09, 2013 at 05:20:22PM +0000, Arnd Bergmann wrote:
> > On Monday 09 December 2013, Catalin Marinas wrote:
> > > CONFIG_PCI does not exist on arm64 yet (we have some internal patches
> > > but may not be ready to be posted before the holidays; they try to share
> > > code with other archs, so more discussions before merging). We could add
> > > CONFIG_PCI and some dummy functions on arm64 for development (not to be
> > > upstreamed) or Hanjun could continue to use the current patch before we
> > > get PCI working. In the order of priorities, we'll have to merge PCI
> > > before ACPI anyway.
> > 
> > Well, lack of PCI support on ARM64 is a much better reason for accepting
> > the patch than potential use on non-server platforms of course.
> 
> As I said above about priorities, we are not in a hurry to merge ACPI
> for arm64 before PCI is supported.
> 
> > What is the status of the PCI work though? I suspect it won't be all
> > that hard to add minimal PCI support for a simple mmconfig plus
> > fixed I/O space based host of the kind that qemu can easily provide.
> 
> Liviu (ARM engineer) has been working on generalising the microblaze
> code (which is very similar to powerpc) and enable it on arm64. The
> patches will be posted soon (though may slip into the new year) but
> there will be many discussions on how to do this best, so I don't expect
> a quick merge.
> 
> In parallel, Will is looking at getting PCI to work with kvmtool and
> that's something we could merge sooner (but again, in the new year).
> 
> > The hard part that we want to share code with other architectures is
> > supporting pluggable host controllers, and I think we can defer that
> > a bit.
> 
> Indeed, this would take time.
> 
Hi Catalin,

So the real question now is how do we progress with these ACPI patches? After
repeated incorrect accusations of developing behind closed doors I am loath
to dissapear back into linaro with them for another few months.

Also as Mark Brown has already pointed out the bigger the patchset gets
while developed in Linaro trees the more strain it is going to put on
maintainers for review.

We have worked to try and keep the patchset as self contained as possible
and to affect arch/arm64 in a minimal way. It should not affect it at all
in the !CONFIG_ACPI case.

Currently Hanjun is busy preparing a v2 PATCH series which contains amendments
for all the technical issues found in review so far. Should we continue with
this process until all the neccessary Acks are in place?

Graeme
