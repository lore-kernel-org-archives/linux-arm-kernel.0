From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Fri, 6 Oct 2017 10:30:10 -0500
Subject: [PATCH v3] irqchip/gicv3: Add support for Range Selector (RS)
 feature
In-Reply-To: <CAOZdJXXp6Vm7rZNP4eH8UKpHqqrCQnqt257X3VZPnC7sG4VQGg@mail.gmail.com>
References: <1507247949-21620-1-git-send-email-shankerd@codeaurora.org>
 <CAOZdJXXp6Vm7rZNP4eH8UKpHqqrCQnqt257X3VZPnC7sG4VQGg@mail.gmail.com>
Message-ID: <010801d33eb8$00a7ae10$01f70a30$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I posted v4 patch https://patchwork.kernel.org/patch/9989667/ with parentheses around a macro parameter. 

-----Original Message-----
From: Timur Tabi [mailto:timur at codeaurora.org] 
Sent: Friday, October 6, 2017 9:26 AM
To: Shanker Donthineni <shankerd@codeaurora.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>; linux-kernel <linux-kernel@vger.kernel.org>; linux-arm-kernel <linux-arm-kernel@lists.infradead.org>; Thomas Gleixner <tglx@linutronix.de>; Jason Cooper <jason@lakedaemon.net>; Vikram Sethi <vikrams@codeaurora.org>
Subject: Re: [PATCH v3] irqchip/gicv3: Add support for Range Selector (RS) feature

On Thu, Oct 5, 2017 at 6:59 PM, Shanker Donthineni <shankerd@codeaurora.org> wrote:
> +#define MPIDR_TO_SGI_CLUSTER_ID(mpidr) (mpidr & ~0xFUL)

This should be "((mpidr) & 0xFUL)", just to be safe.
