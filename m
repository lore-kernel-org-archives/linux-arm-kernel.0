From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Sun, 10 Apr 2016 12:54:22 +0200
Subject: [PATCH 1/2] PCI: iproc: Support DT property for ignoring aborts
 when probing
In-Reply-To: <201604101000.oQktaJEg%fengguang.wu@intel.com>
References: <1460238624-2086-1-git-send-email-zajec5@gmail.com>
 <201604101000.oQktaJEg%fengguang.wu@intel.com>
Message-ID: <CACna6rzz+j6GONeh31xOfX+MuHERxAz9z9fREwZXp2=7Xodknw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 April 2016 at 04:59, kbuild test robot <lkp@intel.com> wrote:
> [auto build test ERROR on pci/next]
> [also build test ERROR on v4.6-rc2 next-20160408]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>
> url:    https://github.com/0day-ci/linux/commits/Rafa-Mi-ecki/PCI-iproc-Support-DT-property-for-ignoring-aborts-when-probing/20160410-055241
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> config: arm-allmodconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm
>
> All errors (new ones prefixed by >>):
>
>>> ERROR: "hook_fault_code" [drivers/pci/host/pcie-iproc.ko] undefined!

Oh, it seems  hook_fault_code is not an exported SYMBOL and can't be
used when building iproc as module.

Any idea how to resolve this problem?

-- 
Rafa?
