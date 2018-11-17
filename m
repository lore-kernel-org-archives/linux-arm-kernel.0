From: will.deacon@arm.com (Will Deacon)
Date: Sat, 17 Nov 2018 02:26:57 +0000
Subject: [PATCH] arm64: Explicitly mark 64-bit constant as unsigned long
In-Reply-To: <20181117015456.101222-1-olof@lixom.net>
References: <20181117015456.101222-1-olof@lixom.net>
Message-ID: <20181117022656.GB2470@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Fri, Nov 16, 2018 at 05:54:56PM -0800, Olof Johansson wrote:
> Makes sparse happy. Before:
> 
> arch/arm64/include/asm/sysreg.h:471:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> arch/arm64/include/asm/sysreg.h:512:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  arch/arm64/include/asm/sysreg.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

The warning is bogus imo, but since it's harmless to fix it then we can do
that. However, you've been beaten by:

http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/613179.html

Will
