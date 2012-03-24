From: richard@nod.at (Richard Weinberger)
Date: Sat, 24 Mar 2012 12:12:21 +0100
Subject: [PATCH 09/10] um: Properly check all process' threads for a live
 mm
In-Reply-To: <20120324103110.GI29067@lizard>
References: <20120324102609.GA28356@lizard> <20120324103110.GI29067@lizard>
Message-ID: <4F6DAC15.7040702@nod.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 24.03.2012 11:31, schrieb Anton Vorontsov:
> kill_off_processes() might miss a valid process, this is because
> checking for process->mm is not enough. Process' main thread may
> exit or detach its mm via use_mm(), but other threads may still
> have a valid mm.
> 
> To catch this we use find_lock_task_mm(), which walks up all
> threads and returns an appropriate task (with task lock held).
> 
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120324/f96bc1b5/attachment.sig>
