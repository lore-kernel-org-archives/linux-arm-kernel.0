From: a.motakis@virtualopensystems.com (Antonios Motakis)
Date: Tue, 29 Apr 2014 11:52:29 +0200
Subject: [RFC PATCH v5 02/11] ARM SMMU: Add capability IOMMU_CAP_DMA_EXEC
In-Reply-To: <20140428193709.GE22135@arm.com>
References: <1398700371-20096-1-git-send-email-a.motakis@virtualopensystems.com>
 <1398700371-20096-3-git-send-email-a.motakis@virtualopensystems.com>
 <20140428193709.GE22135@arm.com>
Message-ID: <CAG8rG2x9ebs0KQREnrB52Og6-XkrCQ7hJv929QBLWQ4z2m_1WQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 9:37 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Apr 28, 2014 at 04:52:42PM +0100, Antonios Motakis wrote:
>> The ARM SMMU can take an IOMMU_EXEC protection flag in addition to
>> IOMMU_READ and IOMMU_WRITE. Expose this as an IOMMU capability.
>
> The other way of handling this would be to negate the capability and
> advertise a NOEXEC cap instead. That would need the IOMMU_EXEC flag to
> become IOMMU_NOEXEC and the ARM SMMU driver updating accordingly, but it
> might make more sense if people don't object to mixing positive and negative
> logic in the IOMMU_* flags.
>
> Any thoughts?
>

I agree, that would be simpler for the user. As it is now we have to
worry about whether the EXEC flac is available just to use the PL330,
with NOEXEC the device would always be usable by default.


> Will



-- 
Antonios Motakis
Virtual Open Systems
