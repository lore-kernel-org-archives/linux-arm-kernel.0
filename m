From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 19 May 2010 16:50:53 +0800
Subject: Boot interface for device trees on ARM
In-Reply-To: <alpine.LFD.2.00.1005180802010.12758@xanadu.home>
References: <201005181054.32325.jeremy.kerr@canonical.com>
	<20100518084954.GC25892@yookeroo>
	<alpine.LFD.2.00.1005180802010.12758@xanadu.home>
Message-ID: <201005191650.55978.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas,

> Exact.  For example, on ARM the machine ID is also used to figure out
> the MMU mapping needed to be able to simply be able to debug the very
> early assembly boot stage when there isn't even a stack available.

I get the impression that this is the only thing that we need the io_pg_offset 
for - setting up the debug page mapping, for very early printk output.

If this is the case, I would much rather have it as a compile-time constant 
when doing this early debug; this is what I have been doing for DT boot in my 
tree (however, I would like to move it to something more configurable).

In the cases where we need to debug the pre-C stuff (ie, machine bringup), I 
think we can live with a compile-time constant, rather than having to define a 
special 'exception' in the DT boot interface to handle this.

Or is there another early use of the mdesc that I'm not aware of?

Cheers,


Jeremy
