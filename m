From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 31 Mar 2016 09:52:54 +0200
Subject: [PATCH v8] acpi, apei, arm64: APEI initial support for aarch64.
In-Reply-To: <CADyBb7spZBi-w5wFnVjioMVo4EEjWGcVdWgtbsF+wkCA0qi=gQ@mail.gmail.com>
References: <1459237458-12352-1-git-send-email-fu.wei@linaro.org>
 <201603301450.pihQHWST%fengguang.wu@intel.com>
 <CADyBb7spZBi-w5wFnVjioMVo4EEjWGcVdWgtbsF+wkCA0qi=gQ@mail.gmail.com>
Message-ID: <CAKv+Gu-_YhFva9RHUtzC68Ck2wTN2BvcXTEfCJbvVh98DFgn_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 March 2016 at 19:55, Fu Wei <fu.wei@linaro.org> wrote:
> Hi Tomasz
>
> On 30 March 2016 at 14:50, kbuild test robot <lkp@intel.com> wrote:
>> Hi Tomasz,
>>
>> [auto build test WARNING on arm64/for-next/core]
>> [also build test WARNING on v4.6-rc1 next-20160330]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/fu-wei-linaro-org/acpi-apei-arm64-APEI-initial-support-for-aarch64/20160329-154730
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/core
>> config: arm64-allyesconfig (attached as .config)
>> reproduce:
>>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=arm64
>>
>> All warnings (new ones prefixed by >>):
>>
>> warning: (ACPI_APEI) selects EFI which has unmet direct dependencies (OF && !CPU_BIG_ENDIAN)
>
> I think it's caused by  CPU_BIG_ENDIAN, because  ARM64 selects OF.
>

No, as I pointed out, it is caused by the fact that you 'select' EFI
rather than 'depend on' it.

> Any suggestion ?
>

replace

select EFI if ARM64

with

depends on EFI || !ARM64

but it would be even better to make ACPI_APEI depend on ACPI, since
the above dependency will be implied then, although I am not sure how
that affects other architectures.

-- 
Ard.
