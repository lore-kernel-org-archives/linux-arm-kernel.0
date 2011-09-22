From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 22 Sep 2011 12:57:13 +0100
Subject: [PATCH] arm: Add unwinding annotations for 64bit division
	functions
In-Reply-To: <1316689606.2053.29.camel@linaro1>
References: <1316470297-5063-1-git-send-email-lauraa@codeaurora.org>
	<alpine.LFD.2.00.1109191913210.12663@xanadu.home>
	<2285dff3fee56758b6279062a5a30dc7.squirrel@www.codeaurora.org>
	<20110921113906.GB2872@arm.com>
	<20110921115553.GF17169@n2100.arm.linux.org.uk>
	<1316676488.2053.9.camel@linaro1>
	<CAHkRjk7B4Bmt2g6ptHO3TudXgrkr5rv4b--Hbx-mw7=MO9Q+BQ@mail.gmail.com>
	<1316689606.2053.29.camel@linaro1>
Message-ID: <20110922115713.GJ12025@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 12:06:46PM +0100, Jon Medhurst (Tixy) wrote:
> On Thu, 2011-09-22 at 10:48 +0100, Catalin Marinas wrote:
> > We could improve things a bit in the unwinder and assume
> > that if the fault address is the same as the .fnstart address, the
> > return value is always in LR and the SP not affected (that's unwinding
> > bytecode 0xb0). For a few instructions into the function prologue we
> > can't reliably get the unwinding information.
> 
> That would help make it possible to unwind out of kprobes handlers to
> the probed function. The kprobes code itself would need work as well,
> and possibly the undef handler. Do we think it is worthwhile to do
> this? 

Does kprobes need to trace beyond the probed function? If not, you get
the address of the probed function via pt_regs anyway, so no need for
unwinding beyond that.

-- 
Catalin
