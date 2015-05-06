From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 6 May 2015 16:56:28 +0800
Subject: not syncing: Attempted to kill init! exitcode=0x00000004 ?
In-Reply-To: <20150505115446.GA26467@dragon>
References: <CAK7LNATT8cJoQh+7ZEyUXgMtL0OSYg+69t8wcuNSk+SN+Rwf2g@mail.gmail.com>
 <20150505115446.GA26467@dragon>
Message-ID: <CAAQ0ZWRyndnoSs5D+AcOZB-7hSnhSULTYVu=TRtcGR-CfB9xGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 5, 2015 at 7:54 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Apr 07, 2015 at 12:34:30PM +0900, Masahiro Yamada wrote:
>> Hello experts,
>> I hope this is the correct ML to ask this question.
>>
>> I am struggling to port Linux-4.0-rc7 onto my SoC/board,
>> based on ARM cortex-A9 (single CPU), but the kernel fails to boot
>> with the error:
>> "not syncing: Attempted to kill init! exitcode=0x00000004"
>
> Hi Masahiro,
>
> Have you track it down to the cause?  I'm asking because I'm seeing the
> same issue with v4.0 on a vendor single Cortex-A9 SoC.

For record, in my case, it's caused by that the user space is built
with VFP support while the SoC does not have VFP.

[    0.091938] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.092049] Setting up static identity map for 0x402bf028 - 0x402bf080
[    0.131141] Brought up 1 CPUs
[    0.131165] SMP: Total of 1 processors activated (1196.85 BogoMIPS).
[    0.131180] CPU: All CPU(s) started in SVC mode.
[    0.132122] devtmpfs: initialized
[    0.133079] VFP support v0.3: not present

Shawn
