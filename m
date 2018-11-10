From: will.deacon@arm.com (Will Deacon)
Date: Sat, 10 Nov 2018 00:16:16 +0000
Subject: [PATCH] arm64: sysreg: fix sparse warnings
In-Reply-To: <20181109204747.10008-1-geomatsi@gmail.com>
References: <20181109204747.10008-1-geomatsi@gmail.com>
Message-ID: <20181110001615.GA5665@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2018 at 11:47:47PM +0300, Sergey Matyukevich wrote:
> Specify correct type for the constants to avoid
> the following sparse complaints:
> 
> ./arch/arm64/include/asm/sysreg.h:471:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> ./arch/arm64/include/asm/sysreg.h:512:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> 
> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> ---
>  arch/arm64/include/asm/sysreg.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I thought this was fixed in newer versions of sparse so that it treats
AArch64 as 64-bit? [see sparse commit 49d56b6969d2f]

Will
