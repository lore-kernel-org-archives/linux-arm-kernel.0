From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 06 Dec 2013 12:25:11 +0000
Subject: [PATCH 1/3] arm64: add EFI stub
In-Reply-To: <20131205152806.GC974@darko.cambridge.arm.com>
References: <1385762712-17043-1-git-send-email-msalter@redhat.com> <
 1385762712-17043-2-git-send-email-msalter@redhat.com> <20131205141853.GA974
 @darko.cambridge.arm.com> <1386254603.1861.120.camel@deneb.redhat.com> <
 20131205152806.GC974@darko.cambridge.arm.com>
Message-ID: <20131206122511.301D6C40757@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 Dec 2013 15:28:06 +0000, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, Dec 05, 2013 at 02:43:23PM +0000, Mark Salter wrote:
> > On Thu, 2013-12-05 at 14:18 +0000, Catalin Marinas wrote:
> > > On Fri, Nov 29, 2013 at 10:05:10PM +0000, Mark Salter wrote:
> > > > This patch adds PE/COFF header fields to the start of the Image
> > > > so that it appears as an EFI application to EFI firmware. An EFI
> > > > stub is included to allow direct booting of the kernel Image. Due
> > > > to EFI firmware limitations, only little endian kernels with 4K
> > > > page sizes are supported at this time.
> > > 
> > > I don't fully understand the EFI firmware limitations but for big endian
> > > we could have the EFI_STUB wrapper in little endian and get the kernel
> > > to switch to big endian once booted. The image header should always be
> > > little endian.
> > 
> > That would be fun. :) You'd also have to switch back and forth to make
> > EFI runtime services calls.
> 
> OK, we'll have to live with this restriction.

Or just disable runtime services on the switch to big ending. Big endian
should not disable the stub (but getting it to work could be a follow-up
patch)

g.
