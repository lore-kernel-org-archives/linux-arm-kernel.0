From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 6 Feb 2017 14:22:34 +0000
Subject: [PATCH v8 00/15] ACPI platform MSI support and its example mbigen
In-Reply-To: <58957C77.7070206@huawei.com>
References: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
 <20170203183626.GB17899@red-moon> <58957C77.7070206@huawei.com>
Message-ID: <20170206142234.GC14139@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 04, 2017 at 03:02:15PM +0800, Hanjun Guo wrote:
> Hi Lorenzo,
> 
> On 2017/2/4 2:36, Lorenzo Pieralisi wrote:
> > Hanjun, Sinan,
> >
> > On Wed, Jan 18, 2017 at 08:54:50PM +0800, Hanjun Guo wrote:
> >> From: Hanjun Guo <hanjun.guo@linaro.org>
> >>
> >> With platform msi support landed in the kernel, and the introduction
> >> of IORT for GICv3 ITS (PCI MSI) and SMMU, the framework for platform msi
> >> is ready, this patch set add few patches to enable the ACPI platform
> >> msi support.
> >>
> >> For platform device connecting to ITS on arm platform, we have IORT
> >> table with the named componant node to describe the mappings of paltform
> >> device and ITS, so we can retrieve the dev id and find its parent
> >> irqdomain (ITS) from IORT table (simlar with the ACPI ITS support).
> > Depending on how things go, I prepared a branch with the first 12
> > patches (I basically updated some logs and added some cosmetics changes)
> > for testing (Hanjun please have a look in details since I may have misread
> > some logs), whether or not I will send a pull request for it we shall see
> > next week.
> >
> > Here:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git acpi/platform-msi
> 
> Thanks a lot for putting them together, I fetched your git tree and
> took a detail look, there is one issue in patch "msi: platform: make
> platform_msi_create_device_domain() ACPI aware" which has two
> "Cc: Greg KH <gregkh@linuxfoundation.org>" in the commit log
> (it's in the original patch from me, my bad), others are pretty good
> to me (to make sure it works I retested those patches and patches
> in your branch work as before).
> 
> BTW, patches in Lorenzo's branch have no conflicts with Agustin's
> patch set + my mbigen one, so after a pull request to Rafael, could
> them (Agustin's patch set + my mbigen one) go via one tree such as
> Marc's one for 4.11?  I know it's a little bit late but those patches
> are quite self-contained, which Agustin's changes are conditional
> on the ACPI_GENERIC_GSI config which is only available with
> ARM64 ACPI and others (interrupt combiner and mbigen) are specific
> to QC and Hisilicon platforms.
> 
> Marc, Lorenzo, could you give some comments that how can we
> proceed those patches (Agustin's patch set + my mbigen one)?
> It's really critical for us, thank you very much.

Ok, given that:

- We have decided that from now onwards ACPI IORT patches should go
  via the ARM64 tree
- This series does not yet handle ARM SMMU MSIs (but it has to and I
  want to see how this will work - waiting for spec updates)
- It depends on fixes that will get merged via the v4.11 arm64 queue
- We are at -rc7 and I do not think it is fair at all to ask Will
  and Catalin to pull this code now given that it comes out of thin
  air for them
- Last but not least: it is not bad to take time for the dust to
  settle given that we merged lots of IORT code last two cycles

I have decided that the whole series will be considered v4.12
material, I do not expect it to be a major disruption given that
we should have a stable code base for it come v4.11-rc1 (inclusive
of Agustin's key probe deferral series).

Thanks,
Lorenzo
