From: lkp@intel.com (kbuild test robot)
Date: Mon, 22 Aug 2016 15:56:17 +0800
Subject: [PATCH v3 2/2] soc: qcom: add l2 cache perf events driver
In-Reply-To: <1471374703-8109-3-git-send-email-nleeder@codeaurora.org>
Message-ID: <201608221510.tt6ATDhN%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.8-rc3 next-20160819]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Neil-Leeder/qcom-add-l2-cache-perf-events-driver/20160817-031555
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   drivers/soc/qcom/perf_event_l2.c: In function 'l2_cache_pmu_probe':
>> drivers/soc/qcom/perf_event_l2.c:786:32: error: 'CPU_PRI_PERF' undeclared (first use in this function)
     l2cache_pmu.cpu_nb.priority = CPU_PRI_PERF + 1;
                                   ^
   drivers/soc/qcom/perf_event_l2.c:786:32: note: each undeclared identifier is reported only once for each function it appears in

vim +/CPU_PRI_PERF +786 drivers/soc/qcom/perf_event_l2.c

   780		if (l2cache_pmu.num_pmus == 0) {
   781			dev_err(&pdev->dev, "No hardware L2 PMUs found\n");
   782			return -ENODEV;
   783		}
   784	
   785		l2cache_pmu.cpu_nb.notifier_call = l2cache_pmu_cpu_notifier;
 > 786		l2cache_pmu.cpu_nb.priority = CPU_PRI_PERF + 1;
   787		err = register_cpu_notifier(&l2cache_pmu.cpu_nb);
   788		if (err)
   789			return err;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 51359 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/cfeeb936/attachment-0001.obj>
