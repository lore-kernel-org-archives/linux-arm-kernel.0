From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 24 Jun 2017 06:15:05 +0800
Subject: [arm-platforms:kvm-arm64/gicv4-kvm 43/44]
 include/linux/irqchip/arm-gic-v4.h:97:57: warning: 'struct irq_domain_ops'
 declared inside parameter list will not be visible outside of this
 definition or declaration
Message-ID: <201706240603.RDf1vl0C%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/gicv4-kvm
head:   bdab51ab2560539213cf4541763326b0caddbda5
commit: fa9a010dcb7fa3e34ee10e9aeb0c112bd863f421 [43/44] WIP
config: arm64-allnoconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout fa9a010dcb7fa3e34ee10e9aeb0c112bd863f421
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All warnings (new ones prefixed by >>):

   In file included from arch/arm64/include/asm/kvm_host.h:27:0,
                    from include/linux/kvm_host.h:37,
                    from arch/arm64/kernel/asm-offsets.c:24:
>> include/linux/irqchip/arm-gic-v4.h:97:57: warning: 'struct irq_domain_ops' declared inside parameter list will not be visible outside of this definition or declaration
    int its_init_v4(struct irq_domain *domain, const struct irq_domain_ops *ops);
                                                            ^~~~~~~~~~~~~~

vim +97 include/linux/irqchip/arm-gic-v4.h

    81	struct its_cmd_info {
    82		enum its_vcpu_info_cmd_type	cmd_type;
    83		union {
    84			struct its_vlpi_map	*map;
    85			u8			config;
    86		};
    87	};
    88	
    89	int its_alloc_vcpu_irqs(struct its_vm *vm);
    90	void its_free_vcpu_irqs(struct its_vm *vm);
    91	int its_schedule_vpe(struct its_vpe *vpe, bool on);
    92	int its_invall_vpe(struct its_vpe *vpe);
    93	int its_map_vlpi(int irq, struct its_vlpi_map *map);
    94	int its_unmap_vlpi(int irq);
    95	int its_prop_update_vlpi(int irq, u8 config);
    96	
  > 97	int its_init_v4(struct irq_domain *domain, const struct irq_domain_ops *ops);
    98	
    99	#endif

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6566 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170624/4e66357b/attachment.gz>
