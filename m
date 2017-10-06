From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 6 Oct 2017 09:25:54 -0500
Subject: [PATCH v3] irqchip/gicv3: Add support for Range Selector (RS)
 feature
In-Reply-To: <1507247949-21620-1-git-send-email-shankerd@codeaurora.org>
References: <1507247949-21620-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <CAOZdJXXp6Vm7rZNP4eH8UKpHqqrCQnqt257X3VZPnC7sG4VQGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 5, 2017 at 6:59 PM, Shanker Donthineni
<shankerd@codeaurora.org> wrote:
> +#define MPIDR_TO_SGI_CLUSTER_ID(mpidr) (mpidr & ~0xFUL)

This should be "((mpidr) & 0xFUL)", just to be safe.
