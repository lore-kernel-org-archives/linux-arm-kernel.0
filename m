From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 11 May 2014 17:09:27 -0300
Subject: mxs-dcp: BUG: init/1 still has locks held!
In-Reply-To: <1399838888.578955384@f427.i.mail.ru>
References: <CAOMZO5AdHCsCXW-WhRpkZJJcsmoQKvob_zhx-7fu8RSim5-dQA@mail.gmail.com>
 <1399838888.578955384@f427.i.mail.ru>
Message-ID: <CAOMZO5Bh9E5Y53TVhHPE=Zo9K47xgwz-Axx9d55YFcRH+_fV8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 11, 2014 at 5:08 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
> Sun, 11 May 2014 16:57:57 -0300 ?? Fabio Estevam <festevam@gmail.com>:
>> Hi,
>>
>> Running linux-next 20140509 on a mx28evk I observe the following warning:
>>
>> [    8.526613] Freeing unused kernel memory: 232K (c0683000 - c06bd000)
>> starting pid 56, tty '': '/etc/rc.d/rcS'
>> [    9.110314]
>> [    9.111864] =====================================
>> [    9.116603] [ BUG: init/1 still has locks held! ]
>> [    9.121488] 3.15.0-rc4-next-20140509-00001-g319564e #1154 Not tainted
>> [    9.128071] -------------------------------------
>> [    9.132825] 1 lock held by init/1:
>> [    9.136252]  #0:  (global_mutex){+.+.+.}, at: [<c0387d68>] mxs_dcp_probe+0x14
>> [    9.144196]
>> [    9.144196] stack backtrace:
>> [    9.148888] CPU: 0 PID: 1 Comm: init Not tainted 3.15.0-rc4-next-20140509-004
>> [    9.157610] [<c000da40>] (unwind_backtrace) from [<c000bda4>] (show_stack+0x)
>> [    9.165595] [<c000bda4>] (show_stack) from [<c00153d4>] (do_fork+0x2c8/0x3cc)
>> [    9.172921] [<c00153d4>] (do_fork) from [<c0015550>] (sys_vfork+0x20/0x2c)
>> [    9.179973] [<c0015550>] (sys_vfork) from [<c0009580>] (ret_fast_syscall+0x0)
>> Mounting /proc and /sys
>>
>> Should we really use a global mutex here? What is a proper fix for this?
>
> On my opinion mutex_lock/unlock should not be used in probe.
> Try to remove this entirely.

I think the same. Will submit a patch doing as suggested.

Regards,

Fabio Estevam
