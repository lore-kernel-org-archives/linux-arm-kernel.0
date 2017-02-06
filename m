From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 7 Feb 2017 02:34:28 +0800
Subject: [hisi:topic-lpc-4.10-libio 1/2] drivers/atm/iphase.h:127:0: warning:
 "isprint" redefined
Message-ID: <201702070219.xvuQ3xEh%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/hisilicon/linux-hisi topic-lpc-4.10-libio
head:   06443d85dc35b64a704f7be84cc538281a1598f4
commit: 4963ab639c628204056ef81b89c8cf2d628a2dae [1/2] libio: eliminate some compile errors
config: x86_64-allyesdebian (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 4963ab639c628204056ef81b89c8cf2d628a2dae
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from drivers/atm/iphase.c:66:0:
>> drivers/atm/iphase.h:127:0: warning: "isprint" redefined
    #define isprint(a) ((a >=' ')&&(a <= '~'))
    
   In file included from include/acpi/platform/aclinux.h:82:0,
                    from include/acpi/platform/acenv.h:185,
                    from include/acpi/acpi.h:56,
                    from include/linux/acpi.h:33,
                    from include/linux/libio.h:23,
                    from include/linux/io.h:27,
                    from include/linux/pci.h:31,
                    from drivers/atm/iphase.c:46:
   include/linux/ctype.h:31:0: note: this is the location of the previous definition
    #define isprint(c) ((__ismask(c)&(_P|_U|_L|_D|_SP)) != 0)
    
--
   In file included from drivers/isdn/mISDN/dsp.h:33:0,
                    from drivers/isdn/mISDN/dsp_core.c:163:
>> drivers/isdn/mISDN/dsp_ecdis.h:43:0: warning: "FALSE" redefined
    #define FALSE 0
    
   In file included from include/acpi/acpi.h:58:0,
                    from include/linux/acpi.h:33,
                    from include/linux/libio.h:23,
                    from include/linux/io.h:27,
                    from include/linux/irq.h:24,
                    from arch/x86/include/asm/hardirq.h:5,
                    from include/linux/hardirq.h:8,
                    from include/net/sock.h:43,
                    from include/linux/mISDNif.h:415,
                    from drivers/isdn/mISDN/dsp_core.c:158:
   include/acpi/actypes.h:433:0: note: this is the location of the previous definition
    #define FALSE                           (1 == 0)
    
   In file included from drivers/isdn/mISDN/dsp.h:33:0,
                    from drivers/isdn/mISDN/dsp_core.c:163:
>> drivers/isdn/mISDN/dsp_ecdis.h:44:0: warning: "TRUE" redefined
    #define TRUE (!FALSE)
    
   In file included from include/acpi/acpi.h:58:0,
                    from include/linux/acpi.h:33,
                    from include/linux/libio.h:23,
                    from include/linux/io.h:27,
                    from include/linux/irq.h:24,
                    from arch/x86/include/asm/hardirq.h:5,
                    from include/linux/hardirq.h:8,
                    from include/net/sock.h:43,
                    from include/linux/mISDNif.h:415,
                    from drivers/isdn/mISDN/dsp_core.c:158:
   include/acpi/actypes.h:438:0: note: this is the location of the previous definition
    #define TRUE                            (1 == 1)
    
--
   In file included from drivers/net/fddi/skfp/h/smc.h:50:0,
                    from drivers/net/fddi/skfp/skfddi.c:97:
>> drivers/net/fddi/skfp/h/targetos.h:62:0: warning: "TRUE" redefined
    #define TRUE  1
    
   In file included from include/acpi/acpi.h:58:0,
                    from include/linux/acpi.h:33,
                    from include/linux/libio.h:23,
                    from include/linux/io.h:27,
                    from include/linux/irq.h:24,
                    from arch/x86/include/asm/hardirq.h:5,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from drivers/net/fddi/skfp/skfddi.c:81:
   include/acpi/actypes.h:438:0: note: this is the location of the previous definition
    #define TRUE                            (1 == 1)
    
   In file included from drivers/net/fddi/skfp/h/smc.h:50:0,
                    from drivers/net/fddi/skfp/skfddi.c:97:
>> drivers/net/fddi/skfp/h/targetos.h:63:0: warning: "FALSE" redefined
    #define FALSE 0
    
   In file included from include/acpi/acpi.h:58:0,
                    from include/linux/acpi.h:33,
                    from include/linux/libio.h:23,
                    from include/linux/io.h:27,
                    from include/linux/irq.h:24,
                    from arch/x86/include/asm/hardirq.h:5,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from drivers/net/fddi/skfp/skfddi.c:81:
   include/acpi/actypes.h:433:0: note: this is the location of the previous definition
    #define FALSE                           (1 == 0)
    
--
>> drivers/tty/vt/selection.c:30:0: warning: "isspace" redefined
    #define isspace(c) ((c) == ' ')
    
   In file included from include/acpi/platform/aclinux.h:82:0,
                    from include/acpi/platform/acenv.h:185,
                    from include/acpi/acpi.h:56,
                    from include/linux/acpi.h:33,
                    from include/linux/libio.h:23,
                    from include/linux/io.h:27,
                    from include/linux/irq.h:24,
                    from arch/x86/include/asm/hardirq.h:5,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from include/linux/kbd_kern.h:5,
                    from drivers/tty/vt/selection.c:21:
   include/linux/ctype.h:34:0: note: this is the location of the previous definition
    #define isspace(c) ((__ismask(c)&(_S)) != 0)
    

vim +/isprint +127 drivers/atm/iphase.h

^1da177e Linus Torvalds 2005-04-16  111  #define IF_EN_INTR(A)
^1da177e Linus Torvalds 2005-04-16  112  #define IF_TX(A)
^1da177e Linus Torvalds 2005-04-16  113  #define IF_RX(A)
^1da177e Linus Torvalds 2005-04-16  114  #define IF_TXDEBUG(A)
^1da177e Linus Torvalds 2005-04-16  115  #define IF_VC(A)
^1da177e Linus Torvalds 2005-04-16  116  #define IF_ERR(A) 
^1da177e Linus Torvalds 2005-04-16  117  #define IF_CBR(A)
^1da177e Linus Torvalds 2005-04-16  118  #define IF_UBR(A)
^1da177e Linus Torvalds 2005-04-16  119  #define IF_ABR(A)
^1da177e Linus Torvalds 2005-04-16  120  #define IF_SHUTDOWN(A)
^1da177e Linus Torvalds 2005-04-16  121  #define DbgPrint(A)
^1da177e Linus Torvalds 2005-04-16  122  #define IF_EVENT(A)
^1da177e Linus Torvalds 2005-04-16  123  #define IF_TXPKT(A) 
^1da177e Linus Torvalds 2005-04-16  124  #define IF_RXPKT(A)
^1da177e Linus Torvalds 2005-04-16  125  #endif /* CONFIG_ATM_IA_DEBUG */ 
^1da177e Linus Torvalds 2005-04-16  126  
^1da177e Linus Torvalds 2005-04-16 @127  #define isprint(a) ((a >=' ')&&(a <= '~'))  
^1da177e Linus Torvalds 2005-04-16  128  #define ATM_DESC(skb) (skb->protocol)
^1da177e Linus Torvalds 2005-04-16  129  #define IA_SKB_STATE(skb) (skb->protocol)
^1da177e Linus Torvalds 2005-04-16  130  #define IA_DLED   1
^1da177e Linus Torvalds 2005-04-16  131  #define IA_TX_DONE 2
^1da177e Linus Torvalds 2005-04-16  132  
^1da177e Linus Torvalds 2005-04-16  133  /* iadbg defines */
^1da177e Linus Torvalds 2005-04-16  134  #define IA_CMD   0x7749
^1da177e Linus Torvalds 2005-04-16  135  typedef struct {

:::::: The code at line 127 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38068 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170207/533111f8/attachment-0001.gz>
