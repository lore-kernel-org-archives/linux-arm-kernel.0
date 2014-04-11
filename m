From: oleg@redhat.com (Oleg Nesterov)
Date: Fri, 11 Apr 2014 15:08:49 +0200
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <5347655B.3080307@linaro.org>
References: <1397023132-10313-1-git-send-email-victor.kamensky@linaro.org>
 <1397023132-10313-2-git-send-email-victor.kamensky@linaro.org>
 <20140409184507.GA1058@redhat.com>
 <CAA3XUr3w_9318mT2_9+J-nf3wDv5bic+v0H4nVfsYof7wWZs9Q@mail.gmail.com>
 <5347655B.3080307@linaro.org>
Message-ID: <20140411130849.GA22807@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10, David Long wrote:
>
>  static void copy_to_page(struct page *page, unsigned long vaddr, const void *src, int len)
>  {
>  	void *kaddr = kmap_atomic(page);
> -	memcpy(kaddr + (vaddr & ~PAGE_MASK), src, len);
> +	copy_to_user_page(NULL, page, vaddr, kaddr + (vaddr & ~PAGE_MASK), src, len);

No, no, this is not what we want... And I do not think we should change
copy_to_user_page().

I'll write another email...

Oleg.
