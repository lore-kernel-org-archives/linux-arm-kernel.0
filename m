From: lkp@intel.com (kbuild test robot)
Date: Fri, 16 Sep 2016 16:42:18 +0800
Subject: [PATCH] KVM: arm/arm64: Route vtimer events to user space
In-Reply-To: <1473981320-25387-1-git-send-email-agraf@suse.de>
Message-ID: <201609161647.A197p5ym%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

[auto build test ERROR on kvm/linux-next]
[also build test ERROR on v4.8-rc6 next-20160916]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Alexander-Graf/KVM-arm-arm64-Route-vtimer-events-to-user-space/20160916-073838
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git linux-next
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All error/warnings (new ones prefixed by >>):

   arch/arm64/kvm/../../../arch/arm/kvm/arm.c: In function 'kvm_arch_vcpu_ioctl':
>> arch/arm64/kvm/../../../arch/arm/kvm/arm.c:1000:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
    ^
>> arch/arm64/kvm/../../../arch/arm/kvm/arm.c:1016:12: error: invalid storage class for function 'kvm_vm_ioctl_set_device_addr'
    static int kvm_vm_ioctl_set_device_addr(struct kvm *kvm,
               ^
>> arch/arm64/kvm/../../../arch/arm/kvm/arm.c:1077:13: error: invalid storage class for function 'cpu_init_hyp_mode'
    static void cpu_init_hyp_mode(void *dummy)
                ^
>> arch/arm64/kvm/../../../arch/arm/kvm/arm.c:1098:13: error: invalid storage class for function 'cpu_hyp_reinit'
    static void cpu_hyp_reinit(void)
                ^
>> arch/arm64/kvm/../../../arch/arm/kvm/arm.c:1112:13: error: invalid storage class for function 'cpu_hyp_reset'
    static void cpu_hyp_reset(void)
                ^
>> arch/arm64/kvm/../../../arch/arm/kvm/arm.c:1119:13: error: invalid storage class for function '_kvm_arch_hardware_enable'
    static void _kvm_arch_hardware_enable(void *discard)
                ^
>> arch/arm64/kvm/../../../arch/arm/kvm/arm.c:1133:13: error: invalid storage class for function '_kvm_arch_hardware_disable'
    static void _kvm_arch_hardware_disable(void *discard)
                ^
>> arch/arm64/kvm/../../../arch/arm/kvm/arm.c:1147:12: error: invalid storage class for function 'hyp_init_cpu_pm_notifier'
    static int hyp_init_cpu_pm_notifier(struct notifier_block *self,
               ^
>> arch/arm64/kvm/../../../arch/arm/kvm/arm.c:1180:19: error: initializer element is not constant
     .notifier_call = hyp_init_cpu_pm_notifier,
                      ^
   arch/arm64/kvm/../../../arch/arm/kvm/arm.c:1180:19: note: (near initialization for 'hyp_init_cpu_pm_nb.notifier_call')
>> arch/arm64/kvm/../../../arch/arm/kvm/arm.c:1183:20: error: invalid storage class for function 'hyp_cpu_pm_init'
    static void __init hyp_cpu_pm_init(void)
                       ^
>> arch/arm64/kvm/../../../arch/arm/kvm/arm.c:1187:20: error: invalid storage class for function 'hyp_cpu_pm_exit'
    static void __init hyp_cpu_pm_exit(void)
                       ^
>> arch/arm64/kvm/../../../arch/arm/kvm/arm.c:1200:13: error: invalid storage class for function 'teardown_common_resources'
    static void teardown_common_resources(void)
                ^
>> arch/arm64/kvm/../../../arch/arm/kvm/arm.c:1205:12: error: invalid storage class for function 'init_common_resources'
    static int init_common_resources(void)
               ^
>> arch/arm64/kvm/../../../arch/arm/kvm/arm.c:1216:12: error: invalid storage class for function 'init_subsystems'
    static int init_subsystems(void)
               ^
>> arch/arm64/kvm/../../../arch/arm/kvm/arm.c:1263:13: error: invalid storage class for function 'teardown_hyp_mode'
    static void teardown_hyp_mode(void)
                ^
>> arch/arm64/kvm/../../../arch/arm/kvm/arm.c:1276:12: error: invalid storage class for function 'init_vhe_mode'
    static int init_vhe_mode(void)
               ^
>> arch/arm64/kvm/../../../arch/arm/kvm/arm.c:1289:12: error: invalid storage class for function 'init_hyp_mode'
    static int init_hyp_mode(void)
               ^
>> arch/arm64/kvm/../../../arch/arm/kvm/arm.c:1379:13: error: invalid storage class for function 'check_kvm_target_cpu'
    static void check_kvm_target_cpu(void *ret)
                ^
>> arch/arm64/kvm/../../../arch/arm/kvm/arm.c:1448:12: error: invalid storage class for function 'arm_init'
    static int arm_init(void)
               ^
   In file included from include/linux/printk.h:5:0,
                    from include/linux/kernel.h:13,
                    from include/linux/cpu_pm.h:21,
                    from arch/arm64/kvm/../../../arch/arm/kvm/arm.c:19:
   arch/arm64/kvm/../../../arch/arm/kvm/arm.c:1454:13: error: initializer element is not constant
    module_init(arm_init);
                ^
   include/linux/init.h:182:58: note: in definition of macro '__define_initcall'
     __attribute__((__section__(".initcall" #id ".init"))) = fn; \
                                                             ^
   include/linux/init.h:217:24: note: in expansion of macro 'device_initcall'
    #define __initcall(fn) device_initcall(fn)
                           ^
   include/linux/module.h:86:24: note: in expansion of macro '__initcall'
    #define module_init(x) __initcall(x);
                           ^
>> arch/arm64/kvm/../../../arch/arm/kvm/arm.c:1454:1: note: in expansion of macro 'module_init'
    module_init(arm_init);
    ^

vim +/kvm_vm_ioctl_set_device_addr +1016 arch/arm64/kvm/../../../arch/arm/kvm/arm.c

53c810c36 Mario Smarduch    2015-01-15   994   *
53c810c36 Mario Smarduch    2015-01-15   995   *   1. Take a snapshot of the bit and clear it if needed.
53c810c36 Mario Smarduch    2015-01-15   996   *   2. Write protect the corresponding page.
53c810c36 Mario Smarduch    2015-01-15   997   *   3. Copy the snapshot to the userspace.
53c810c36 Mario Smarduch    2015-01-15   998   *   4. Flush TLB's if needed.
53c810c36 Mario Smarduch    2015-01-15   999   */
749cf76c5 Christoffer Dall  2013-01-20 @1000  int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
749cf76c5 Christoffer Dall  2013-01-20  1001  {
53c810c36 Mario Smarduch    2015-01-15  1002  	bool is_dirty = false;
53c810c36 Mario Smarduch    2015-01-15  1003  	int r;
53c810c36 Mario Smarduch    2015-01-15  1004  
53c810c36 Mario Smarduch    2015-01-15  1005  	mutex_lock(&kvm->slots_lock);
53c810c36 Mario Smarduch    2015-01-15  1006  
53c810c36 Mario Smarduch    2015-01-15  1007  	r = kvm_get_dirty_log_protect(kvm, log, &is_dirty);
53c810c36 Mario Smarduch    2015-01-15  1008  
53c810c36 Mario Smarduch    2015-01-15  1009  	if (is_dirty)
53c810c36 Mario Smarduch    2015-01-15  1010  		kvm_flush_remote_tlbs(kvm);
53c810c36 Mario Smarduch    2015-01-15  1011  
53c810c36 Mario Smarduch    2015-01-15  1012  	mutex_unlock(&kvm->slots_lock);
53c810c36 Mario Smarduch    2015-01-15  1013  	return r;
749cf76c5 Christoffer Dall  2013-01-20  1014  }
749cf76c5 Christoffer Dall  2013-01-20  1015  
3401d5469 Christoffer Dall  2013-01-23 @1016  static int kvm_vm_ioctl_set_device_addr(struct kvm *kvm,
3401d5469 Christoffer Dall  2013-01-23  1017  					struct kvm_arm_device_addr *dev_addr)
3401d5469 Christoffer Dall  2013-01-23  1018  {
330690cdc Christoffer Dall  2013-01-21  1019  	unsigned long dev_id, type;
330690cdc Christoffer Dall  2013-01-21  1020  
330690cdc Christoffer Dall  2013-01-21  1021  	dev_id = (dev_addr->id & KVM_ARM_DEVICE_ID_MASK) >>
330690cdc Christoffer Dall  2013-01-21  1022  		KVM_ARM_DEVICE_ID_SHIFT;
330690cdc Christoffer Dall  2013-01-21  1023  	type = (dev_addr->id & KVM_ARM_DEVICE_TYPE_MASK) >>
330690cdc Christoffer Dall  2013-01-21  1024  		KVM_ARM_DEVICE_TYPE_SHIFT;
330690cdc Christoffer Dall  2013-01-21  1025  
330690cdc Christoffer Dall  2013-01-21  1026  	switch (dev_id) {
330690cdc Christoffer Dall  2013-01-21  1027  	case KVM_ARM_DEVICE_VGIC_V2:
c7da6fa43 Pavel Fedin       2015-12-18  1028  		if (!vgic_present)
c7da6fa43 Pavel Fedin       2015-12-18  1029  			return -ENXIO;
ce01e4e88 Christoffer Dall  2013-09-23  1030  		return kvm_vgic_addr(kvm, type, &dev_addr->addr, true);
330690cdc Christoffer Dall  2013-01-21  1031  	default:
3401d5469 Christoffer Dall  2013-01-23  1032  		return -ENODEV;
3401d5469 Christoffer Dall  2013-01-23  1033  	}
330690cdc Christoffer Dall  2013-01-21  1034  }
3401d5469 Christoffer Dall  2013-01-23  1035  
749cf76c5 Christoffer Dall  2013-01-20  1036  long kvm_arch_vm_ioctl(struct file *filp,
749cf76c5 Christoffer Dall  2013-01-20  1037  		       unsigned int ioctl, unsigned long arg)
749cf76c5 Christoffer Dall  2013-01-20  1038  {
3401d5469 Christoffer Dall  2013-01-23  1039  	struct kvm *kvm = filp->private_data;
3401d5469 Christoffer Dall  2013-01-23  1040  	void __user *argp = (void __user *)arg;
3401d5469 Christoffer Dall  2013-01-23  1041  
3401d5469 Christoffer Dall  2013-01-23  1042  	switch (ioctl) {
5863c2ce7 Marc Zyngier      2013-01-21  1043  	case KVM_CREATE_IRQCHIP: {
a28ebea2a Christoffer Dall  2016-08-09  1044  		int ret;
c7da6fa43 Pavel Fedin       2015-12-18  1045  		if (!vgic_present)
c7da6fa43 Pavel Fedin       2015-12-18  1046  			return -ENXIO;
a28ebea2a Christoffer Dall  2016-08-09  1047  		mutex_lock(&kvm->lock);
a28ebea2a Christoffer Dall  2016-08-09  1048  		ret = kvm_vgic_create(kvm, KVM_DEV_TYPE_ARM_VGIC_V2);
a28ebea2a Christoffer Dall  2016-08-09  1049  		mutex_unlock(&kvm->lock);
a28ebea2a Christoffer Dall  2016-08-09  1050  		return ret;
5863c2ce7 Marc Zyngier      2013-01-21  1051  	}
3401d5469 Christoffer Dall  2013-01-23  1052  	case KVM_ARM_SET_DEVICE_ADDR: {
3401d5469 Christoffer Dall  2013-01-23  1053  		struct kvm_arm_device_addr dev_addr;
3401d5469 Christoffer Dall  2013-01-23  1054  
3401d5469 Christoffer Dall  2013-01-23  1055  		if (copy_from_user(&dev_addr, argp, sizeof(dev_addr)))
3401d5469 Christoffer Dall  2013-01-23  1056  			return -EFAULT;
3401d5469 Christoffer Dall  2013-01-23  1057  		return kvm_vm_ioctl_set_device_addr(kvm, &dev_addr);
3401d5469 Christoffer Dall  2013-01-23  1058  	}
42c4e0c77 Anup Patel        2013-09-30  1059  	case KVM_ARM_PREFERRED_TARGET: {
42c4e0c77 Anup Patel        2013-09-30  1060  		int err;
42c4e0c77 Anup Patel        2013-09-30  1061  		struct kvm_vcpu_init init;
42c4e0c77 Anup Patel        2013-09-30  1062  
42c4e0c77 Anup Patel        2013-09-30  1063  		err = kvm_vcpu_preferred_target(&init);
42c4e0c77 Anup Patel        2013-09-30  1064  		if (err)
42c4e0c77 Anup Patel        2013-09-30  1065  			return err;
42c4e0c77 Anup Patel        2013-09-30  1066  
42c4e0c77 Anup Patel        2013-09-30  1067  		if (copy_to_user(argp, &init, sizeof(init)))
42c4e0c77 Anup Patel        2013-09-30  1068  			return -EFAULT;
42c4e0c77 Anup Patel        2013-09-30  1069  
42c4e0c77 Anup Patel        2013-09-30  1070  		return 0;
42c4e0c77 Anup Patel        2013-09-30  1071  	}
3401d5469 Christoffer Dall  2013-01-23  1072  	default:
749cf76c5 Christoffer Dall  2013-01-20  1073  		return -EINVAL;
749cf76c5 Christoffer Dall  2013-01-20  1074  	}
3401d5469 Christoffer Dall  2013-01-23  1075  }
749cf76c5 Christoffer Dall  2013-01-20  1076  
d157f4a51 Marc Zyngier      2013-04-12 @1077  static void cpu_init_hyp_mode(void *dummy)
342cd0ab0 Christoffer Dall  2013-01-20  1078  {
dac288f7b Marc Zyngier      2013-05-14  1079  	phys_addr_t pgd_ptr;
342cd0ab0 Christoffer Dall  2013-01-20  1080  	unsigned long hyp_stack_ptr;
342cd0ab0 Christoffer Dall  2013-01-20  1081  	unsigned long stack_page;
342cd0ab0 Christoffer Dall  2013-01-20  1082  	unsigned long vector_ptr;
342cd0ab0 Christoffer Dall  2013-01-20  1083  
342cd0ab0 Christoffer Dall  2013-01-20  1084  	/* Switch from the HYP stub to our own HYP init vector */
5a677ce04 Marc Zyngier      2013-04-12  1085  	__hyp_set_vectors(kvm_get_idmap_vector());
342cd0ab0 Christoffer Dall  2013-01-20  1086  
dac288f7b Marc Zyngier      2013-05-14  1087  	pgd_ptr = kvm_mmu_get_httbr();
1436c1aa6 Christoph Lameter 2013-10-21  1088  	stack_page = __this_cpu_read(kvm_arm_hyp_stack_page);
342cd0ab0 Christoffer Dall  2013-01-20  1089  	hyp_stack_ptr = stack_page + PAGE_SIZE;
a0bf9776c Ard Biesheuvel    2016-02-16  1090  	vector_ptr = (unsigned long)kvm_ksym_ref(__kvm_hyp_vector);
342cd0ab0 Christoffer Dall  2013-01-20  1091  
12fda8123 Marc Zyngier      2016-06-30  1092  	__cpu_init_hyp_mode(pgd_ptr, hyp_stack_ptr, vector_ptr);
35a2491a6 Marc Zyngier      2016-02-01  1093  	__cpu_init_stage2();
56c7f5e77 Alex Benn?e       2015-07-07  1094  
56c7f5e77 Alex Benn?e       2015-07-07  1095  	kvm_arm_init_debug();
342cd0ab0 Christoffer Dall  2013-01-20  1096  }
342cd0ab0 Christoffer Dall  2013-01-20  1097  
5f5560b1c James Morse       2016-03-30 @1098  static void cpu_hyp_reinit(void)
5f5560b1c James Morse       2016-03-30  1099  {
5f5560b1c James Morse       2016-03-30  1100  	if (is_kernel_in_hyp_mode()) {
5f5560b1c James Morse       2016-03-30  1101  		/*
67f691976 AKASHI Takahiro   2016-04-27  1102  		 * __cpu_init_stage2() is safe to call even if the PM
5f5560b1c James Morse       2016-03-30  1103  		 * event was cancelled before the CPU was reset.
5f5560b1c James Morse       2016-03-30  1104  		 */
67f691976 AKASHI Takahiro   2016-04-27  1105  		__cpu_init_stage2();
5f5560b1c James Morse       2016-03-30  1106  	} else {
5f5560b1c James Morse       2016-03-30  1107  		if (__hyp_get_vectors() == hyp_default_vectors)
5f5560b1c James Morse       2016-03-30  1108  			cpu_init_hyp_mode(NULL);
5f5560b1c James Morse       2016-03-30  1109  	}
5f5560b1c James Morse       2016-03-30  1110  }
5f5560b1c James Morse       2016-03-30  1111  
67f691976 AKASHI Takahiro   2016-04-27 @1112  static void cpu_hyp_reset(void)
67f691976 AKASHI Takahiro   2016-04-27  1113  {
12fda8123 Marc Zyngier      2016-06-30  1114  	if (!is_kernel_in_hyp_mode())
e537ecd7e Marc Zyngier      2016-06-30  1115  		__cpu_reset_hyp_mode(hyp_default_vectors,
e537ecd7e Marc Zyngier      2016-06-30  1116  				     kvm_get_idmap_start());
67f691976 AKASHI Takahiro   2016-04-27  1117  }
67f691976 AKASHI Takahiro   2016-04-27  1118  
67f691976 AKASHI Takahiro   2016-04-27 @1119  static void _kvm_arch_hardware_enable(void *discard)
d157f4a51 Marc Zyngier      2013-04-12  1120  {
67f691976 AKASHI Takahiro   2016-04-27  1121  	if (!__this_cpu_read(kvm_arm_hardware_enabled)) {
5f5560b1c James Morse       2016-03-30  1122  		cpu_hyp_reinit();
67f691976 AKASHI Takahiro   2016-04-27  1123  		__this_cpu_write(kvm_arm_hardware_enabled, 1);
67f691976 AKASHI Takahiro   2016-04-27  1124  	}
d157f4a51 Marc Zyngier      2013-04-12  1125  }
d157f4a51 Marc Zyngier      2013-04-12  1126  
67f691976 AKASHI Takahiro   2016-04-27  1127  int kvm_arch_hardware_enable(void)
67f691976 AKASHI Takahiro   2016-04-27  1128  {
67f691976 AKASHI Takahiro   2016-04-27  1129  	_kvm_arch_hardware_enable(NULL);
67f691976 AKASHI Takahiro   2016-04-27  1130  	return 0;
342cd0ab0 Christoffer Dall  2013-01-20  1131  }
342cd0ab0 Christoffer Dall  2013-01-20  1132  
67f691976 AKASHI Takahiro   2016-04-27 @1133  static void _kvm_arch_hardware_disable(void *discard)
67f691976 AKASHI Takahiro   2016-04-27  1134  {
67f691976 AKASHI Takahiro   2016-04-27  1135  	if (__this_cpu_read(kvm_arm_hardware_enabled)) {
67f691976 AKASHI Takahiro   2016-04-27  1136  		cpu_hyp_reset();
67f691976 AKASHI Takahiro   2016-04-27  1137  		__this_cpu_write(kvm_arm_hardware_enabled, 0);
67f691976 AKASHI Takahiro   2016-04-27  1138  	}
67f691976 AKASHI Takahiro   2016-04-27  1139  }
67f691976 AKASHI Takahiro   2016-04-27  1140  
67f691976 AKASHI Takahiro   2016-04-27  1141  void kvm_arch_hardware_disable(void)
67f691976 AKASHI Takahiro   2016-04-27  1142  {
67f691976 AKASHI Takahiro   2016-04-27  1143  	_kvm_arch_hardware_disable(NULL);
67f691976 AKASHI Takahiro   2016-04-27  1144  }
d157f4a51 Marc Zyngier      2013-04-12  1145  
1fcf7ce0c Lorenzo Pieralisi 2013-08-05  1146  #ifdef CONFIG_CPU_PM
1fcf7ce0c Lorenzo Pieralisi 2013-08-05 @1147  static int hyp_init_cpu_pm_notifier(struct notifier_block *self,
1fcf7ce0c Lorenzo Pieralisi 2013-08-05  1148  				    unsigned long cmd,
1fcf7ce0c Lorenzo Pieralisi 2013-08-05  1149  				    void *v)
1fcf7ce0c Lorenzo Pieralisi 2013-08-05  1150  {
67f691976 AKASHI Takahiro   2016-04-27  1151  	/*
67f691976 AKASHI Takahiro   2016-04-27  1152  	 * kvm_arm_hardware_enabled is left with its old value over
67f691976 AKASHI Takahiro   2016-04-27  1153  	 * PM_ENTER->PM_EXIT. It is used to indicate PM_EXIT should
67f691976 AKASHI Takahiro   2016-04-27  1154  	 * re-enable hyp.
67f691976 AKASHI Takahiro   2016-04-27  1155  	 */
67f691976 AKASHI Takahiro   2016-04-27  1156  	switch (cmd) {
67f691976 AKASHI Takahiro   2016-04-27  1157  	case CPU_PM_ENTER:
67f691976 AKASHI Takahiro   2016-04-27  1158  		if (__this_cpu_read(kvm_arm_hardware_enabled))
67f691976 AKASHI Takahiro   2016-04-27  1159  			/*
67f691976 AKASHI Takahiro   2016-04-27  1160  			 * don't update kvm_arm_hardware_enabled here
67f691976 AKASHI Takahiro   2016-04-27  1161  			 * so that the hardware will be re-enabled
67f691976 AKASHI Takahiro   2016-04-27  1162  			 * when we resume. See below.
67f691976 AKASHI Takahiro   2016-04-27  1163  			 */
67f691976 AKASHI Takahiro   2016-04-27  1164  			cpu_hyp_reset();
67f691976 AKASHI Takahiro   2016-04-27  1165  
67f691976 AKASHI Takahiro   2016-04-27  1166  		return NOTIFY_OK;
67f691976 AKASHI Takahiro   2016-04-27  1167  	case CPU_PM_EXIT:
67f691976 AKASHI Takahiro   2016-04-27  1168  		if (__this_cpu_read(kvm_arm_hardware_enabled))
67f691976 AKASHI Takahiro   2016-04-27  1169  			/* The hardware was enabled before suspend. */
5f5560b1c James Morse       2016-03-30  1170  			cpu_hyp_reinit();
67f691976 AKASHI Takahiro   2016-04-27  1171  
1fcf7ce0c Lorenzo Pieralisi 2013-08-05  1172  		return NOTIFY_OK;
1fcf7ce0c Lorenzo Pieralisi 2013-08-05  1173  
67f691976 AKASHI Takahiro   2016-04-27  1174  	default:
1fcf7ce0c Lorenzo Pieralisi 2013-08-05  1175  		return NOTIFY_DONE;
1fcf7ce0c Lorenzo Pieralisi 2013-08-05  1176  	}
67f691976 AKASHI Takahiro   2016-04-27  1177  }
1fcf7ce0c Lorenzo Pieralisi 2013-08-05  1178  
1fcf7ce0c Lorenzo Pieralisi 2013-08-05  1179  static struct notifier_block hyp_init_cpu_pm_nb = {
1fcf7ce0c Lorenzo Pieralisi 2013-08-05 @1180  	.notifier_call = hyp_init_cpu_pm_notifier,
1fcf7ce0c Lorenzo Pieralisi 2013-08-05  1181  };
1fcf7ce0c Lorenzo Pieralisi 2013-08-05  1182  
1fcf7ce0c Lorenzo Pieralisi 2013-08-05 @1183  static void __init hyp_cpu_pm_init(void)
1fcf7ce0c Lorenzo Pieralisi 2013-08-05  1184  {
1fcf7ce0c Lorenzo Pieralisi 2013-08-05  1185  	cpu_pm_register_notifier(&hyp_init_cpu_pm_nb);
1fcf7ce0c Lorenzo Pieralisi 2013-08-05  1186  }
06a71a24b Sudeep Holla      2016-04-04 @1187  static void __init hyp_cpu_pm_exit(void)
06a71a24b Sudeep Holla      2016-04-04  1188  {
06a71a24b Sudeep Holla      2016-04-04  1189  	cpu_pm_unregister_notifier(&hyp_init_cpu_pm_nb);
06a71a24b Sudeep Holla      2016-04-04  1190  }
1fcf7ce0c Lorenzo Pieralisi 2013-08-05  1191  #else
1fcf7ce0c Lorenzo Pieralisi 2013-08-05  1192  static inline void hyp_cpu_pm_init(void)
1fcf7ce0c Lorenzo Pieralisi 2013-08-05  1193  {
1fcf7ce0c Lorenzo Pieralisi 2013-08-05  1194  }
06a71a24b Sudeep Holla      2016-04-04  1195  static inline void hyp_cpu_pm_exit(void)
06a71a24b Sudeep Holla      2016-04-04  1196  {
06a71a24b Sudeep Holla      2016-04-04  1197  }
1fcf7ce0c Lorenzo Pieralisi 2013-08-05  1198  #endif
1fcf7ce0c Lorenzo Pieralisi 2013-08-05  1199  
1e947bad0 Marc Zyngier      2015-01-29 @1200  static void teardown_common_resources(void)
1e947bad0 Marc Zyngier      2015-01-29  1201  {
1e947bad0 Marc Zyngier      2015-01-29  1202  	free_percpu(kvm_host_cpu_state);
1e947bad0 Marc Zyngier      2015-01-29  1203  }
1e947bad0 Marc Zyngier      2015-01-29  1204  
1e947bad0 Marc Zyngier      2015-01-29 @1205  static int init_common_resources(void)
1e947bad0 Marc Zyngier      2015-01-29  1206  {
1e947bad0 Marc Zyngier      2015-01-29  1207  	kvm_host_cpu_state = alloc_percpu(kvm_cpu_context_t);
1e947bad0 Marc Zyngier      2015-01-29  1208  	if (!kvm_host_cpu_state) {

:::::: The code at line 1016 was first introduced by commit
:::::: 3401d54696f992edf036f00f46c8c399d1b75c2a KVM: ARM: Introduce KVM_ARM_SET_DEVICE_ADDR ioctl

:::::: TO: Christoffer Dall <c.dall@virtualopensystems.com>
:::::: CC: Marc Zyngier <marc.zyngier@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 51309 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160916/1dd442e8/attachment-0001.obj>
