From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 Feb 2014 13:01:49 +0000
Subject: [PATCH v9 1/6] arm64: Add macros to manage processor debug state
In-Reply-To: <CALicx6uw3En92GhrKpAoavzwwNKWR8C8hHcS5B+eyLX_dC0LBA@mail.gmail.com>
References: <1390908022-10287-1-git-send-email-vijay.kilari@gmail.com>
 <1390908022-10287-2-git-send-email-vijay.kilari@gmail.com>
 <20140129105546.GC26622@mudshark.cambridge.arm.com>
 <CALicx6uw3En92GhrKpAoavzwwNKWR8C8hHcS5B+eyLX_dC0LBA@mail.gmail.com>
Message-ID: <20140217130149.GA5856@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 12:21:45PM +0000, Vijay Kilari wrote:
>    If it is ok, can you please merge these patches

I was about to merge them but I wanted to try first. Enabling kgd tests
at boot time, I get plenty of failures as below. Have you successfully
run the kgdb tests?

kgdbts:RUN singlestep [800/1000]
kgdbts: ERROR PUT: end of test buffer on 'singlestep_breakpoint_test' line 0 expected S0* got $T05thread:01;#07
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1 at /work/Linux/linux-2.6-aarch64/drivers/misc/kgdbts.c:815 run_simple_test+0x28c/0x2d8()
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W    3.14.0-rc3+ #300
Call trace:
[<ffffffc000087dbc>] dump_backtrace+0x0/0x12c
[<ffffffc000087efc>] show_stack+0x14/0x1c
[<ffffffc00044582c>] dump_stack+0x78/0xc4
[<ffffffc00009552c>] warn_slowpath_common+0x88/0xac
[<ffffffc000095618>] warn_slowpath_null+0x18/0x20
[<ffffffc0002f5cb0>] run_simple_test+0x28c/0x2d8
[<ffffffc0002f5268>] kgdbts_put_char+0x24/0x2c
[<ffffffc0000fcdf8>] put_packet+0xa0/0x118
[<ffffffc0000fe0e0>] gdb_serial_stub+0xb4c/0xd20
[<ffffffc0000fc434>] kgdb_cpu_enter+0x3bc/0x5f4
[<ffffffc0000fc934>] kgdb_handle_exception+0x18c/0x1f0
[<ffffffc000090d50>] kgdb_compiled_brk_fn+0x2c/0x38
[<ffffffc000082158>] brk_handler+0x8c/0xc4
[<ffffffc0000811ec>] do_debug_exception+0x40/0xac
Exception stack(0xffffffc876cbbb80 to 0xffffffc876cbbca0)
bb80: 006a0000 ffffffc0 000003e8 00000000 76cbbd40 ffffffc8 000fb9b8 ffffffc0
bba0: 000002c0 00000000 000d18cc ffffffc0 76cbbc10 ffffffc8 000d1c40 ffffffc0
bbc0: 00641000 ffffffc0 00000001 00000000 00610d40 ffffffc0 00000006 00000000
bbe0: 00000240 00000000 00000020 00000000 00000000 00000000 00000000 00000000
bc00: 76cbbc10 ffffffc8 00000021 00000000 76cbbcb0 ffffffc8 0044337c ffffffc0
bc20: 00648e58 ffffffc0 00000001 00000000 00000000 00000000 00648e60 ffffffc0
bc40: 000070e1 00000000 00000006 00000000 00000030 00000000 006431b0 ffffffc0
bc60: 000070e0 00000000 00000006 00000000 0000006c 00000000 00007005 00000000
bc80: 00000040 00000000 00003648 00000000 00000000 00000000 00000006 00000000
[<ffffffc000083cb4>] el1_dbg+0x18/0x68
[<ffffffc0005d010c>] init_kgdbts+0x24/0x2c
[<ffffffc000081430>] do_one_initcall+0xdc/0x124
[<ffffffc0005b8930>] kernel_init_freeable+0x138/0x1d8
[<ffffffc000440850>] kernel_init+0x10/0xd4

-- 
Catalin
