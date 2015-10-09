From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 Oct 2015 10:41:43 +0200
Subject: [PATCHv2] ARM64:Fix MINSIGSTKSZ and SIGSTKSZ
In-Reply-To: <5340366.WTVksOGb0G@wuerfel>
References: <1444109743-8561-1-git-send-email-manjeet.p@samsung.com>
 <20151006103128.GN6281@e103592.cambridge.arm.com>
 <5340366.WTVksOGb0G@wuerfel>
Message-ID: <5223992.qv9q1k7gFp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 October 2015 12:51:24 Arnd Bergmann wrote:
> 
> I think it makes sense to stick with the traditional definition
> of MINSIGSTKSZ == "the minimum amount that you will always need,
> add whatever you require yourself" and SIGSTKSZ == "Should be
> enough for a couple of function calls". If we want to be conservative
> in the kernel, using 8192 and 32768, to stay with the x4 ratio
> that everyone else uses would be my first pick, though I'm not
> particularly attached to those values.
> 
> 

On second thought, it really seems to late to make up our minds
about the size now that glibc has already established 5KB as the
minimum size. If we set it to 8KB/32KB, not just the testcase but
real applications would start failing when they use the 5KB
constant from glibc.

	Arnd
