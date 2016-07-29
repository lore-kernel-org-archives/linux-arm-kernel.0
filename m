From: ruslan.bilovol@gmail.com (Ruslan Bilovol)
Date: Fri, 29 Jul 2016 19:26:03 +0300
Subject: [PATCH v23 0/9] arm64: add kdump support
In-Reply-To: <20160726080925.GA2363@linaro.org>
References: <20160726075659.2290-1-takahiro.akashi@linaro.org>
 <20160726080925.GA2363@linaro.org>
Message-ID: <CAB=otbTODnOwFiLZT7bm1_MLyORQ1cx-gaeg7bm+bReaMRhYwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 26, 2016 at 11:09 AM, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
> On Tue, Jul 26, 2016 at 04:56:51PM +0900, AKASHI Takahiro wrote:
>> This patch series adds kdump support on arm64.
>>
>> To load a crash-dump kernel to the systems, a series of patches to
>> kexec-tools, which have not yet been merged upstream, are needed.
>> Please pick Geoff's kexec patches [1] and my kdump patches [2].
>>
>> To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
>>   - crash utility (coming v7.1.6 or later) [3]
>>     (Necessary patches have already been queued in the master.)
>>
>> [1]  http://lists.infradead.org/pipermail/kexec/2016-July/016532.html
>> [2]  TBD
>
> See my kexec-tools patches in:
> http://lists.infradead.org/pipermail/kexec/2016-July/016642.html

I tired this patch series with mentioned Geoff's kexec patches and
your kdump patches, but unfortunately it doesn't work for me.

While I can successfully load and kexec the kernel ('kexec --load' +
'kexec -e'), same combination of kernel+ramdisk+dtb doesn't boot
if I do kdump combination ('kexec -p' + sysrq crash), there is no
any output after sysrq crash trace.
Unfortunately I don't have any debugger here for deep investigation
of this issue.

Also for some reason in case of 'load and kexec the kernel' it
takes 1-2 minutes to start booting after I do kexec -e, need to
investigate it further.

Which hardware do you use for validating your patches?

Also, could you please share exact commands you use for
kdump validation?

Best regaerds,
Ruslan
