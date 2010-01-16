From: rektide@voodoowarez.com (rektide)
Date: Fri, 15 Jan 2010 17:13:07 -0700
Subject: Kirkwood/OpenRD-Base System Crash from DMA
Message-ID: <20100116001307.GH16062@voodoowarez.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm attempting to use 2.6.32.3 on a Kirkwood/OpenRD-Base system.  This system has been
serving fine playing MP3's via PulseAudio and MPD for >5 months now.  However other
activities will sometime cause the system to lock up.  The most reliable activity is to do a
"git pull", from anywhere.  Secondly, writing files onto the system via a Samba share causes
a lockup.

The watchdog eventually spits out (from a git-pull):
[  179.324601] BUG: soft lockup - CPU#0 stuck for 61s! [git-index-pack: 2085] 
[  179.331425] Modules linked in: raid0 raid1 md_mod nfsd exportfs sco 
bridge stp llc bnep rfcomm l2cap bluetooth autofs4 ipt_MASQUERADE 
iptable_nat nf_nat nf_conntrack_ipv4 nf_conntrack nf_defrag_ipv4 
ip_tables x_tables ipv6 orion_wdt snd_usb_audio snd_pcm snd_page_alloc 
snd_usb_lib snd_seq_midi snd_seq_midi_event snd_rawmidi snd_hwdep 
snd_seq snd_timer rtl8187 snd_seq_device mac80211 snd cfg80211 
soundcore rfkill eeprom_93cx6 mv_cesa 
[  179.370279] 
[  179.371772] Pid: 2085, comm:       git-index-pack 
[  179.376500] CPU: 0    Not tainted  (2.6.32.3-thuban #1) 
[  179.381755] PC is at dma_cache_maint_page+0x8/0xc0 
[  179.386579] LR is at dma_async_memcpy_buf_to_pg+0x44/0xbc 
[  179.392006] pc : [<c0031ce8>]    lr : [<c037fe10>]    psr: 20000013 
[  179.392012] sp : de345ab8  ip : 1e3960e0  fp : df862938 
[  179.403548] r10: 0000007f  r9 : de39607c  r8 : df862938 
[  179.408799] r7 : df862860  r6 : 00000f81  r5 : de39607c  r4 : c0a1f800 
[  179.415356] r3 : 00000002  r2 : 0000007f  r1 : 00000f81  r0 : c0a1f800 
[  179.421914] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
Segment user 
[  179.429081] Control: 0005317f  Table: 1f204000  DAC: 00000015

There's a thread on the OpenRD google group with multiple people confirming the issue:
http://groups.google.com/group/openrd/browse_thread/thread/d435787eb4e4ffd0

One person has confirmed the issue goes away when CONFIG_NET_DMA and CONFIG_ASYNC_TX_DMA 
are disabled.  I'm building a kernel now to confirm this myself, and will report back
tomorrow.

Thank you for your consideration.
-M rektide Fowle
