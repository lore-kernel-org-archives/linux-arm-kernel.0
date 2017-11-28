From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 28 Nov 2017 20:43:32 +0800
Subject: [arm:phy 25/27] include/linux/export.h:67:20: error: redefinition of
 '__kstrtab___mdiobus_read'
Message-ID: <201711282027.oQYt1Au5%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git phy
head:   95353e987453895fce5681bfa7077ae165af7cdb
commit: 442f18665fea21c9a2c571aaace96f7e36253962 [25/27] net: mdiobus: add unlocked accessors
config: i386-randconfig-x016-201748 (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        git checkout 442f18665fea21c9a2c571aaace96f7e36253962
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/linkage.h:7:0,
                    from include/linux/kernel.h:7,
                    from drivers/net/phy/mdio_bus.c:16:
>> include/linux/export.h:67:20: error: redefinition of '__kstrtab___mdiobus_read'
     static const char __kstrtab_##sym[]    \
                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:104:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "")
     ^~~~~~~~~~~~~~~
>> drivers/net/phy/mdio_bus.c:542:1: note: in expansion of macro 'EXPORT_SYMBOL'
    EXPORT_SYMBOL(__mdiobus_read);
    ^~~~~~~~~~~~~
   include/linux/export.h:67:20: note: previous definition of '__kstrtab___mdiobus_read' was here
     static const char __kstrtab_##sym[]    \
                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:104:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "")
     ^~~~~~~~~~~~~~~
   drivers/net/phy/mdio_bus.c:517:1: note: in expansion of macro 'EXPORT_SYMBOL'
    EXPORT_SYMBOL(__mdiobus_read);
    ^~~~~~~~~~~~~
   include/linux/export.h:70:36: error: redefinition of '__ksymtab___mdiobus_read'
     static const struct kernel_symbol __ksymtab_##sym  \
                                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:104:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "")
     ^~~~~~~~~~~~~~~
>> drivers/net/phy/mdio_bus.c:542:1: note: in expansion of macro 'EXPORT_SYMBOL'
    EXPORT_SYMBOL(__mdiobus_read);
    ^~~~~~~~~~~~~
   include/linux/export.h:70:36: note: previous definition of '__ksymtab___mdiobus_read' was here
     static const struct kernel_symbol __ksymtab_##sym  \
                                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:104:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "")
     ^~~~~~~~~~~~~~~
   drivers/net/phy/mdio_bus.c:517:1: note: in expansion of macro 'EXPORT_SYMBOL'
    EXPORT_SYMBOL(__mdiobus_read);
    ^~~~~~~~~~~~~
--
   In file included from include/linux/linkage.h:7:0,
                    from include/linux/kernel.h:7,
                    from drivers/net//phy/mdio_bus.c:16:
>> include/linux/export.h:67:20: error: redefinition of '__kstrtab___mdiobus_read'
     static const char __kstrtab_##sym[]    \
                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:104:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "")
     ^~~~~~~~~~~~~~~
   drivers/net//phy/mdio_bus.c:542:1: note: in expansion of macro 'EXPORT_SYMBOL'
    EXPORT_SYMBOL(__mdiobus_read);
    ^~~~~~~~~~~~~
   include/linux/export.h:67:20: note: previous definition of '__kstrtab___mdiobus_read' was here
     static const char __kstrtab_##sym[]    \
                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:104:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "")
     ^~~~~~~~~~~~~~~
   drivers/net//phy/mdio_bus.c:517:1: note: in expansion of macro 'EXPORT_SYMBOL'
    EXPORT_SYMBOL(__mdiobus_read);
    ^~~~~~~~~~~~~
   include/linux/export.h:70:36: error: redefinition of '__ksymtab___mdiobus_read'
     static const struct kernel_symbol __ksymtab_##sym  \
                                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:104:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "")
     ^~~~~~~~~~~~~~~
   drivers/net//phy/mdio_bus.c:542:1: note: in expansion of macro 'EXPORT_SYMBOL'
    EXPORT_SYMBOL(__mdiobus_read);
    ^~~~~~~~~~~~~
   include/linux/export.h:70:36: note: previous definition of '__ksymtab___mdiobus_read' was here
     static const struct kernel_symbol __ksymtab_##sym  \
                                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:104:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "")
     ^~~~~~~~~~~~~~~
   drivers/net//phy/mdio_bus.c:517:1: note: in expansion of macro 'EXPORT_SYMBOL'
    EXPORT_SYMBOL(__mdiobus_read);
    ^~~~~~~~~~~~~

vim +/__kstrtab___mdiobus_read +67 include/linux/export.h

f5016932 Paul Gortmaker  2011-05-23  62  
f5016932 Paul Gortmaker  2011-05-23  63  /* For every exported symbol, place a struct in the __ksymtab section */
f2355416 Nicolas Pitre   2016-01-22  64  #define ___EXPORT_SYMBOL(sym, sec)					\
f5016932 Paul Gortmaker  2011-05-23  65  	extern typeof(sym) sym;						\
f5016932 Paul Gortmaker  2011-05-23  66  	__CRC_SYMBOL(sym, sec)						\
f5016932 Paul Gortmaker  2011-05-23 @67  	static const char __kstrtab_##sym[]				\
f5016932 Paul Gortmaker  2011-05-23  68  	__attribute__((section("__ksymtab_strings"), aligned(1)))	\
b92021b0 Rusty Russell   2013-03-15  69  	= VMLINUX_SYMBOL_STR(sym);					\
b67067f1 Nicholas Piggin 2016-08-24  70  	static const struct kernel_symbol __ksymtab_##sym		\
f5016932 Paul Gortmaker  2011-05-23  71  	__used								\
b67067f1 Nicholas Piggin 2016-08-24  72  	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
f5016932 Paul Gortmaker  2011-05-23  73  	= { (unsigned long)&sym, __kstrtab_##sym }
f5016932 Paul Gortmaker  2011-05-23  74  

:::::: The code at line 67 was first introduced by commit
:::::: f50169324df4ad942e544386d136216c8617636a module.h: split out the EXPORT_SYMBOL into export.h

:::::: TO: Paul Gortmaker <paul.gortmaker@windriver.com>
:::::: CC: Paul Gortmaker <paul.gortmaker@windriver.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 26861 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171128/e8393ea8/attachment-0001.gz>
