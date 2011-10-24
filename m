From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Oct 2011 10:23:23 +0100
Subject: [RFC PATCH 07/15] ARM: uncompress: Move decompressing related
	stuff to decompress.c
In-Reply-To: <20111024091756.GC9893@n2100.arm.linux.org.uk>
References: <1319404245-12740-1-git-send-email-zoss@devai.org>
	<1319404245-12740-7-git-send-email-zoss@devai.org>
	<20111024091756.GC9893@n2100.arm.linux.org.uk>
Message-ID: <20111024092323.GD9893@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2011 at 10:17:56AM +0100, Russell King - ARM Linux wrote:
> On Sun, Oct 23, 2011 at 11:10:37PM +0200, Zoltan Devai wrote:
> > +void putstr(const char *ptr);
> > +void error(char *x);
> > +extern unsigned int __machine_arch_type;
> > +#define arch_id __machine_arch_type
> 
> Why do we need this new define?  arch_id in this file has only been a
> local parameter to a function, and with your changes it looks like all
> references have been removed.

Ignore this - it's needed for calls to arch_decomp_setup().
