From: will.deacon@arm.com (Will Deacon)
Date: Tue, 16 Jul 2013 17:49:05 +0100
Subject: [PATCH] ARM: a.out: remove partial a.out support
In-Reply-To: <20130715140825.GU24642@n2100.arm.linux.org.uk>
References: <1373894897-30607-1-git-send-email-will.deacon@arm.com>
 <20130715140825.GU24642@n2100.arm.linux.org.uk>
Message-ID: <20130716164905.GA3428@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Jul 15, 2013 at 03:08:25PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 15, 2013 at 02:28:17PM +0100, Will Deacon wrote:
> >  arch/arm/include/uapi/asm/Kbuild  |  1 -
> >  arch/arm/include/uapi/asm/a.out.h | 34 -----------------------------
> 
> I don't think we can remove this quite as easily as this - this is
> a user visible API change as it's part of the userland headers, and
> will break anything in userspace which includes <a.out.h>

Does this actually matter? If we're removing aout support anyway, those
programs will be broken by that. Looking at powerpc, sparc, sh and others it
seems as though their a.out.h headers were removed a while ago despite being
exported to userspace. I managed to get a 2.6.25 tree to generate headers
confirming this.

Will
