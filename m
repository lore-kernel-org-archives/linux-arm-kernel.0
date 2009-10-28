From: jpihet@mvista.com (Jean Pihet)
Date: Wed, 28 Oct 2009 17:23:01 +0100
Subject: [PATCH] check put_user fail in do_signal when enable OABI_COMPACT
In-Reply-To: <alpine.LFD.2.00.0910281209240.10545@xanadu.home>
References: <1256123277.3851.36.camel@debian-nb>
	<200910281116.32052.jpihet@mvista.com>
	<alpine.LFD.2.00.0910281209240.10545@xanadu.home>
Message-ID: <200910281723.01684.jpihet@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 October 2009 17:13:28 Nicolas Pitre wrote:
> On Wed, 28 Oct 2009, Jean Pihet wrote:
> > On Tuesday 27 October 2009 20:35:31 Nicolas Pitre wrote:
> > > Well, the commit message is certainly wrong. There is no copying of
> > > restart_syscall to user stack anymore.
> >
> > Ok thanks for reviewing it! Here is a respin of the patch. Only the
> > commit description has been touched.
>
> [...]
>
> > Using OABI, the call to put_user in do_signal can fail. In that case
> > flush_icache page faults and the calling app goes in an infinite loop.
>
> Still wrong.  Why flush_icache?
Indeed that is wrong (again!). I had put it in the problem description but 
that does not apply anymore.

Thanks, will send an update.
>
>
> Nicolas

Jean

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
