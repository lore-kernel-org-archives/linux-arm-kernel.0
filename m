From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 9 Apr 2018 10:57:57 -0700
Subject: [PATCH 2/3] mm: replace __HAVE_ARCH_PTE_SPECIAL
In-Reply-To: <1523282229-20731-3-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1523282229-20731-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1523282229-20731-3-git-send-email-ldufour@linux.vnet.ibm.com>
Message-ID: <20180409175757.GA12938@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -#ifdef __HAVE_ARCH_PTE_SPECIAL
> +#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
>  # define HAVE_PTE_SPECIAL 1
>  #else
>  # define HAVE_PTE_SPECIAL 0

I'd say kill this odd indirection and just use the
CONFIG_ARCH_HAS_PTE_SPECIAL symbol directly.
