From: mingo@elte.hu (Ingo Molnar)
Date: Thu, 11 Nov 2010 09:28:43 +0100
Subject: [Questions] How to run 'perf top' on ARM to profile kernel
	functions with modules loaded
In-Reply-To: <AANLkTim+BAYKWqiJzSQQLc4e_yNkMsNNnEp5u8YgC2Fk@mail.gmail.com>
References: <AANLkTinwAL8dFsDbd-ZTQEcEziq6jZk82KPzNqMVxnOx@mail.gmail.com>
	<AANLkTim+BAYKWqiJzSQQLc4e_yNkMsNNnEp5u8YgC2Fk@mail.gmail.com>
Message-ID: <20101111082843.GA32728@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Ming Lei <tom.leiming@gmail.com> wrote:

> 2010/11/11 Ming Lei <tom.leiming@gmail.com>:
> > Hi,
> >
> > 'perf top' can't display any functions when modules are loaded on ARM.
> 
> Sorry, should be can't display any kernel functions when modules are loaded
> on ARM.
> 
> Also, when modules are loaded, 'perf report' can't display functions names,
> follows result of 'perf report':
> 
> root at beagleboard:~# perf report
> # Events: 4K cycles
> #
> # Overhead      Command      Shared Object                  Symbol
> # ........  ...........  .................  ......................
> #
>     97.36%      swapper  [musb_hdrc]        [k]  10466c4
>      2.19%         perf  [musb_hdrc]        [k]  10da070
>      0.09%  ksoftirqd/0  [musb_hdrc]        [k]  10db998
>      0.06%         perf  libc-2.9.so        [.] memchr
>      0.04%         perf  libc-2.9.so        [.]    663c0
>      0.02%         perf  perf               [.]     2e80
>      0.02%         perf  libc-2.9.so        [.] closedir
>      0.02%         perf  libc-2.9.so        [.] __read
>      0.02%  flush-179:0  [musb_hdrc]        [k]  10ff124
>      0.02%         perf  libc-2.9.so        [.] memset
>      0.02%         perf  libc-2.9.so        [.] __memcpy_chk
>      0.02%         perf  perf               [.] event__synthesize_comm
>      0.02%         perf           ffff0fc4  [.] ffff0fc4
>      0.02%         perf  perf               [.] hex2u64
>      0.02%         perf  libc-2.9.so        [.] _IO_vfprintf
>      0.02%         perf  libc-2.9.so        [.] fgets
>      0.02%         perf  libpthread-2.9.so  [.] flockfile
>      0.02%         perf  perf               [.] kallsyms__parse
>      0.02%         perf  libc-2.9.so        [.] _IO_getline_info
> 
> Any suggestions or comments?

Must be some bug in the ELF symbol handling code - we've had many cases of quirks 
and special cases there. Please run 'perf archive' and send the resulting 
perf.data.tar.bz2 to Arnaldo in private mail. (the file will be big)

Thanks,

	Ingo
