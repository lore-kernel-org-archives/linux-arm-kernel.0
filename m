From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 20 Dec 2012 22:14:26 +0100
Subject: [PATCH] ARM: dts: fix split memory bank for SSDK5440
In-Reply-To: <CAOesGMg03Yn=fDr1XqmbBUs=eZO0_8=iti1LUiJ6CX5n1Bm45g@mail.gmail.com>
References: <1356030217-5472-1-git-send-email-kgene.kim@samsung.com>
 <CAOesGMg03Yn=fDr1XqmbBUs=eZO0_8=iti1LUiJ6CX5n1Bm45g@mail.gmail.com>
Message-ID: <1464138.NEt7mMkYJc@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Thursday 20 of December 2012 11:56:59 Olof Johansson wrote:
> Hi,
> 
> On Thu, Dec 20, 2012 at 11:03 AM, Kukjin Kim <kgene.kim@samsung.com> 
wrote:
> > The size of memory bank should be under 256MB, because current
> > section size is 256MB on EXYNOS SoCs. This patch fixes it.
> 
> This makes no sense. You don't have to split up memory ranges, the
> code should be made to handle it instead.

It's not Exynos code which causes the problem. Sparsemem initialization 
relies on the fact that initial amount of structures to described memory 
equals to maximum section size which is defined per arch (e.g. 
ARCH_EXYNOS).

> What's the actual bug caused by this? The description is vague.

The kernel panics early on NULL pointer dereference in memory 
initialization.

Best regards,
Tomasz Figa
