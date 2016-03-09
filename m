From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 9 Mar 2016 15:30:05 +0800
Subject: [Query]set clk rate must operate its coordinated clock
In-Reply-To: <20160309152420.20de187a@xhacker>
References: <20160309152420.20de187a@xhacker>
Message-ID: <20160309153005.7f7c022f@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

make it more clear below.

On Wed, 9 Mar 2016 15:24:20 +0800 Jisheng Zhang wrote:

> Dear Stephen, Michael, Sebastian and all, 
> 
> I have the following clk case which I dunno the elegant solution:
> 
> 
> cpuclk have two parents: cpupll and refclk. When set the cpuclk freq, we
> have to set its parent's freq, I.E cpupll freq. But before changing the
> cpupll's freq, we should set its refclk as its parent firstly.

before changing cpupll's freq, we should set the refclk as cpuclk's parent firstly.

> 
> AFAIK, this is a common case, I have seen such requirement in rockchip, samsung
> clk driver. They solve this by notifier, but as pointed out by Michael
> in http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/351565.html
> 
> "This is also a hack and it points towards some missing infrastructure in the
> clock framework."
> 
> I also don't like the notifier solution, I believe the elegant solution could
> be using the coordinated clock infrastructure. So what's the status of
> this infrastructure? I can test, and I can even add some code to make it be
> ready to be merged if you guide me ;)
> 
> Thanks in advance,
> Jisheng
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
