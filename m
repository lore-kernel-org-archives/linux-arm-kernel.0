From: lkp@intel.com (kbuild test robot)
Date: Tue, 5 Jun 2018 04:03:09 +0800
Subject: [PATCH v1 2/2] arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS
In-Reply-To: <1527772139-19665-3-git-send-email-gengdongjiu@huawei.com>
References: <1527772139-19665-3-git-send-email-gengdongjiu@huawei.com>
Message-ID: <201806050348.zuDr8Gzx%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dongjiu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.17 next-20180601]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dongjiu-Geng/arm64-KVM-export-the-capability-to-set-guest-SError-syndrome/20180602-175846
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm-axm55xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/kvm_host.h:37:0,
                    from arch/arm/kvm/guest.c:21:
   arch/arm/include/asm/kvm_host.h:217:11: warning: 'struct kvm_vcpu_events' declared inside parameter list will not be visible outside of this definition or declaration
       struct kvm_vcpu_events *events);
              ^~~~~~~~~~~~~~~
   arch/arm/include/asm/kvm_host.h:220:11: warning: 'struct kvm_vcpu_events' declared inside parameter list will not be visible outside of this definition or declaration
       struct kvm_vcpu_events *events);
              ^~~~~~~~~~~~~~~
>> arch/arm/kvm/guest.c:265:11: warning: 'struct kvm_vcpu_events' declared inside parameter list will not be visible outside of this definition or declaration
       struct kvm_vcpu_events *events)
              ^~~~~~~~~~~~~~~
>> arch/arm/kvm/guest.c:264:5: error: conflicting types for 'kvm_arm_vcpu_get_events'
    int kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
        ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kvm_host.h:37:0,
                    from arch/arm/kvm/guest.c:21:
   arch/arm/include/asm/kvm_host.h:216:5: note: previous declaration of 'kvm_arm_vcpu_get_events' was here
    int kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
        ^~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/kvm/guest.c:271:11: warning: 'struct kvm_vcpu_events' declared inside parameter list will not be visible outside of this definition or declaration
       struct kvm_vcpu_events *events)
              ^~~~~~~~~~~~~~~
>> arch/arm/kvm/guest.c:270:5: error: conflicting types for 'kvm_arm_vcpu_set_events'
    int kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
        ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kvm_host.h:37:0,
                    from arch/arm/kvm/guest.c:21:
   arch/arm/include/asm/kvm_host.h:219:5: note: previous declaration of 'kvm_arm_vcpu_set_events' was here
    int kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
        ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/kvm_host.h:37:0,
                    from arch/arm/kvm/../../../virt/kvm/arm/arm.c:22:
   arch/arm/include/asm/kvm_host.h:217:11: warning: 'struct kvm_vcpu_events' declared inside parameter list will not be visible outside of this definition or declaration
       struct kvm_vcpu_events *events);
              ^~~~~~~~~~~~~~~
   arch/arm/include/asm/kvm_host.h:220:11: warning: 'struct kvm_vcpu_events' declared inside parameter list will not be visible outside of this definition or declaration
       struct kvm_vcpu_events *events);
              ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/ioctl.h:5:0,
                    from ./arch/arm/include/generated/uapi/asm/ioctl.h:1,
                    from include/uapi/linux/ioctl.h:5,
                    from include/uapi/linux/fs.h:14,
                    from include/linux/fs.h:41,
                    from include/linux/huge_mm.h:7,
                    from include/linux/mm.h:472,
                    from include/linux/kvm_host.h:17,
                    from arch/arm/kvm/../../../virt/kvm/arm/arm.c:22:
   arch/arm/kvm/../../../virt/kvm/arm/arm.c: In function 'kvm_arch_vcpu_ioctl':
>> include/uapi/linux/kvm.h:1339:54: error: invalid application of 'sizeof' to incomplete type 'struct kvm_vcpu_events'
    #define KVM_GET_VCPU_EVENTS       _IOR(KVMIO,  0x9f, struct kvm_vcpu_events)
                                                         ^
   include/uapi/asm-generic/ioctl.h:73:5: note: in definition of macro '_IOC'
      ((size) << _IOC_SIZESHIFT))
        ^~~~
>> include/uapi/asm-generic/ioctl.h:86:56: note: in expansion of macro '_IOC_TYPECHECK'
    #define _IOR(type,nr,size) _IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))
                                                           ^~~~~~~~~~~~~~
>> include/uapi/linux/kvm.h:1339:35: note: in expansion of macro '_IOR'
    #define KVM_GET_VCPU_EVENTS       _IOR(KVMIO,  0x9f, struct kvm_vcpu_events)
                                      ^~~~
>> arch/arm/kvm/../../../virt/kvm/arm/arm.c:1110:7: note: in expansion of macro 'KVM_GET_VCPU_EVENTS'
     case KVM_GET_VCPU_EVENTS: {
          ^~~~~~~~~~~~~~~~~~~
>> include/asm-generic/ioctl.h:13:25: error: array type has incomplete element type 'struct kvm_vcpu_events'
     ((sizeof(t) == sizeof(t[1]) && \
                            ^
   include/uapi/asm-generic/ioctl.h:73:5: note: in definition of macro '_IOC'
      ((size) << _IOC_SIZESHIFT))
        ^~~~
>> include/uapi/asm-generic/ioctl.h:86:56: note: in expansion of macro '_IOC_TYPECHECK'
    #define _IOR(type,nr,size) _IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))
                                                           ^~~~~~~~~~~~~~
>> include/uapi/linux/kvm.h:1339:35: note: in expansion of macro '_IOR'
    #define KVM_GET_VCPU_EVENTS       _IOR(KVMIO,  0x9f, struct kvm_vcpu_events)
                                      ^~~~
>> arch/arm/kvm/../../../virt/kvm/arm/arm.c:1110:7: note: in expansion of macro 'KVM_GET_VCPU_EVENTS'
     case KVM_GET_VCPU_EVENTS: {
          ^~~~~~~~~~~~~~~~~~~
>> include/uapi/linux/kvm.h:1339:54: error: invalid application of 'sizeof' to incomplete type 'struct kvm_vcpu_events'
    #define KVM_GET_VCPU_EVENTS       _IOR(KVMIO,  0x9f, struct kvm_vcpu_events)
                                                         ^
   include/uapi/asm-generic/ioctl.h:73:5: note: in definition of macro '_IOC'
      ((size) << _IOC_SIZESHIFT))
        ^~~~
>> include/uapi/asm-generic/ioctl.h:86:56: note: in expansion of macro '_IOC_TYPECHECK'
    #define _IOR(type,nr,size) _IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))
                                                           ^~~~~~~~~~~~~~
>> include/uapi/linux/kvm.h:1339:35: note: in expansion of macro '_IOR'
    #define KVM_GET_VCPU_EVENTS       _IOR(KVMIO,  0x9f, struct kvm_vcpu_events)
                                      ^~~~
>> arch/arm/kvm/../../../virt/kvm/arm/arm.c:1110:7: note: in expansion of macro 'KVM_GET_VCPU_EVENTS'
     case KVM_GET_VCPU_EVENTS: {
          ^~~~~~~~~~~~~~~~~~~
>> include/uapi/linux/kvm.h:1339:54: error: invalid application of 'sizeof' to incomplete type 'struct kvm_vcpu_events'
    #define KVM_GET_VCPU_EVENTS       _IOR(KVMIO,  0x9f, struct kvm_vcpu_events)
                                                         ^
   include/uapi/asm-generic/ioctl.h:73:5: note: in definition of macro '_IOC'
      ((size) << _IOC_SIZESHIFT))
        ^~~~
>> include/uapi/asm-generic/ioctl.h:86:56: note: in expansion of macro '_IOC_TYPECHECK'
    #define _IOR(type,nr,size) _IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))
                                                           ^~~~~~~~~~~~~~
>> include/uapi/linux/kvm.h:1339:35: note: in expansion of macro '_IOR'
    #define KVM_GET_VCPU_EVENTS       _IOR(KVMIO,  0x9f, struct kvm_vcpu_events)
                                      ^~~~
>> arch/arm/kvm/../../../virt/kvm/arm/arm.c:1110:7: note: in expansion of macro 'KVM_GET_VCPU_EVENTS'
     case KVM_GET_VCPU_EVENTS: {
          ^~~~~~~~~~~~~~~~~~~
>> arch/arm/kvm/../../../virt/kvm/arm/arm.c:1111:26: error: storage size of 'events' isn't known
      struct kvm_vcpu_events events;
                             ^~~~~~
   arch/arm/kvm/../../../virt/kvm/arm/arm.c:1111:26: warning: unused variable 'events' [-Wunused-variable]
   In file included from include/asm-generic/ioctl.h:5:0,
                    from ./arch/arm/include/generated/uapi/asm/ioctl.h:1,
                    from include/uapi/linux/ioctl.h:5,
                    from include/uapi/linux/fs.h:14,
                    from include/linux/fs.h:41,
                    from include/linux/huge_mm.h:7,
                    from include/linux/mm.h:472,
                    from include/linux/kvm_host.h:17,
                    from arch/arm/kvm/../../../virt/kvm/arm/arm.c:22:
   include/uapi/linux/kvm.h:1340:54: error: invalid application of 'sizeof' to incomplete type 'struct kvm_vcpu_events'
    #define KVM_SET_VCPU_EVENTS       _IOW(KVMIO,  0xa0, struct kvm_vcpu_events)
                                                         ^
   include/uapi/asm-generic/ioctl.h:73:5: note: in definition of macro '_IOC'
      ((size) << _IOC_SIZESHIFT))
        ^~~~
   include/uapi/asm-generic/ioctl.h:87:57: note: in expansion of macro '_IOC_TYPECHECK'
    #define _IOW(type,nr,size) _IOC(_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
                                                            ^~~~~~~~~~~~~~
>> include/uapi/linux/kvm.h:1340:35: note: in expansion of macro '_IOW'
    #define KVM_SET_VCPU_EVENTS       _IOW(KVMIO,  0xa0, struct kvm_vcpu_events)
                                      ^~~~
>> arch/arm/kvm/../../../virt/kvm/arm/arm.c:1122:7: note: in expansion of macro 'KVM_SET_VCPU_EVENTS'
     case KVM_SET_VCPU_EVENTS: {
          ^~~~~~~~~~~~~~~~~~~
>> include/asm-generic/ioctl.h:13:25: error: array type has incomplete element type 'struct kvm_vcpu_events'
     ((sizeof(t) == sizeof(t[1]) && \
                            ^
   include/uapi/asm-generic/ioctl.h:73:5: note: in definition of macro '_IOC'
      ((size) << _IOC_SIZESHIFT))
        ^~~~
   include/uapi/asm-generic/ioctl.h:87:57: note: in expansion of macro '_IOC_TYPECHECK'
    #define _IOW(type,nr,size) _IOC(_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
                                                            ^~~~~~~~~~~~~~

vim +/kvm_arm_vcpu_get_events +264 arch/arm/kvm/guest.c

   263	
 > 264	int kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
 > 265				struct kvm_vcpu_events *events)
   266	{
   267		return -EINVAL;
   268	}
   269	
 > 270	int kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
   271				struct kvm_vcpu_events *events)
   272	{
   273		return -EINVAL;
   274	}
   275	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 19855 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180605/6b38d0bc/attachment-0001.gz>
