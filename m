From: a.p.zijlstra@chello.nl (Peter Zijlstra)
Date: Sat, 24 Mar 2012 17:43:27 +0100
Subject: [PATCH 10/10] oom: Make find_lock_task_mm() sparse-aware
In-Reply-To: <20120324162151.GA3640@lizard>
References: <20120324102609.GA28356@lizard> <20120324103127.GJ29067@lizard>
 <1332593574.16159.31.camel@twins> <20120324162151.GA3640@lizard>
Message-ID: <1332607407.16159.51.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2012-03-24 at 20:21 +0400, Anton Vorontsov wrote:

> Just wonder how do you see the feature implemented?
> 
> Something like this?
> 
> #define __ret_cond_locked(l, c)	__attribute__((ret_cond_locked(l, c)))
> #define __ret_value		__attribute__((ret_value))
> #define __ret_locked_nonnull(l)	__ret_cond_locked(l, __ret_value);
> 
> extern struct task_struct *find_lock_task_mm(struct task_struct *p)
> 	__ret_locked_nonnull(&__ret_value->alloc_lock);

Yeah, see the email I just CC'ed you on to linux-sparse.

Basically extend __attribute__((context())) to allow things similar to
what you proposed.
