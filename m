From: richard@nod.at (Richard Weinberger)
Date: Sat, 24 Mar 2012 12:12:40 +0100
Subject: [PATCH 07/10] um: Should hold tasklist_lock while traversing
 processes
In-Reply-To: <20120324103030.GG29067@lizard>
References: <20120324102609.GA28356@lizard> <20120324103030.GG29067@lizard>
Message-ID: <4F6DAC28.301@nod.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 24.03.2012 11:30, schrieb Anton Vorontsov:
> Traversing the tasks requires holding tasklist_lock, otherwise it
> is unsafe.
> 
> p.s. However, I'm not sure that calling os_kill_ptraced_process()
> in the atomic context is correct. It seem to work, but please
> take a closer look.

os_kill_ptraced_process() calls a host function.
>From UML's point of view nothing sleeps, so this is fine.

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120324/26ece3a9/attachment-0001.sig>
