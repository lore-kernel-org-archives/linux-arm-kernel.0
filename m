From: oleg@redhat.com (Oleg Nesterov)
Date: Sun, 27 Apr 2014 14:21:51 +0200
Subject: [PATCH v5] ARM: uprobes need icache flush after xol write
In-Reply-To: <1398494096-11311-2-git-send-email-victor.kamensky@linaro.org>
References: <1398494096-11311-1-git-send-email-victor.kamensky@linaro.org>
 <1398494096-11311-2-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140427122151.GA19545@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25, Victor Kamensky wrote:
>
> Note ARM cache flush function need kernel address
> through which instruction write happened, so instead
> of using uprobes copy_to_page function changed
> code to explicitly map page and do memcpy.

Again, I can't review the changes in arm/, although I think there are
correct.

But personally I agree with this patch, we need something for v3.15,
and unless Russell objects I'd vote for this change.

FWIW,

Acked-by: Oleg Nesterov <oleg@redhat.com>
