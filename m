From: davem@davemloft.net (David Miller)
Date: Wed, 16 Apr 2014 11:10:28 -0400 (EDT)
Subject: [RFC PATCH v3] ARM: uprobes need icache flush after xol write
In-Reply-To: <20140416150646.GB11039@redhat.com>
References: <1397623112-3211-1-git-send-email-victor.kamensky@linaro.org>
 <1397623112-3211-2-git-send-email-victor.kamensky@linaro.org>
 <20140416150646.GB11039@redhat.com>
Message-ID: <20140416.111028.831710940640195974.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oleg Nesterov <oleg@redhat.com>
Date: Wed, 16 Apr 2014 17:06:46 +0200

> Off-topic, I am just curious... can't someone explain why flush_pfn_alias()
> or flush_icache_alias() can't race with itself ? I have no idea what they do,
> but what if another thread calls the same function with the same CACHE_COLOUR()
> right after set_pte_ext?

PTE modifications are supposed to run with the page table lock held.
