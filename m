From: cavokz@gmail.com (Domenico Andreoli)
Date: Tue, 17 Jul 2012 16:41:09 +0200
Subject: [RFC PATCH 05/12] ARM: Add DT support to decompressor tags
In-Reply-To: <201207171414.19624.arnd@arndb.de>
References: <20120715024408.747946928@gmail.com>
 <20120715024609.513918780@gmail.com>
 <201207171414.19624.arnd@arndb.de>
Message-ID: <20120717144109.GA9991@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 02:14:19PM +0000, Arnd Bergmann wrote:
> On Sunday 15 July 2012, Domenico Andreoli wrote:
> > -ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
> >  OBJS   += $(libfdt_objs) atags_to_fdt.o
> > -endif
> 
> Can you explain why this is necessary? I don't see any code
> of that file being called from the newly added code for the
> case where CONFIG_ARM_ATAG_DTB_COMPAT is disabled.

I put function get_fdt_prop() in atags_to_fdt.c but what I basically needed
was the inclusion of $(libfdt_objs). I agree this can be achieved out of
CONFIG_ARM_ATAG_DTB_COMPAT's stuff and I'll do if the patchest is allowed
to mature.

I guess a better place could be libfdt itself but feel free to suggest a
better one.

Thanks,
Domenico
