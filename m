From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Wed, 21 Oct 2015 21:16:31 +0900
Subject: [PATCH v2 1/2] arm64: revamp unwind_frame for interrupt stack
In-Reply-To: <B71E493E-1AAC-4BEF-93CF-2039FE5629B4@gmail.com>
References: <1445328019-23330-1-git-send-email-takahiro.akashi@linaro.org>
 <1445328019-23330-2-git-send-email-takahiro.akashi@linaro.org>
 <C2B4628F-F984-416C-A358-7FDE8DCD553F@gmail.com>
 <562732FC.7010306@linaro.org>
 <B71E493E-1AAC-4BEF-93CF-2039FE5629B4@gmail.com>
Message-ID: <DC09270D-6A7A-4FE3-A99C-CE84F1F64697@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Oct 21, 2015, at 9:14 PM, Jungseok Lee wrote:

Whoops!

> [Only Akashi and James]
> 
> On Oct 21, 2015, at 3:38 PM, AKASHI Takahiro wrote:
> 
> Hi Akashi and James,
> 
> Am I the only person who have experienced kernel panic with this series?
> I have observed NULL pointer kernel panic with the following two ways.
> 
> - $ sudo echo c > /proc/sysrq-trigger
> - perf record -e mem:[address of do_softirq]:x -ag -- sleep 2
> 
> The kernel panic is triggered when the last stack frame of swapper is unwound.
> At that time, the value of fp, low, high is 0, 0, 0, respectively.
> 
> My tree includes "Synchronise dump_backtrace() with perf call chain" patch
> which is queued into for-next/core.
> 
> Best Regards
> Jungseok Lee

Really sorry for the noise.. It won't happen again..

Best Regards
Jungseok Lee
