Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0EEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:58:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2975B218D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V0BcvvbO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2975B218D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IqxxYf+9QG82v+Lh7YTnMVVN0fFQjF+b66Wm2qJ3AXE=; b=V0BcvvbOQQxDl8kN0OdhA0w+n
	ypwFZjfx8ZjQ9PROyqDLz0elEOAv3YLgMueH9VFZ5itRyPjBYS8RbxS0xUKogQ5X6IEbV3FHUOVZD
	KfcQUAWoacguo6VdxKcZa9OmsfEfsJST31HGkmV36qciNv/r9ie4DCTDXeJgXNsgq72ee36ZbYWOj
	W9JeMyYltscfAEvxkgxfD9qtEvkojCQ6ktpH6B9sTctNelcw97n0D3PH6qGrH43vi5fx64T92FfwZ
	dEzywjHjz97e14QJE6CI0UpG0UcmVE6IdUthuDdOxYxoHu3yByzMy+msQ5j1irxF4x2D3CQrORkoT
	6lCGY6XhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAER-0001AL-Hg; Mon, 11 Feb 2019 11:58:39 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAEO-0001A8-Al; Mon, 11 Feb 2019 11:58:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 0822F20D0BED5; Mon, 11 Feb 2019 12:58:34 +0100 (CET)
Date: Mon, 11 Feb 2019 12:58:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/rwsem: Remove arch specific rwsem files
Message-ID: <20190211115833.GY32511@hirez.programming.kicks-ass.net>
References: <1549850450-10171-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dFWYt1i2NyOo1oI9"
Content-Disposition: inline
In-Reply-To: <1549850450-10171-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--dFWYt1i2NyOo1oI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 10, 2019 at 09:00:50PM -0500, Waiman Long wrote:

> +static inline int __down_read_trylock(struct rw_semaphore *sem)
> +{
> +	long tmp;
> +
> +	while ((tmp = atomic_long_read(&sem->count)) >= 0) {
> +		if (tmp == atomic_long_cmpxchg_acquire(&sem->count, tmp,
> +				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
> +			return 1;
> +		}
> +	}
> +	return 0;
> +}

So the orignal x86 implementation reads:

  static inline bool __down_read_trylock(struct rw_semaphore *sem)
  {
	  long result, tmp;
	  asm volatile("# beginning __down_read_trylock\n\t"
		       "  mov          %[count],%[result]\n\t"
		       "1:\n\t"
		       "  mov          %[result],%[tmp]\n\t"
		       "  add          %[inc],%[tmp]\n\t"
		       "  jle	     2f\n\t"
		       LOCK_PREFIX "  cmpxchg  %[tmp],%[count]\n\t"
		       "  jnz	     1b\n\t"
		       "2:\n\t"
		       "# ending __down_read_trylock\n\t"
		       : [count] "+m" (sem->count), [result] "=&a" (result),
			 [tmp] "=&r" (tmp)
		       : [inc] "i" (RWSEM_ACTIVE_READ_BIAS)
		       : "memory", "cc");
	  return result >= 0;
  }

you replace that with:

  int __down_read_trylock1(unsigned long *l)
  {
	  long tmp;

	  while ((tmp = READ_ONCE(*l)) >= 0) {
		  if (tmp == cmpxchg(l, tmp, tmp + 1))
			  return 1;
	  }

	  return 0;
  }

which generates:

  0000000000000000 <__down_read_trylock1>:
   0:   eb 17                   jmp    19 <__down_read_trylock1+0x19>
   2:   66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)
   8:   48 8d 4a 01             lea    0x1(%rdx),%rcx
   c:   48 89 d0                mov    %rdx,%rax
   f:   f0 48 0f b1 0f          lock cmpxchg %rcx,(%rdi)
  14:   48 39 c2                cmp    %rax,%rdx
  17:   74 0f                   je     28 <__down_read_trylock1+0x28>
  19:   48 8b 17                mov    (%rdi),%rdx
  1c:   48 85 d2                test   %rdx,%rdx
  1f:   79 e7                   jns    8 <__down_read_trylock1+0x8>
  21:   31 c0                   xor    %eax,%eax
  23:   c3                      retq
  24:   0f 1f 40 00             nopl   0x0(%rax)
  28:   b8 01 00 00 00          mov    $0x1,%eax
  2d:   c3                      retq


Which is clearly worse. Now we can write that as:

  int __down_read_trylock2(unsigned long *l)
  {
	  long tmp = READ_ONCE(*l);

	  while (tmp >= 0) {
		  if (try_cmpxchg(l, &tmp, tmp + 1))
			  return 1;
	  }

	  return 0;
  }

which generates:

  0000000000000030 <__down_read_trylock2>:
  30:   48 8b 07                mov    (%rdi),%rax
  33:   48 85 c0                test   %rax,%rax
  36:   78 18                   js     50 <__down_read_trylock2+0x20>
  38:   48 8d 50 01             lea    0x1(%rax),%rdx
  3c:   f0 48 0f b1 17          lock cmpxchg %rdx,(%rdi)
  41:   75 f0                   jne    33 <__down_read_trylock2+0x3>
  43:   b8 01 00 00 00          mov    $0x1,%eax
  48:   c3                      retq
  49:   0f 1f 80 00 00 00 00    nopl   0x0(%rax)
  50:   31 c0                   xor    %eax,%eax
  52:   c3                      retq

Which is a lot better; but not quite there yet.


I've tried quite a bit, but I can't seem to get GCC to generate the:

	add $1,%rdx
	jle

required; stuff like:

	new = old + 1;
	if (new <= 0)

generates:

	lea 0x1(%rax),%rdx
	test %rdx, %rdx
	jle


Ah well, have fun :-)

--dFWYt1i2NyOo1oI9
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="dtl.c"


typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;
typedef unsigned long long u64;
typedef signed char s8;
typedef signed short s16;
typedef signed int s32;
typedef signed long long s64;
typedef _Bool bool;

# define CC_SET(c) "\n\t/* output condition code " #c "*/\n"
# define CC_OUT(c) "=@cc" #c

#define likely(x)     __builtin_expect(!!(x), 1)
#define unlikely(x)   __builtin_expect(!!(x), 0)

extern void __cmpxchg_wrong_size(void);

#define __raw_cmpxchg(ptr, old, new, size, lock)			\
({									\
	__typeof__(*(ptr)) __ret;					\
	__typeof__(*(ptr)) __old = (old);				\
	__typeof__(*(ptr)) __new = (new);				\
	switch (size) {							\
	case 1:						\
	{								\
		volatile u8 *__ptr = (volatile u8 *)(ptr);		\
		asm volatile(lock "cmpxchgb %2,%1"			\
			     : "=a" (__ret), "+m" (*__ptr)		\
			     : "q" (__new), "0" (__old)			\
			     : "memory");				\
		break;							\
	}								\
	case 2:						\
	{								\
		volatile u16 *__ptr = (volatile u16 *)(ptr);		\
		asm volatile(lock "cmpxchgw %2,%1"			\
			     : "=a" (__ret), "+m" (*__ptr)		\
			     : "r" (__new), "0" (__old)			\
			     : "memory");				\
		break;							\
	}								\
	case 4:						\
	{								\
		volatile u32 *__ptr = (volatile u32 *)(ptr);		\
		asm volatile(lock "cmpxchgl %2,%1"			\
			     : "=a" (__ret), "+m" (*__ptr)		\
			     : "r" (__new), "0" (__old)			\
			     : "memory");				\
		break;							\
	}								\
	case 8:						\
	{								\
		volatile u64 *__ptr = (volatile u64 *)(ptr);		\
		asm volatile(lock "cmpxchgq %2,%1"			\
			     : "=a" (__ret), "+m" (*__ptr)		\
			     : "r" (__new), "0" (__old)			\
			     : "memory");				\
		break;							\
	}								\
	default:							\
		__cmpxchg_wrong_size();					\
	}								\
	__ret;								\
})

#define __cmpxchg(ptr, old, new, size)					\
	__raw_cmpxchg((ptr), (old), (new), (size), LOCK_PREFIX)

#define cmpxchg(ptr, old, new)						\
	__cmpxchg(ptr, old, new, sizeof(*(ptr)))

#define __raw_try_cmpxchg(_ptr, _pold, _new, size, lock)		\
({									\
	bool success;							\
	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
	__typeof__(*(_ptr)) __old = *_old;				\
	__typeof__(*(_ptr)) __new = (_new);				\
	switch (size) {							\
	case 1:						\
	{								\
		volatile u8 *__ptr = (volatile u8 *)(_ptr);		\
		asm volatile(lock "cmpxchgb %[new], %[ptr]"		\
			     CC_SET(z)					\
			     : CC_OUT(z) (success),			\
			       [ptr] "+m" (*__ptr),			\
			       [old] "+a" (__old)			\
			     : [new] "q" (__new)			\
			     : "memory");				\
		break;							\
	}								\
	case 2:						\
	{								\
		volatile u16 *__ptr = (volatile u16 *)(_ptr);		\
		asm volatile(lock "cmpxchgw %[new], %[ptr]"		\
			     CC_SET(z)					\
			     : CC_OUT(z) (success),			\
			       [ptr] "+m" (*__ptr),			\
			       [old] "+a" (__old)			\
			     : [new] "r" (__new)			\
			     : "memory");				\
		break;							\
	}								\
	case 4:						\
	{								\
		volatile u32 *__ptr = (volatile u32 *)(_ptr);		\
		asm volatile(lock "cmpxchgl %[new], %[ptr]"		\
			     CC_SET(z)					\
			     : CC_OUT(z) (success),			\
			       [ptr] "+m" (*__ptr),			\
			       [old] "+a" (__old)			\
			     : [new] "r" (__new)			\
			     : "memory");				\
		break;							\
	}								\
	case 8:						\
	{								\
		volatile u64 *__ptr = (volatile u64 *)(_ptr);		\
		asm volatile(lock "cmpxchgq %[new], %[ptr]"		\
			     CC_SET(z)					\
			     : CC_OUT(z) (success),			\
			       [ptr] "+m" (*__ptr),			\
			       [old] "+a" (__old)			\
			     : [new] "r" (__new)			\
			     : "memory");				\
		break;							\
	}								\
	default:							\
		__cmpxchg_wrong_size();					\
	}								\
	if (unlikely(!success))						\
		*_old = __old;						\
	likely(success);						\
})

#define LOCK_PREFIX "lock; "

#define __try_cmpxchg(ptr, pold, new, size)				\
	__raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)

#define try_cmpxchg(ptr, pold, new)					\
	__try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))

#define READ_ONCE(x) (*(volatile typeof(x) *)(&x))

int __down_read_trylock1(unsigned long *l)
{
	long tmp;

	while ((tmp = READ_ONCE(*l)) >= 0) {
		if (tmp == cmpxchg(l, tmp, tmp + 1))
			return 1;
	}

	return 0;
}

int __down_read_trylock2(unsigned long *l)
{
	long tmp = READ_ONCE(*l);

	while (tmp >= 0) {
		if (try_cmpxchg(l, &tmp, tmp + 1))
			return 1;
	}

	return 0;
}

int __down_read_trylock3(unsigned long *l)
{
	long new, old = READ_ONCE(*l);

	for (;;) {
		new = old + 1;
		if (new <= 0)
			return 0;
		if (try_cmpxchg(l, &old, new))
			return 1;
	}
}


--dFWYt1i2NyOo1oI9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--dFWYt1i2NyOo1oI9--

