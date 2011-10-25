From: tony@atomide.com (Tony Lindgren)
Date: Tue, 25 Oct 2011 09:38:23 +0200
Subject: [RFC PATCH 14/15] ARM: uncompress: Get decompress UART info
	from DT
In-Reply-To: <20111024093044.GG9893@n2100.arm.linux.org.uk>
References: <1319404245-12740-1-git-send-email-zoss@devai.org>
	<1319404245-12740-14-git-send-email-zoss@devai.org>
	<20111024093044.GG9893@n2100.arm.linux.org.uk>
Message-ID: <20111025073823.GF4429@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [111024 10:56]:
> On Sun, Oct 23, 2011 at 11:10:44PM +0200, Zoltan Devai wrote:
> > Allow the static decompress UART setup in uncompress.h
> > files to be overridden with an ucuart description in DT.
> > 
> > At a later stage, this may also allow to skip the
> > inclusion of uncompress.h files on arches which are DT-only,
> > to get rid of these files completely.
> 
> This needs to be reviewed by DT people.

Nice patch series!

I like this approach, because it allows us to:

1. Use this DT entry entry for earlyprintk, and then
   CONFIG_DEBUG_LL can be separated from all this

2. CONFIG_DEBUG_LL can now be reserved for the low-level
   debugging when bringing up new SoC/board etc

3. This allows seeing uncompress errors on unsupported
   boards, which is important when working on multiarch support

4. With this series we can turn earlyprintk into something
   that can be compiled into production kernels too

I have not looked through the patch series if it uses still
CONFIG_DEBUG_LL somewhere, but if it does, it should be
separated from that.

Cheers,

Tony
