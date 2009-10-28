From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 28 Oct 2009 12:13:28 -0400 (EDT)
Subject: [PATCH] check put_user fail in do_signal when enable OABI_COMPACT
In-Reply-To: <200910281116.32052.jpihet@mvista.com>
References: <1256123277.3851.36.camel@debian-nb>
	<200910272012.53488.jpihet@mvista.com>
	<alpine.LFD.2.00.0910271533060.10545@xanadu.home>
	<200910281116.32052.jpihet@mvista.com>
Message-ID: <alpine.LFD.2.00.0910281209240.10545@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Oct 2009, Jean Pihet wrote:

> On Tuesday 27 October 2009 20:35:31 Nicolas Pitre wrote:
> > Well, the commit message is certainly wrong. There is no copying of
> > restart_syscall to user stack anymore.
> Ok thanks for reviewing it! Here is a respin of the patch. Only the commit 
> description has been touched.
[...]
> Using OABI, the call to put_user in do_signal can fail. In that case
> flush_icache page faults and the calling app goes in an infinite loop.

Still wrong.  Why flush_icache?


Nicolas
