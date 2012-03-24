From: richard@nod.at (Richard Weinberger)
Date: Sat, 24 Mar 2012 12:12:12 +0100
Subject: [PATCH 08/10] um: Fix possible race on task->mm
In-Reply-To: <20120324103050.GH29067@lizard>
References: <20120324102609.GA28356@lizard> <20120324103050.GH29067@lizard>
Message-ID: <4F6DAC0C.4010203@nod.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 24.03.2012 11:30, schrieb Anton Vorontsov:
> Checking for task->mm is dangerous as ->mm might disappear (exit_mm()
> assigns NULL under task_lock(), so tasklist lock is not enough).
> 
> We can't use get_task_mm()/mmput() pair as mmput() might sleep,
> so let's take the task lock while we care about its mm.
> 
> Note that we should also use find_lock_task_mm() to check all process'
> threads for a valid mm, but for uml we'll do it in a separate patch.
> 
> Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120324/5e8448fb/attachment.sig>
