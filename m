From: hillf.zj@alibaba-inc.com (Hillf Danton)
Date: Tue, 15 Sep 2015 16:20:30 +0800
Subject: [PATCH] arm: Fix backtrace generation when IPI is masked
In-Reply-To: <55F7D291.5090509@linaro.org>
References: <016701d0ef82$c303d6a0$490b83e0$@alibaba-inc.com>
 <017001d0ef83$e18a5d00$a49f1700$@alibaba-inc.com>
 <55F7D291.5090509@linaro.org>
Message-ID: <018c01d0ef8f$62c8c130$285a4390$@alibaba-inc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Better if dump_stack() is added in a separate patch, given that
> > it is not mentioned in commit message.
> 
> Adding dump_stack() is mentioned in passing ("Some small changes to the
> generic code are required to support this.") but you're right that the
> reason for the change is not explicitly called out.
> 
> I can certainly respin as two patches but perhaps its better just to
> improve the commit message. Something like:
> 
>  > This can be fixed by detecting that the calling context cannot be
>  > preempted and issuing the backtrace directly in this case. Issuing
>  > directly leaves us without any pt_regs to pass to nmi_cpu_backtrace().
>  > Modify the generic code to call dump_stack() when its argument is
>  > NULL.
> 
Looks nice!

thanks
Hillf
