From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 21 Jun 2016 11:32:17 +0100
Subject: [PATCH] arm64: add boot image dependencies to not generate
 invalid images
In-Reply-To: <1466473440-18887-1-git-send-email-yamada.masahiro@socionext.com>
References: <1466473440-18887-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160621103217.GA14542@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 10:44:00AM +0900, Masahiro Yamada wrote:
> I fixed boot image dependencies for arch/arm in commit 3939f3345050
> ("ARM: 8418/1: add boot image dependencies to not generate invalid
> images").
> 
> I see a similar problem for arch/arm64; "make -jN Image Image.gz"
> would sometimes end up generating bad images where N > 1.
> 
> Fix the dependency in arch/arm64/Makefile to avoid the race
> between "make Image" and "make Image.*".
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Will, could you please pick this up for 4.7? Maybe with a cc stable.
Thanks.

-- 
Catalin
