From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Tue, 7 Mar 2017 18:25:11 +0530
Subject: IOMMU in bypass mode by default on ARM64,
 instead of command line option
In-Reply-To: <20170307113237.GB30058@arm.com>
References: <CA+sq2CdawVNqEjpuzkdmEDbvW69aXufHJAEoH_g55=sr2d1rOw@mail.gmail.com>
 <07f4a3d7-f41b-2459-65c6-729f3a692e7d@arm.com>
 <20170307113237.GB30058@arm.com>
Message-ID: <CA+sq2CeAKE+fDJhTA_W=bG531b8f7q=NZmgCtEQbXgZsR2RbSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 7, 2017 at 5:02 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Mar 06, 2017 at 12:34:36PM +0000, Robin Murphy wrote:
>> On 04/03/17 16:59, Sunil Kovvuri wrote:
>> > I did see some patches submitted earlier to enable user to boot kernel
>> > with SMMU in bypass mode using a command line parameter.
>> >
>> > Idea sounds good, but just wondering if it would be better if things are done in
>> > reverse i.e put SMMU in bypass mode by default on host and provide
>> > option to user to enable SMMU via bootargs. Reason i am saying this is
>> > with SMMU
>> > enabled on host, performance of devices drops down to pathetic levels, not
>> > because of HW but mostly because of ARM IOMMU implementation in kernel.
>
> [...]
>
>> > Performance with SMMU enabled drops to <1/5th on NVMe disk and on NIC
>> > it's down to nothing. Problem seems to be with high contention for
>> > locks which are
>> > being used for IOVA maintenance and while updating translation tables inside
>> > ARM SMMUv2/v3 drivers.
>>
>> Yes, we're well aware that there's a whole load of potential lock
>> contention where there doesn't really need to be. The performance
>> optimisation effort has mostly been waiting for sufficiently big
>> systems/workloads to start appearing in order to measure and justify it.
>> Consider yourself the winner :)
>
> Yup. Given that you have numbers (thank you!), then we'll bump the priority
> of this work and try to get something out that you can test.
>
> I'll also respin my bypass series ASAP.
>
> Will

Good to know that this is a known problem.
We will be morethan happy to test your patches.

Thanks,
Sunil.
