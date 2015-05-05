From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 5 May 2015 16:51:14 +0100
Subject: [PATCH v3 1/6] ARM: l2c: Add DT support for Shared Override
In-Reply-To: <CAMuHMdXpStgQpq6A7GDc2iXNgmBNWjP82E5TykzTUS=6hrWVRw@mail.gmail.com>
References: <1430753072-17145-1-git-send-email-geert+renesas@glider.be>
 <1430753072-17145-2-git-send-email-geert+renesas@glider.be>
 <20150505112145.GG22384@e104818-lin.cambridge.arm.com>
 <CAMuHMdWE3HjGk73gCN3P-bBVEGrMbgfJ=FqvcTtGecs15R=A_g@mail.gmail.com>
 <20150505142211.GH22384@e104818-lin.cambridge.arm.com>
 <CAMuHMdXpStgQpq6A7GDc2iXNgmBNWjP82E5TykzTUS=6hrWVRw@mail.gmail.com>
Message-ID: <20150505155113.GI22384@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 05, 2015 at 04:55:02PM +0200, Geert Uytterhoeven wrote:
> On Tue, May 5, 2015 at 4:22 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > BTW, your patch mentions r2p0. My reading of the PL310 TRM shows this
> > bit as default from r0p0.
> 
> Arnd told me he had read the documentation for r0p0 and couldn't find it.
> The r3p2 manual lists the following changes between r1p0-r2p0:
>   - new behavior linked to the Shared attribute.

Bit 22 is present since r0p0 with the same description as in r2p0 and
later:

http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0246a/Ceggcfcj.html

I guess the new behaviour is about bit 13, Shared Attribute Invalidate
Enable:

http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0246c/Ceggcfcj.html

But that's outside the scope of this patch.

-- 
Catalin
