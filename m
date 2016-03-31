From: broonie@kernel.org (Mark Brown)
Date: Thu, 31 Mar 2016 08:28:54 -0700
Subject: [PATCH] ACPI / ARM64: Remove EXPERT dependency for ACPI on ARM64
In-Reply-To: <20160331123649.GE18910@arm.com>
References: <1459360718-24125-1-git-send-email-broonie@kernel.org>
 <56FC9D1D.6090808@huawei.com>
 <CAJZ5v0gv-MJ+Ss8gtc80z2_sOq-3qfBYbspRU8MWRNvn+UVbUg@mail.gmail.com>
 <20160331123649.GE18910@arm.com>
Message-ID: <20160331152854.GA2350@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 01:36:50PM +0100, Will Deacon wrote:

> I'm unsure about whether or not we want 'default y' here, but I'd like

I can easily do followup patches which change that to be "default y if
!ARM64" (or default y if $OTHER_ARCHES) and adding CONFIG_ACPI to
defconfig (for the test coverage) if that helps?  I think that's
perfectly reasonable.  As Ard says if both DT and ACPI are built in then
the kernel will continue to prefer DT if it finds one.

> to wait for Catalin to come back from his 2-week holiday before going
> anywhere with this patch. It's only fair that his opinion should be
> taken into account, and there's not a huge rush for this. I do consider

It definitely makes sense to get Catalin's input.  I do think that this
is something we don't want to defer indefinitely though, I think we're
hurting ourselves more than we're helping.

> "ACPI-only platforms" as simply "platforms without a .dtb" (modulo
> any significant AML code) and therefore don't view this as a blocking
> issue.

I think people with a system with no DT provided might disagree on that
one, and that this isn't really about end users or even distros but
rather about the people working upstream and especially doing test and
QA work upstream.

> We should also take into account the large amount of ongoing ACPI work
> (e.g. the DSD and PRP0001 saga, PCI and IORT support, virtualisation work,
> etc), and decide whether or not that's currently in a state where we want
> to encourage people to start using this in their arm64 kernels.

My perception is that the EXPERT dependency is not having a meaningful
impact on people who want to use ACPI, they're just going ahead and
doing it anyway and expecting that distros will ship kernels which
enable ACPI (which realistically the ones that don't currently are going
to do as they start encountering these platforms).  There doesn't seem
to be much sign that decisions about shipping systems are being guided
by this and the work that's happening on ACPI is going on regardless,
some of it x86 focused.

The kernel will still continue to prefer DT on arm64 systems so it's
still the default upstream.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160331/b5cf37c5/attachment.sig>
