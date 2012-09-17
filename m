From: javier.martin@vista-silicon.com (javier Martin)
Date: Mon, 17 Sep 2012 17:35:22 +0200
Subject: [PATCH 25/34] dma: imx-dma: remove mach/hardware.h inclusion
Message-ID: <CACKLOr0-s5Cuuun-sRvs=V3-J7wCjsKfDz8fVWxQGNbZEepDwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
even after applying Sascha's fix I still get the following in our
Visstrim SM10 board after testing this patch.

---
# aplay /usr/share/sounds/linphone/hello8000.wav
Playing WAVE '/usr/share/sounds/linphone/hello8000.wav' : Signed 16
bit Little Endian, Rate 8000 Hz, Mono
Internal error: Oops: 17 [#1] PREEMPT ARM
Modules linked in:
CPU: 0    Not tainted  (3.6.0-rc5-01229-gc0ed45d-dirty #23)
PC is at snd_dmaengine_pcm_get_chan+0x8/0x10
LR is at snd_imx_pcm_hw_params+0x18/0xd4
pc : [<c023a88c>]    lr : [<c02491dc>]    psr: a0000013
sp : c32f7e40  ip : fffffffc  fp : c31c081c
r10: c31c0810  r9 : c31a48c0  r8 : c3370400
r7 : c3370400  r6 : c31a4a40  r5 : c31c0810  r4 : c31a20a0
r3 : 00000000  r2 : f4410024  r1 : c3370400  r0 : c31a20a0
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: a336c000  DAC: 00000015
Process aplay (pid: 477, stack limit = 0xc32f6270)
Stack: (0xc32f7e40 to 0xc32f8000)
7e40: c3193200 c02dfca8 c3370420 c02dfc98 00000014 c023ace4 c3193200 c0247fe4
7e60: 00000000 c31a20a0 c31a4a40 00000000 c31a20a0 c31a4a40 c31a4980 c0245c40
7e80: c0245b24 c3370800 c3370400 c31a20a0 00000000 c0013b08 c32f6000 00000000
7ea0: 00000001 c0234a94 bed00044 c31a20a0 bed00044 c3370400 c0013b08 c0235040
7ec0: c32c0994 c0152820 b6e849ac c32f7fb0 c3199d60 c32c0960 80000005 bed00044
7ee0: c31a20a0 400c4152 00000004 c0013b08 c32f6000 00000000 00000001 c02364c8
7f00: 000fff07 00000000 b6e849ac c000858c c0400b90 bed00044 c337c360 c3190090
7f20: 00000004 c009c8c4 c3186000 00000002 00000000 c32c0960 00000000 c0042d88
7f40: 00000000 00000002 c3186000 c318601c c32f7f6c c0045d14 c3199d60 c03e5450
7f60: c3199d60 c03e5450 c32f7f9c c337c360 bed00044 c25c4111 00000004 c0013b08
7f80: c32f6000 c009c964 00000004 00000000 bed00044 bed00044 b6ee0000 009d5608
7fa0: 00000036 c0013980 bed00044 b6ee0000 00000004 c25c4111 bed00044 00020001
7fc0: bed00044 b6ee0000 009d5608 00000036 b6ee0000 b6edf024 0000000c 00000001
7fe0: 009d5658 becfff88 b6e8108c b6cf693c 20000010 00000004 a35fe831 a35fec31
[<c023a88c>] (snd_dmaengine_pcm_get_chan+0x8/0x10) from [<c02491dc>]
(snd_imx_pcm_hw_params+0x18/0xd4)
[<c02491dc>] (snd_imx_pcm_hw_params+0x18/0xd4) from [<c0245c40>]
(soc_pcm_hw_params+0x11c/0x1d0)
[<c0245c40>] (soc_pcm_hw_params+0x11c/0x1d0) from [<c0234a94>]
(snd_pcm_hw_params+0x154/0x3b0)
[<c0234a94>] (snd_pcm_hw_params+0x154/0x3b0) from [<c0235040>]
(snd_pcm_common_ioctl1+0x1e8/0xe70)
[<c0235040>] (snd_pcm_common_ioctl1+0x1e8/0xe70) from [<c02364c8>]
(snd_pcm_playback_ioctl1+0x3e8/0x40c)
[<c02364c8>] (snd_pcm_playback_ioctl1+0x3e8/0x40c) from [<c009c8c4>]
(do_vfs_ioctl+0x508/0x574)
[<c009c8c4>] (do_vfs_ioctl+0x508/0x574) from [<c009c964>] (sys_ioctl+0x34/0x54)
[<c009c964>] (sys_ioctl+0x34/0x54) from [<c0013980>] (ret_fast_syscall+0x0/0x2c)
Code: e593000c e12fff1e e59030a0 e59330bc (e5930000)

I will try to find the cause tomorrow when I come back to the office.

Regards.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
