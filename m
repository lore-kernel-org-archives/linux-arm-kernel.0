From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 19 Jul 2017 12:25:44 +0100
Subject: [PATCH 0/5] FlexRM support in VFIO platform
In-Reply-To: <CAALAos_YTVRu_u8DycSXPgniGru20+fS6wfUskpV5uLRsazcNw@mail.gmail.com>
References: <1500456838-18405-1-git-send-email-anup.patel@broadcom.com>
 <0dc860ed-a40c-1bfd-f584-225807edb25b@arm.com>
 <CAALAos_YTVRu_u8DycSXPgniGru20+fS6wfUskpV5uLRsazcNw@mail.gmail.com>
Message-ID: <d4ef45d5-43cc-c632-082d-a92b8681faee@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/07/17 12:17, Anup Patel wrote:
> On Wed, Jul 19, 2017 at 4:27 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 19/07/17 10:33, Anup Patel wrote:
>>> This patchset primarily adds Broadcom FlexRM reset module for
>>> VFIO platform driver. We also have minor improvments in IOMMU
>>> and VFIO driver to allow VFIO no-IOMMU mode access to FlexRM.
>>
>> I'm struggling to understand the IOMMU changes here - what's the
>> FlexRM's hardware relationship with the IOMMU, and how is it different
>> from any other device? Furthermore, if there *is* a relevant IOMMU
>> present, why would no-IOMMU mode need to be involved at all?
> 
> We want to have FlexRM device accessible from user-space
> using VFIO platform with and without IOMMU.
> 
> Currently, if IOMMU ops are available for platform bus then
> I cannot access FlexRM device using VFIO no-IOMMU mode.

So does the FlexRM hardware master through the SMMU or not? If it does,
why do you need no-IOMMU mode? If it doesn't, then that's yet another
reason to fix the real problem, which is the utterly broken notion of
there being 'an IOMMU' on the platform 'bus', rather than papering over
it in VFIO.

Robin.

> Since, SMMU can bypass transactions which do not match
> any SMRs, we should allow no-IOMMU mode for devices
> when IOMMU group is not available.
> 
> Regards,
> Anup
> 
