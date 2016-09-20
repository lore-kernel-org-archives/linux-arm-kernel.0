From: will.deacon@arm.com (Will Deacon)
Date: Tue, 20 Sep 2016 09:33:52 +0100
Subject: [RFC] Arm64 boot fail with numa enable in BIOS
In-Reply-To: <cd53a1ae-e4ff-933c-4d1c-1ddaaa999a43@huawei.com>
References: <7618d76d-bfa8-d8aa-59aa-06f9d90c1a98@huawei.com>
 <20160919140709.GA17464@leverpostej>
 <cd53a1ae-e4ff-933c-4d1c-1ddaaa999a43@huawei.com>
Message-ID: <20160920083352.GA25614@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yisheng,

On Tue, Sep 20, 2016 at 11:29:24AM +0800, Yisheng Xie wrote:
> On 2016/9/19 22:07, Mark Rutland wrote:
> > On Mon, Sep 19, 2016 at 09:05:26PM +0800, Yisheng Xie wrote:
> > Can you modify the warning in cpumask.h to dump the bad CPU number? That
> > would make it fairly clear if that's the case.
> > 
> hi Mark,
> I dump the bad CPU number, it is 64,
> And the cpumask get from task is 00000000,00000000.
> 
> [    3.873044] select_task_rq: allowed 0, allow_cpumask 00000000,00000000
> [    3.879727] cpumask_check: cpu 64, nr_cpumask_bits:64, nr_cpu_ids= 64
> [    3.895989] ------------[ cut here ]------------
> [    3.900652] WARNING: CPU: 16 PID: 103 at ./include/linux/cpumask.h:122 try_to_wake_up+0x410/0x4ac

Can you look at this patch from David, please:

http://lists.infradead.org/pipermail/linux-arm-kernel/2016-September/458110.html

and offer a Tested-by if it fixes your problem?

Thanks,

Will
