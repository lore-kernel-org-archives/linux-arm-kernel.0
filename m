From: lkp@intel.com (kbuild test robot)
Date: Tue, 17 Apr 2018 14:36:25 +0800
Subject: [PATCH v6 01/11] ARM: sunxi: smp: Move assembly code into a file
In-Reply-To: <20180416215032.5023-2-mylene.josserand@bootlin.com>
References: <20180416215032.5023-2-mylene.josserand@bootlin.com>
Message-ID: <201804171411.oySI979y%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Myl?ne,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm-soc/for-next]
[also build test ERROR on v4.17-rc1 next-20180416]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Myl-ne-Josserand/Sunxi-Add-SMP-support-on-A83T/20180417-113911
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for-next
config: arm-sunxi_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   include/asm-generic/bitops/sched.h:14: Error: junk at end of line, first unrecognized character is `{'
   include/asm-generic/bitops/sched.h:20: Error: bad instruction `if (b[0])'
   include/asm-generic/bitops/sched.h:21: Error: bad instruction `return __ffs(b[0])'
   include/asm-generic/bitops/sched.h:22: Error: bad instruction `if (b[1])'
   include/asm-generic/bitops/sched.h:23: Error: bad instruction `return __ffs(b[1])+32'
   include/asm-generic/bitops/sched.h:24: Error: bad instruction `if (b[2])'
   include/asm-generic/bitops/sched.h:25: Error: bad instruction `return __ffs(b[2])+64'
   include/asm-generic/bitops/sched.h:26: Error: bad instruction `return __ffs(b[3])+96'
   include/asm-generic/bitops/sched.h:30: Error: junk at end of line, first unrecognized character is `}'
   include/asm-generic/bitops/arch_hweight.h:7: Error: bad instruction `static inline unsigned int __arch_hweight32(unsigned int w)'
   include/asm-generic/bitops/arch_hweight.h:8: Error: junk at end of line, first unrecognized character is `{'
   include/asm-generic/bitops/arch_hweight.h:9: Error: bad instruction `return __sw_hweight32(w)'
   include/asm-generic/bitops/arch_hweight.h:10: Error: junk at end of line, first unrecognized character is `}'
   include/asm-generic/bitops/arch_hweight.h:12: Error: bad instruction `static inline unsigned int __arch_hweight16(unsigned int w)'
   include/asm-generic/bitops/arch_hweight.h:13: Error: junk at end of line, first unrecognized character is `{'
   include/asm-generic/bitops/arch_hweight.h:14: Error: bad instruction `return __sw_hweight16(w)'
   include/asm-generic/bitops/arch_hweight.h:15: Error: junk at end of line, first unrecognized character is `}'
   include/asm-generic/bitops/arch_hweight.h:17: Error: bad instruction `static inline unsigned int __arch_hweight8(unsigned int w)'
   include/asm-generic/bitops/arch_hweight.h:18: Error: junk at end of line, first unrecognized character is `{'
   include/asm-generic/bitops/arch_hweight.h:19: Error: bad instruction `return __sw_hweight8(w)'
   include/asm-generic/bitops/arch_hweight.h:20: Error: junk at end of line, first unrecognized character is `}'
   include/asm-generic/bitops/arch_hweight.h:22: Error: bad instruction `static inline unsigned long __arch_hweight64(__u64 w)'
   include/asm-generic/bitops/arch_hweight.h:23: Error: junk at end of line, first unrecognized character is `{'
   include/asm-generic/bitops/arch_hweight.h:24: Error: bad instruction `return __sw_hweight64(w)'
   include/asm-generic/bitops/arch_hweight.h:25: Error: junk at end of line, first unrecognized character is `}'
   include/asm-generic/bitops/find.h:30: Error: bad instruction `extern unsigned long find_next_and_bit(const unsigned long*addr1,'
   include/asm-generic/bitops/find.h:31: Error: bad instruction `const unsigned long*addr2,unsigned long size,'
   include/asm-generic/bitops/find.h:32: Error: bad instruction `unsigned long offset)'
   arch/arm/include/asm/swab.h:23: Error: bad instruction `static inline __u32 __arch_swahb32(__u32 x)'
   arch/arm/include/asm/swab.h:24: Error: junk at end of line, first unrecognized character is `{'
   arch/arm/include/asm/swab.h:25: Error: bad instruction `__asm__ ("rev16 %0, %1":"=r"(x):"r"(x))'
   arch/arm/include/asm/swab.h:26: Error: bad instruction `return x'
   arch/arm/include/asm/swab.h:27: Error: junk at end of line, first unrecognized character is `}'
   arch/arm/include/asm/swab.h:31: Error: bad instruction `static inline __u32 __arch_swab32(__u32 x)'
   arch/arm/include/asm/swab.h:32: Error: junk at end of line, first unrecognized character is `{'
   arch/arm/include/asm/swab.h:33: Error: bad instruction `__asm__ ("rev %0, %1":"=r"(x):"r"(x))'
   arch/arm/include/asm/swab.h:34: Error: bad instruction `return x'
   arch/arm/include/asm/swab.h:35: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:47: Error: bad instruction `static inline __u16 __fswab16(__u16 val)'
   include/uapi/linux/swab.h:48: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:50: Error: bad instruction `return ((__u16)__arch_swahb32(val))'
   include/uapi/linux/swab.h:54: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:56: Error: bad instruction `static inline __u32 __fswab32(__u32 val)'
   include/uapi/linux/swab.h:57: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:59: Error: bad instruction `return __arch_swab32(val)'
   include/uapi/linux/swab.h:63: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:65: Error: bad instruction `static inline __u64 __fswab64(__u64 val)'
   include/uapi/linux/swab.h:66: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:70: Error: bad instruction `__u32 h=val>>32'
   include/uapi/linux/swab.h:71: Error: bad instruction `__u32 l=val&((1ULL<<32)-1)'
   include/uapi/linux/swab.h:72: Error: bad instruction `return (((__u64)__fswab32(l))<<32)|((__u64)(__fswab32(h)))'
   include/uapi/linux/swab.h:76: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:78: Error: bad instruction `static inline __u32 __fswahw32(__u32 val)'
   include/uapi/linux/swab.h:79: Error: junk@end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:83: Error: bad instruction `return ((__u32)((((__u32)(val)&(__u32)0x0000ffffUL)<<16)|(((__u32)(val)&(__u32)0xffff0000UL)>>16)))'
   include/uapi/linux/swab.h:85: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:87: Error: bad instruction `static inline __u32 __fswahb32(__u32 val)'
   include/uapi/linux/swab.h:88: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:90: Error: bad instruction `return __arch_swahb32(val)'
   include/uapi/linux/swab.h:94: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:161: Error: bad instruction `static inline __u16 __swab16p(const __u16*p)'
   include/uapi/linux/swab.h:162: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:166: Error: bad instruction `return (__builtin_constant_p((__u16)(*p))?((__u16)((((__u16)(*p)&(__u16)0x00ffU)<<8)|(((__u16)(*p)&(__u16)0xff00U)>>8))):__fswab16(*p))'
   include/uapi/linux/swab.h:168: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:174: Error: bad instruction `static inline __u32 __swab32p(const __u32*p)'
   include/uapi/linux/swab.h:175: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:179: Error: bad instruction `return (__builtin_constant_p((__u32)(*p))?((__u32)((((__u32)(*p)&(__u32)0x000000ffUL)<<24)|(((__u32)(*p)&(__u32)0x0000ff00UL)<<8)|(((__u32)(*p)&(__u32)0x00ff0000UL)>>8)|(((__u32)(*p)&(__u32)0xff000000UL)>>24))):__fswab32(*p))'
   include/uapi/linux/swab.h:181: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:187: Error: bad instruction `static inline __u64 __swab64p(const __u64*p)'
   include/uapi/linux/swab.h:188: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:192: Error: bad instruction `return (__builtin_constant_p((__u64)(*p))?((__u64)((((__u64)(*p)&(__u64)0x00000000000000ffULL)<<56)|(((__u64)(*p)&(__u64)0x000000000000ff00ULL)<<40)|(((__u64)(*p)&(__u64)0x0000000000ff0000ULL)<<24)|(((__u64)(*p)&(__u64)0x00000000ff000000ULL)<<8)|(((__u64)(*p)&(__u64)0x000000ff00000000ULL)>>8)|(((__u64)(*p)&(__u64)0x0000ff0000000000ULL)>>24)|(((__u64)(*p)&(__u64)0x00ff000000000000ULL)>>40)|(((__u64)(*p)&(__u64)0xff00000000000000ULL)>>56))):__fswab64(*p))'
   include/uapi/linux/swab.h:194: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:202: Error: bad instruction `static inline __u32 __swahw32p(const __u32*p)'
   include/uapi/linux/swab.h:203: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:207: Error: bad instruction `return (__builtin_constant_p((__u32)(*p))?((__u32)((((__u32)(*p)&(__u32)0x0000ffffUL)<<16)|(((__u32)(*p)&(__u32)0xffff0000UL)>>16))):__fswahw32(*p))'
   include/uapi/linux/swab.h:209: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:217: Error: bad instruction `static inline __u32 __swahb32p(const __u32*p)'
   include/uapi/linux/swab.h:218: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:222: Error: bad instruction `return (__builtin_constant_p((__u32)(*p))?((__u32)((((__u32)(*p)&(__u32)0x00ff00ffUL)<<8)|(((__u32)(*p)&(__u32)0xff00ff00UL)>>8))):__fswahb32(*p))'
   include/uapi/linux/swab.h:224: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:230: Error: bad instruction `static inline void __swab16s(__u16*p)'
   include/uapi/linux/swab.h:231: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:235: Error: junk at end of line, first unrecognized character is `*'
   include/uapi/linux/swab.h:237: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:242: Error: bad instruction `static inline void __swab32s(__u32*p)'
   include/uapi/linux/swab.h:243: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:247: Error: junk at end of line, first unrecognized character is `*'
   include/uapi/linux/swab.h:249: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:255: Error: bad instruction `static inline void __swab64s(__u64*p)'
   include/uapi/linux/swab.h:256: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:260: Error: junk at end of line, first unrecognized character is `*'
   include/uapi/linux/swab.h:262: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:270: Error: bad instruction `static inline void __swahw32s(__u32*p)'
   include/uapi/linux/swab.h:271: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:275: Error: junk at end of line, first unrecognized character is `*'
   include/uapi/linux/swab.h:277: Error: junk at end of line, first unrecognized character is `}'
   include/uapi/linux/swab.h:285: Error: bad instruction `static inline void __swahb32s(__u32*p)'
   include/uapi/linux/swab.h:286: Error: junk at end of line, first unrecognized character is `{'
   include/uapi/linux/swab.h:290: Error: junk at end of line, first unrecognized character is `*'
   include/uapi/linux/swab.h:292: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/byteorder/little_endian.h:44: Error: bad instruction `static inline __le64 __cpu_to_le64p(const __u64*p)'
>> include/uapi/linux/byteorder/little_endian.h:45: Error: junk at end of line, first unrecognized character is `{'
>> include/uapi/linux/byteorder/little_endian.h:46: Error: bad instruction `return (__force __le64)*p'
   include/uapi/linux/byteorder/little_endian.h:47: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/byteorder/little_endian.h:48: Error: bad instruction `static inline __u64 __le64_to_cpup(const __le64*p)'
   include/uapi/linux/byteorder/little_endian.h:49: Error: junk at end of line, first unrecognized character is `{'
>> include/uapi/linux/byteorder/little_endian.h:50: Error: bad instruction `return (__force __u64)*p'
   include/uapi/linux/byteorder/little_endian.h:51: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/byteorder/little_endian.h:52: Error: bad instruction `static inline __le32 __cpu_to_le32p(const __u32*p)'
   include/uapi/linux/byteorder/little_endian.h:53: Error: junk at end of line, first unrecognized character is `{'
>> include/uapi/linux/byteorder/little_endian.h:54: Error: bad instruction `return (__force __le32)*p'
   include/uapi/linux/byteorder/little_endian.h:55: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/byteorder/little_endian.h:56: Error: bad instruction `static inline __u32 __le32_to_cpup(const __le32*p)'
   include/uapi/linux/byteorder/little_endian.h:57: Error: junk at end of line, first unrecognized character is `{'
>> include/uapi/linux/byteorder/little_endian.h:58: Error: bad instruction `return (__force __u32)*p'
   include/uapi/linux/byteorder/little_endian.h:59: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/byteorder/little_endian.h:60: Error: bad instruction `static inline __le16 __cpu_to_le16p(const __u16*p)'
   include/uapi/linux/byteorder/little_endian.h:61: Error: junk at end of line, first unrecognized character is `{'
>> include/uapi/linux/byteorder/little_endian.h:62: Error: bad instruction `return (__force __le16)*p'
   include/uapi/linux/byteorder/little_endian.h:63: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/byteorder/little_endian.h:64: Error: bad instruction `static inline __u16 __le16_to_cpup(const __le16*p)'
   include/uapi/linux/byteorder/little_endian.h:65: Error: junk at end of line, first unrecognized character is `{'
>> include/uapi/linux/byteorder/little_endian.h:66: Error: bad instruction `return (__force __u16)*p'
   include/uapi/linux/byteorder/little_endian.h:67: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/byteorder/little_endian.h:68: Error: bad instruction `static inline __be64 __cpu_to_be64p(const __u64*p)'
   include/uapi/linux/byteorder/little_endian.h:69: Error: junk at end of line, first unrecognized character is `{'
>> include/uapi/linux/byteorder/little_endian.h:70: Error: bad instruction `return (__force __be64)__swab64p(p)'
   include/uapi/linux/byteorder/little_endian.h:71: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/byteorder/little_endian.h:72: Error: bad instruction `static inline __u64 __be64_to_cpup(const __be64*p)'
   include/uapi/linux/byteorder/little_endian.h:73: Error: junk at end of line, first unrecognized character is `{'
>> include/uapi/linux/byteorder/little_endian.h:74: Error: bad instruction `return __swab64p((__u64*)p)'
   include/uapi/linux/byteorder/little_endian.h:75: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/byteorder/little_endian.h:76: Error: bad instruction `static inline __be32 __cpu_to_be32p(const __u32*p)'
   include/uapi/linux/byteorder/little_endian.h:77: Error: junk at end of line, first unrecognized character is `{'
>> include/uapi/linux/byteorder/little_endian.h:78: Error: bad instruction `return (__force __be32)__swab32p(p)'
   include/uapi/linux/byteorder/little_endian.h:79: Error: junk at end of line, first unrecognized character is `}'
>> include/uapi/linux/byteorder/little_endian.h:80: Error: bad instruction `static inline __u32 __be32_to_cpup(const __be32*p)'
   include/uapi/linux/byteorder/little_endian.h:81: Error: junk at end of line, first unrecognized character is `{'

vim +44 include/uapi/linux/byteorder/little_endian.h

5921e6f8 David Howells  2012-10-13   43  
bc27fb68 Denys Vlasenko 2016-03-17  @44  static __always_inline __le64 __cpu_to_le64p(const __u64 *p)
5921e6f8 David Howells  2012-10-13  @45  {
5921e6f8 David Howells  2012-10-13  @46  	return (__force __le64)*p;
5921e6f8 David Howells  2012-10-13  @47  }
bc27fb68 Denys Vlasenko 2016-03-17  @48  static __always_inline __u64 __le64_to_cpup(const __le64 *p)
5921e6f8 David Howells  2012-10-13  @49  {
5921e6f8 David Howells  2012-10-13  @50  	return (__force __u64)*p;
5921e6f8 David Howells  2012-10-13  @51  }
bc27fb68 Denys Vlasenko 2016-03-17  @52  static __always_inline __le32 __cpu_to_le32p(const __u32 *p)
5921e6f8 David Howells  2012-10-13  @53  {
5921e6f8 David Howells  2012-10-13  @54  	return (__force __le32)*p;
5921e6f8 David Howells  2012-10-13  @55  }
bc27fb68 Denys Vlasenko 2016-03-17  @56  static __always_inline __u32 __le32_to_cpup(const __le32 *p)
5921e6f8 David Howells  2012-10-13  @57  {
5921e6f8 David Howells  2012-10-13  @58  	return (__force __u32)*p;
5921e6f8 David Howells  2012-10-13  @59  }
bc27fb68 Denys Vlasenko 2016-03-17  @60  static __always_inline __le16 __cpu_to_le16p(const __u16 *p)
5921e6f8 David Howells  2012-10-13  @61  {
5921e6f8 David Howells  2012-10-13  @62  	return (__force __le16)*p;
5921e6f8 David Howells  2012-10-13  @63  }
bc27fb68 Denys Vlasenko 2016-03-17  @64  static __always_inline __u16 __le16_to_cpup(const __le16 *p)
5921e6f8 David Howells  2012-10-13  @65  {
5921e6f8 David Howells  2012-10-13  @66  	return (__force __u16)*p;
5921e6f8 David Howells  2012-10-13  @67  }
bc27fb68 Denys Vlasenko 2016-03-17  @68  static __always_inline __be64 __cpu_to_be64p(const __u64 *p)
5921e6f8 David Howells  2012-10-13  @69  {
5921e6f8 David Howells  2012-10-13  @70  	return (__force __be64)__swab64p(p);
5921e6f8 David Howells  2012-10-13  @71  }
bc27fb68 Denys Vlasenko 2016-03-17  @72  static __always_inline __u64 __be64_to_cpup(const __be64 *p)
5921e6f8 David Howells  2012-10-13  @73  {
5921e6f8 David Howells  2012-10-13  @74  	return __swab64p((__u64 *)p);
5921e6f8 David Howells  2012-10-13  @75  }
bc27fb68 Denys Vlasenko 2016-03-17  @76  static __always_inline __be32 __cpu_to_be32p(const __u32 *p)
5921e6f8 David Howells  2012-10-13  @77  {
5921e6f8 David Howells  2012-10-13  @78  	return (__force __be32)__swab32p(p);
5921e6f8 David Howells  2012-10-13  @79  }
bc27fb68 Denys Vlasenko 2016-03-17  @80  static __always_inline __u32 __be32_to_cpup(const __be32 *p)
5921e6f8 David Howells  2012-10-13  @81  {
5921e6f8 David Howells  2012-10-13  @82  	return __swab32p((__u32 *)p);
5921e6f8 David Howells  2012-10-13   83  }
bc27fb68 Denys Vlasenko 2016-03-17  @84  static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
5921e6f8 David Howells  2012-10-13   85  {
5921e6f8 David Howells  2012-10-13  @86  	return (__force __be16)__swab16p(p);
5921e6f8 David Howells  2012-10-13   87  }
bc27fb68 Denys Vlasenko 2016-03-17  @88  static __always_inline __u16 __be16_to_cpup(const __be16 *p)
5921e6f8 David Howells  2012-10-13   89  {
5921e6f8 David Howells  2012-10-13  @90  	return __swab16p((__u16 *)p);
5921e6f8 David Howells  2012-10-13   91  }
5921e6f8 David Howells  2012-10-13   92  #define __cpu_to_le64s(x) do { (void)(x); } while (0)
5921e6f8 David Howells  2012-10-13   93  #define __le64_to_cpus(x) do { (void)(x); } while (0)
5921e6f8 David Howells  2012-10-13   94  #define __cpu_to_le32s(x) do { (void)(x); } while (0)
5921e6f8 David Howells  2012-10-13   95  #define __le32_to_cpus(x) do { (void)(x); } while (0)
5921e6f8 David Howells  2012-10-13   96  #define __cpu_to_le16s(x) do { (void)(x); } while (0)
5921e6f8 David Howells  2012-10-13   97  #define __le16_to_cpus(x) do { (void)(x); } while (0)
5921e6f8 David Howells  2012-10-13   98  #define __cpu_to_be64s(x) __swab64s((x))
5921e6f8 David Howells  2012-10-13   99  #define __be64_to_cpus(x) __swab64s((x))
5921e6f8 David Howells  2012-10-13  100  #define __cpu_to_be32s(x) __swab32s((x))
5921e6f8 David Howells  2012-10-13  101  #define __be32_to_cpus(x) __swab32s((x))
5921e6f8 David Howells  2012-10-13  102  #define __cpu_to_be16s(x) __swab16s((x))
5921e6f8 David Howells  2012-10-13  103  #define __be16_to_cpus(x) __swab16s((x))
5921e6f8 David Howells  2012-10-13  104  
5921e6f8 David Howells  2012-10-13  105  

:::::: The code at line 44 was first introduced by commit
:::::: bc27fb68aaad44dd8f5c34924f05721f0abaeec1 include/uapi/linux/byteorder, swab: force inlining of some byteswap operations

:::::: TO: Denys Vlasenko <dvlasenk@redhat.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 22719 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180417/c68be042/attachment-0001.gz>
