From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 3 Sep 2013 06:48:17 -0400
Subject: Unhandled prefetch abort on mirabox with 3.11-rc7
In-Reply-To: <52253229.2050103@leahnim.org>
References: <52253229.2050103@leahnim.org>
Message-ID: <20130903104817.GE19598@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the relevant folks to the Cc: ...

On Mon, Sep 02, 2013 at 08:49:45PM -0400, Jochen De Smet wrote:
> [Not subscribed, so keep me on CC please]
> 
> This one happened on my second mirabox, with the same kernel as my
> last problem
> (see "Undefined instruction (ldrshtgt?) on mirabox with 3.11-rc7"
> thread); I'm hoping
> there's not some general (overheating?) hw problem with these boxes.
> 
> [56215.930555] Unhandled prefetch abort: section domain fault
> (0x009) at 0xc014aae8
> [56215.937977] Internal error: : 9 [#1] ARM
> [56215.941906] Modules linked in: nfsv3 nfs_acl auth_rpcgss
> oid_registry nfsv4 dns_resolver nfs lockd sunrpc tun sha1_generic
> drbd lru_cache dlm sctp configfs iscsi_tcp libiscsi_tcp libiscsi
> scsi_transport_iscsi ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat
> iptable_mangle ipt_REJECT xt_conntrack ebtable_filter ebtables
> iptable_filter ip_tables ext3 jbd autofs4 ext4 jbd2 mbcache sd_mod
> usb_storage mmc_block mvsdio xhci_hcd mmc_core ehci_orion
> [56215.981284] CPU: 0 PID: 0 Comm: swapper Not tainted 3.11.0-rc7-stock2 #30
> [56215.988086] task: c03f9540 ti: c03ee000 task.ti: c03ee000
> [56215.993505] PC is at __memzero+0x8/0x80
> [56215.997355] LR is at ip_rcv+0x1f4/0x364
> [56216.001200] pc : [<c014aae8>]    lr : [<c0279f20>] psr: 60000113
> [56216.001200] sp : c03efd20  ip : 00000064  fp : c03efd54
> [56216.012697] r10: ef1ed800  r9 : ee8de9c0  r8 : ee8de9c0
> [56216.017930] r7 : 00000000  r6 : b4806c0d  r5 : 00000000  r4 : ed06c650
> [56216.024468] r3 : 00000000  r2 : 00000000  r1 : 00000014  r0 : ee8de9d8
> [56216.031006] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
> Segment kernel
> [56216.038327] Control: 10c5387d  Table: 2e3f0019  DAC: 00000015
> [56216.044082] Process swapper (pid: 0, stack limit = 0xc03ee230)
> [56216.049923] Stack: (0xc03efd20 to 0xc03f0000)
> [56216.054292] fd20: ed06c650 0000002e 0000000e 00000001 c03f7348
> c03f8b98 00000008 ef1ed800
> [56216.062487] fd40: 00000000 c03f735c c03efda4 c03efd58 c024b260
> c0279d38 e9a04177 00000000
> [56216.070681] fd60: c03efd7c c03efdc0 00000003 ee8de9c0 f0338000
> c03f735c ef23b000 ee8de9c0
> [56216.078876] fd80: 00000003 ee8de9c0 f0338000 ef1edc80 ef23b000
> 00000001 c03efdbc c03efda8
> [56216.087071] fda0: c024d3e8 c024adec ee8de9c0 00000003 c03efddc
> c03efdc0 c024d5a4 c024d3c8
> [56216.095266] fdc0: c7764b9f 132033dd ef23b000 ee8de9c0 c03efdf4
> c03efde0 c024de98 c024d584
> [56216.103460] fde0: f03380a0 00000005 c03efe3c c03efdf8 c01ee27c
> c024de28 00000000 00000000
> [56216.111653] fe00: 00000001 ef1ed800 00000001 00000000 ef23b000
> 00000040 00000100 00000000
> [56216.119847] fe20: ef23b000 00000000 ef1edc80 c04102f8 c03efe74
> c03efe40 c01ee548 c01ee12c
> [56216.128042] fe40: ef1edccc ef1ed800 c03efeac c01ee4bc ef1edccc
> 00000040 0000012c c04179c0
> [56216.136238] fe60: c04179c0 c03ff148 c03efeac c03efe78 c024dbb8
> c01ee4c8 c04179c8 00556144
> [56216.144432] fe80: c03efec4 00000001 0000000c c04183d0 c04183c0
> c03ee000 00000003 00000100
> [56216.152626] fea0: c03efef4 c03efeb0 c0022354 c024db20 c0164360
> ef053c40 0000000c 00200000
> [56216.160821] fec0: 00556143 0000000a 00022000 c0406088 00000018
> 00000000 c03eff50 00000001
> [56216.169015] fee0: c03ee000 c03f60c8 c03eff0c c03efef8 c0022714
> c002228c 0000006e c0406088
> [56216.177209] ff00: c03eff2c c03eff10 c000f524 c00226c4 00000074
> c0433100 000003ff c0433100
> [56216.185404] ff20: c03eff4c c03eff30 c0008554 c000f4f4 c0049954
> 60000013 ffffffff c03eff84
> [56216.193600] ff40: c03effac c03eff50 c02df7a0 c0008514 ffffffed
> 00000000 c0411c48 c001b4e4
> [56216.201794] ff60: c03ee000 c0417a87 c0417a87 c03ee000 00000001
> c03ee000 c03f60c8 c03effac
> [56216.209988] ff80: c03eff88 c03eff98 c000f700 c0049954 60000013
> ffffffff 00000000 c0e31cc0
> [56216.218183] ffa0: c03effbc c03effb0 c02d8700 c0049914 c03efff4
> c03effc0 c03c6a54 c02d86a8
> [56216.226377] ffc0: ffffffff ffffffff c03c6544 00000000 00000000
> c03e54b8 10c53c7d c03f6070
> [56216.234572] ffe0: c03e54b4 c03fa640 00000000 c03efff8 00008070
> c03c67c0 00000000 00000000
> [56216.242759] Backtrace:
> [56216.245235] [<c0279d2c>] (ip_rcv+0x0/0x364) from [<c024b260>]
> (__netif_receive_skb_core+0x480/0x5c4)
> [56216.254390] [<c024ade0>] (__netif_receive_skb_core+0x0/0x5c4)
> from [<c024d3e8>] (__netif_receive_skb+0x2c/0x80)
> [56216.264499] [<c024d3bc>] (__netif_receive_skb+0x0/0x80) from
> [<c024d5a4>] (netif_receive_skb+0x2c/0x64)
> [56216.273906]  r5:00000003 r4:ee8de9c0
> [56216.277513] [<c024d578>] (netif_receive_skb+0x0/0x64) from
> [<c024de98>] (napi_gro_receive+0x7c/0xa8)
> [56216.286659]  r4:ee8de9c0
> [56216.289217] [<c024de1c>] (napi_gro_receive+0x0/0xa8) from
> [<c01ee27c>] (mvneta_rx+0x15c/0x39c)
> [56216.297841]  r5:00000005 r4:f03380a0
> [56216.301448] [<c01ee120>] (mvneta_rx+0x0/0x39c) from [<c01ee548>]
> (mvneta_poll+0x8c/0x18c)
> [56216.309643] [<c01ee4bc>] (mvneta_poll+0x0/0x18c) from
> [<c024dbb8>] (net_rx_action+0xa4/0x1a8)
> [56216.318192] [<c024db14>] (net_rx_action+0x0/0x1a8) from
> [<c0022354>] (__do_softirq+0xd4/0x1bc)
> [56216.326823] [<c0022280>] (__do_softirq+0x0/0x1bc) from
> [<c0022714>] (irq_exit+0x5c/0x98)
> [56216.334936] [<c00226b8>] (irq_exit+0x0/0x98) from [<c000f524>]
> (handle_IRQ+0x3c/0x8c)
> [56216.342777]  r4:c0406088 r3:0000006e
> [56216.346385] [<c000f4e8>] (handle_IRQ+0x0/0x8c) from [<c0008554>]
> (armada_370_xp_handle_irq+0x4c/0x54)
> [56216.355617]  r6:c0433100 r5:000003ff r4:c0433100 r3:00000074
> [56216.361335] [<c0008508>] (armada_370_xp_handle_irq+0x0/0x54) from
> [<c02df7a0>] (__irq_svc+0x40/0x50)
> [56216.370482] Exception stack(0xc03eff50 to 0xc03eff98)
> [56216.375543] ff40:                                     ffffffed
> 00000000 c0411c48 c001b4e4
> [56216.383738] ff60: c03ee000 c0417a87 c0417a87 c03ee000 00000001
> c03ee000 c03f60c8 c03effac
> [56216.391932] ff80: c03eff88 c03eff98 c000f700 c0049954 60000013 ffffffff
> [56216.398555]  r7:c03eff84 r6:ffffffff r5:60000013 r4:c0049954
> [56216.404279] [<c0049908>] (cpu_startup_entry+0x0/0xe8) from
> [<c02d8700>] (rest_init+0x64/0x7c)
> [56216.412816]  r7:c0e31cc0 r3:00000000
> [56216.416430] [<c02d869c>] (rest_init+0x0/0x7c) from [<c03c6a54>]
> (start_kernel+0x2a0/0x2f4)
> [56216.424717] [<c03c67b4>] (start_kernel+0x0/0x2f4) from
> [<00008070>] (0x8070)
> [56216.431781] Code: e4c02001 e0811003 e3a02000 e2103003 (1afffff5)
> [56216.437891] ---[ end trace 5a452ae3bbf8d147 ]---
> [56216.442516] Kernel panic - not syncing: Fatal exception in interrupt
> 
> decodecode output:
> 
> [56216.431781] Code: e4c02001 e0811003 e3a02000 e2103003 (1afffff5)
> All code
> ========
>    0:   e4c02001        strb    r2, [r0], #1
>    4:   e0811003        add     r1, r1, r3
>    8:   e3a02000        mov     r2, #0
>    c:   e2103003        ands    r3, r0, #3
>   10:*  1afffff5        bne     0xffffffec              <-- trapping
> instruction
> 
> Code starting with the faulting instruction
> ===========================================
>    0:   1afffff5        bne     0xffffffdc
> 
> 
> ip_rcv around the +0x1f4 mark:
> 
>    0xc0279ee4 <+440>:   adc     r3, r3, r1
>    0xc0279ee8 <+444>:   strd    r2, [r12, #96]  ; 0x60
>    0xc0279eec <+448>:   b       0xc0279e0c <ip_rcv+224>
>    0xc0279ef0 <+452>:   ldrb    r12, [r4]
>    0xc0279ef4 <+456>:   and     r12, r12, #15
>    0xc0279ef8 <+460>:   cmp     r1, r12, lsl #2
>    0xc0279efc <+464>:   bcc     0xc0279dec <ip_rcv+192>
>    0xc0279f00 <+468>:   cmp     r1, r2
>    0xc0279f04 <+472>:   bcc     0xc0279fb4 <ip_rcv+648>
>    0xc0279f08 <+476>:   ldrh    r3, [r8, #154]  ; 0x9a
>    0xc0279f0c <+480>:   add     r0, r8, #24
>    0xc0279f10 <+484>:   mov     r1, #20
>    0xc0279f14 <+488>:   add     r12, r3, r12, lsl #2
>    0xc0279f18 <+492>:   strh    r12, [r8, #152] ; 0x98
>    0xc0279f1c <+496>:   bl      0xc014aae0 <__memzero>
> >> 0xc0279f20 <+500>:   ldr     r3, [r8, #104]  ; 0x68
>    0xc0279f24 <+504>:   cmp     r3, #0
>    0xc0279f28 <+508>:   beq     0xc0279f34 <ip_rcv+520>
>    0xc0279f2c <+512>:   mov     r0, r8
>    0xc0279f30 <+516>:   blx     r3
>    0xc0279f34 <+520>:   ldr     r3, [pc, #332]  ; 0xc027a088 <ip_rcv+860>
>    0xc0279f38 <+524>:   mov     r1, #0
>    0xc0279f3c <+528>:   str     r1, [r8, #104]  ; 0x68
>    0xc0279f40 <+532>:   add     r2, r3, #128    ; 0x80
>    0xc0279f44 <+536>:   str     r1, [r8, #16]
>    0xc0279f48 <+540>:   ldr     r3, [r3, #128]  ; 0x80
>    0xc0279f4c <+544>:   cmp     r3, r2
>    0xc0279f50 <+548>:   beq     0xc0279f80 <ip_rcv+596>
> 
> As last time, any help would be appreciated.
> 
> J.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
