From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 7 Jul 2016 08:37:10 +0300
Subject: [PATCH 1/9] mm: Hardened usercopy
In-Reply-To: <1467843928-29351-2-git-send-email-keescook@chromium.org>
References: <1467843928-29351-1-git-send-email-keescook@chromium.org>
 <1467843928-29351-2-git-send-email-keescook@chromium.org>
Message-ID: <20160707053710.GH2118@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kees,

On Wed, Jul 06, 2016 at 03:25:20PM -0700, Kees Cook wrote:
> +#ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR

Should be CONFIG_HARDENED_USERCOPY to match the slab/slub implementation 
condition.

> +const char *__check_heap_object(const void *ptr, unsigned long n,
> +				struct page *page);
> +#else
> +static inline const char *__check_heap_object(const void *ptr,
> +					      unsigned long n,
> +					      struct page *page)
> +{
> +	return NULL;
> +}
> +#endif

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
