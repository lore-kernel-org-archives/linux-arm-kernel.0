From: ynvich@gmail.com (Sergei Ianovich)
Date: Tue, 10 Dec 2013 08:25:21 +0400
Subject: [PATCH 5/9] ARM: dts: provide DMA config to pxamci
In-Reply-To: <201312100125.18754.arnd@arndb.de>
References: <1386348542-9584-1-git-send-email-ynvich@gmail.com>
 <52A59991.1060305@gmail.com> <1386590958.7152.135.camel@host5.omatika.ru>
 <201312100125.18754.arnd@arndb.de>
Message-ID: <1386649521.7152.196.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-12-10 at 01:25 +0100, Arnd Bergmann wrote:
> We never intentionally break things that people are using, but there are
> cases where doing blind changes is the best way forward. We should
> always try to find people to test patches on real hardware if possible,
> which is only possible if there are people around that have the hardware
> and that are going to run new kernels on them.
> 
> In case of PXA dmaengine support, I think the benefits of applying the
> series far outweigh the breakage potential. A lot of the drivers are
> shared with MMP, which is going to be DT-only eventually and will require
> the new dmaengine code. Some PXA drivers may be shared with SA1100,
> which has also converted to dmaengine although there are no plans to
> ever support DT on sa1100.
> 
> We certainly need to be extra careful if we want to move things over
> at once and cannot test all the drivers. I'd be happier if it could
> be done gradually by having some drivers use the new interface and
> other drivers use the old one, but I don't see how that can be done
> here.

Thanks for detailed explanation. I see there is strong support for the
big change. Lets hope it'll be smooth. I'll strest test Daniel's changes
and report the results.
