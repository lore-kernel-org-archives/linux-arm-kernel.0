From: guohanjun@huawei.com (Hanjun Guo)
Date: Sat, 4 Feb 2017 15:02:15 +0800
Subject: [PATCH v8 00/15] ACPI platform MSI support and its example mbigen
In-Reply-To: <20170203183626.GB17899@red-moon>
References: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
 <20170203183626.GB17899@red-moon>
Message-ID: <58957C77.7070206@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On 2017/2/4 2:36, Lorenzo Pieralisi wrote:
> Hanjun, Sinan,
>
> On Wed, Jan 18, 2017 at 08:54:50PM +0800, Hanjun Guo wrote:
>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>
>> With platform msi support landed in the kernel, and the introduction
>> of IORT for GICv3 ITS (PCI MSI) and SMMU, the framework for platform msi
>> is ready, this patch set add few patches to enable the ACPI platform
>> msi support.
>>
>> For platform device connecting to ITS on arm platform, we have IORT
>> table with the named componant node to describe the mappings of paltform
>> device and ITS, so we can retrieve the dev id and find its parent
>> irqdomain (ITS) from IORT table (simlar with the ACPI ITS support).
> Depending on how things go, I prepared a branch with the first 12
> patches (I basically updated some logs and added some cosmetics changes)
> for testing (Hanjun please have a look in details since I may have misread
> some logs), whether or not I will send a pull request for it we shall see
> next week.
>
> Here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git acpi/platform-msi

Thanks a lot for putting them together, I fetched your git tree and
took a detail look, there is one issue in patch "msi: platform: make
platform_msi_create_device_domain() ACPI aware" which has two
"Cc: Greg KH <gregkh@linuxfoundation.org>" in the commit log
(it's in the original patch from me, my bad), others are pretty good
to me (to make sure it works I retested those patches and patches
in your branch work as before).

BTW, patches in Lorenzo's branch have no conflicts with Agustin's
patch set + my mbigen one, so after a pull request to Rafael, could
them (Agustin's patch set + my mbigen one) go via one tree such as
Marc's one for 4.11?  I know it's a little bit late but those patches
are quite self-contained, which Agustin's changes are conditional
on the ACPI_GENERIC_GSI config which is only available with
ARM64 ACPI and others (interrupt combiner and mbigen) are specific
to QC and Hisilicon platforms.

Marc, Lorenzo, could you give some comments that how can we
proceed those patches (Agustin's patch set + my mbigen one)?
It's really critical for us, thank you very much.

Best Regards
Hanjun
