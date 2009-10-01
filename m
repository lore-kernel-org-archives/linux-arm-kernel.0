From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Oct 2009 13:56:57 +0100
Subject: [PATCH 2/2] arm: Clean up linker script using new linker
	script macros.
In-Reply-To: <20090930213924.GB15732@merkur.ravnborg.org>
References: <1254345935-15958-1-git-send-email-tabbott@ksplice.com>
	<1254345935-15958-3-git-send-email-tabbott@ksplice.com>
	<20090930213924.GB15732@merkur.ravnborg.org>
Message-ID: <20091001125657.GA26910@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2009 at 11:39:25PM +0200, Sam Ravnborg wrote:
> On Wed, Sep 30, 2009 at 05:25:35PM -0400, Tim Abbott wrote:
> > From: Nelson Elhage <nelhage@ksplice.com>
> > 
> > This patch is mostly a straightforward translation. The primary side
> > effect to the resulting vmlinux should be to increase the alignment on
> > the initramfs to the standard PAGE_SIZE from 32 bytes.
> > 
> > Signed-off-by: Nelson Elhage <nelhage@ksplice.com>
> > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > Signed-off-by: Tim Abbott <tabbott@ksplice.com>
> > ---
> >  arch/arm/kernel/vmlinux.lds.S |   75 +++++++++++-----------------------------
> >  1 files changed, 21 insertions(+), 54 deletions(-)
> > 
> >  
> > -	.bss : {
> > -		__bss_start = .;	/* BSS				*/
> > -		*(.bss)
> > -		*(COMMON)
> > -		__bss_stop = .;
> > -		_end = .;
> 
> Where is _end in the new layout?
> I think we lost it.

You're right - this will cause a build failure since _end is used in
several core ARM files.  Tim?

PS, please ensure that all patches are at the very least build tested,
or say when they aren't.
