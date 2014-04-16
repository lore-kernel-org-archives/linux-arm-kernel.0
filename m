From: oleg@redhat.com (Oleg Nesterov)
Date: Wed, 16 Apr 2014 17:06:46 +0200
Subject: [RFC PATCH v3] ARM: uprobes need icache flush after xol write
In-Reply-To: <1397623112-3211-2-git-send-email-victor.kamensky@linaro.org>
References: <1397623112-3211-1-git-send-email-victor.kamensky@linaro.org>
 <1397623112-3211-2-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140416150646.GB11039@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15, Victor Kamensky wrote:
>
>  arch/arm/include/asm/cacheflush.h |  2 ++
>  arch/arm/kernel/uprobes.c         | 22 ++++++++++++++++++++++
>  arch/arm/mm/flush.c               | 33 ++++++++++++++++++++++++++++-----
>  include/linux/uprobes.h           |  3 +++
>  kernel/events/uprobes.c           | 25 +++++++++++++++++--------

Obviously I can't comment the changes in arm/ ;)

But I'd vote for this patch.



Off-topic, I am just curious... can't someone explain why flush_pfn_alias()
or flush_icache_alias() can't race with itself ? I have no idea what they do,
but what if another thread calls the same function with the same CACHE_COLOUR()
right after set_pte_ext?

Oleg.
