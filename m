From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Tue, 26 Jan 2016 20:26:06 +0800
Subject: [PATCH v3 14/17] XEN: EFI: Move x86 specific codes to architecture
 directory
In-Reply-To: <alpine.DEB.2.02.1601261117200.3619@kaball.uk.xensource.com>
References: <1453519184-11908-1-git-send-email-zhaoshenglong@huawei.com>
 <1453519184-11908-15-git-send-email-zhaoshenglong@huawei.com>
 <alpine.DEB.2.02.1601251643230.9687@kaball.uk.xensource.com>
 <56A72B4F.2040909@huawei.com>
 <alpine.DEB.2.02.1601261117200.3619@kaball.uk.xensource.com>
Message-ID: <56A765DE.7040408@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/1/26 19:31, Stefano Stabellini wrote:
> On Tue, 26 Jan 2016, Shannon Zhao wrote:
>> > On 2016/1/26 0:44, Stefano Stabellini wrote:
>>> > > On Sat, 23 Jan 2016, Shannon Zhao wrote:
>>>>> > >> > From: Shannon Zhao <shannon.zhao@linaro.org>
>>>>> > >> > 
>>>>> > >> > Move x86 specific codes to architecture directory and export those EFI
>>>>> > >> > runtime service functions. This will be useful for initializing runtime
>>>>> > >> > service on ARM later.
>>>>> > >> > 
>>>>> > >> > Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
>>> > > This patch causes a build breakage on x86:
>>> > > 
>>> > > arch/x86/xen/efi.c: In function ?xen_efi_probe?:
>>> > > arch/x86/xen/efi.c:101:2: error: implicit declaration of function ?HYPERVISOR_platform_op? [-Werror=implicit-function-declaration]
>>> > > 
>> > This patch is based on following patch [1]. Maybe you need to update
>> > your branch. :)
>> > 
>> > [1] xen: rename dom0_op to platform_op
>> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=cfafae940381207d48b11a73a211142dba5947d3
> Sorry, I made a mistake rebasing the series. It doesn't help that I
> couldn't find any Linux RCs on top of which it applies cleanly. As Linus
> tags RCs often enough, it is usually helpful to base one's work on a tag
> so that it is easier for other people to work on it.
>
Ah, I'll rebase this series on top of the newest master at next version
since the relevant patches are in master.

> Please add my Reviewed-by to this patch.
Thanks a lot!

-- 
Shannon
