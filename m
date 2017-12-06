From: mingo@kernel.org (Ingo Molnar)
Date: Wed, 6 Dec 2017 19:37:34 +0100
Subject: [RFC v3 PATCH 0/2] Introduce Security Version to EFI Stub
In-Reply-To: <20171206032437.pifxxcewgozlghfs@GaryWorkstation>
References: <20171205100148.5757-1-glin@suse.com>
 <CA+5PVA4k9RN22i2d=4GCPnm9bwi5KUgp8PiV=9X1pBZxN1xPmg@mail.gmail.com>
 <20171206032437.pifxxcewgozlghfs@GaryWorkstation>
Message-ID: <20171206183734.xmgecyrd5suiurm6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Gary Lin <glin@suse.com> wrote:

> On Tue, Dec 05, 2017 at 04:14:26PM -0500, Josh Boyer wrote:
> > On Tue, Dec 5, 2017 at 5:01 AM, Gary Lin <glin@suse.com> wrote:
> > > The series of patches introduce Security Version to EFI stub.
> > >
> > > Security Version is a monotonically increasing number and designed to
> > > prevent the user from loading an insecure kernel accidentally. The
> > > bootloader maintains a list of security versions corresponding to
> > > different distributions. After fixing a critical vulnerability, the
> > > distribution kernel maintainer bumps the "version", and the bootloader
> > > updates the list automatically. When the user tries to load a kernel
> > > with a lower security version, the bootloader shows a warning prompt
> > > to notify the user the potential risk.
> > 
> > If a distribution releases a kernel with a higher security version and
> > that it automatically updated on boot, what happens if that kernel
> > contains a different bug that causes it to fail to boot or break
> > critical functionality?  At that point, the user's machine would be in
> > a state where the higher security version is enforced but the only
> > kernel that provides that is broken.  Wouldn't that make a bad
> > situation even worse by now requiring manual acceptance of the older
> > SV kernel boot physically at the machine?
> > 
> > I feel like I'm missing a detail here or something.
> > 
> If the new kernel fails to boot, then the user has to choose the kernel
> manually anyway, and there will be an option in the warning prompt to
> lower SV.

And what if the firmware does not support a lowering of the SV?

Thanks,

	Ingo
