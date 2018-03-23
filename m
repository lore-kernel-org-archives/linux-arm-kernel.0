From: jhogan@kernel.org (James Hogan)
Date: Fri, 23 Mar 2018 21:08:12 +0000
Subject: [PATCH V3] ZBOOT: fix stack protector in compressed boot phase
In-Reply-To: <1521777055.1510.9.camel@flygoat.com>
References: <1521186916-13745-1-git-send-email-chenhc@lemote.com>
 <20180322222107.GJ13126@saruman>
 <1521777055.1510.9.camel@flygoat.com>
Message-ID: <20180323210811.GD11796@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 23, 2018 at 11:50:55AM +0800, Jiaxun Yang wrote:
> ? 2018-03-22?? 22:21 +0000?James Hogan???
> > Also I think it worth mentioning in the commit message the MIPS
> > configuration you hit this with, presumably a Loongson one? For me
> > decompress_kernel() gets a stack guard on loongson3_defconfig, but
> > not
> > malta_defconfig or malta_defconfig + 64-bit. I presume its sensitive
> > to
> > the compiler inlining stuff into decompress_kernel() or something
> > such
> > that it suddenly qualifies for a stack guard.
> 
> Have you tested with CONFIG_CC_STACKPROTECTOR_STRONG=y ?

Yes. for malta_defconfig I could only reproduce by adding an array to
decompress_kernel() so that it would get the guard.

Cheers
James
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180323/6a2e96af/attachment.sig>
