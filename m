From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 23 Aug 2013 13:38:02 +0300
Subject: [PATCH v3 1/3] ARM: Introduce atomic MMIO modify
In-Reply-To: <1377253445-2842-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377253445-2842-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377253445-2842-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130823103802.GO4600@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Ezequiel,

On Fri, Aug 23, 2013 at 07:24:03AM -0300, Ezequiel Garcia wrote:
> Some SoC have MMIO regions that are shared across orthogonal
> subsystems. This commit implements a possible solution for the
> thread-safe access of such regions through a spinlock-protected API.
> 
> Concurrent access is protected with a single spinlock for the
> entire MMIO address space. While this protects shared-registers,
> it also serializes access to unrelated/unshared registers.
> 
> We add relaxed and non-relaxed variants, by using writel_relaxed and writel,
> respectively. The rationale for this is that some users may not require
> register write completion but only thread-safe access to a register.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Is there a reason why this should be limited to ARM? I haven't found anything 
ARM specific in the code.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
