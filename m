From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Mon, 21 May 2018 15:43:11 +0100
Subject: [PATCH v2 02/40] iommu/sva: Bind process address spaces to devices
In-Reply-To: <20180517141058.00001c76@huawei.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-3-jean-philippe.brucker@arm.com>
 <20180517141058.00001c76@huawei.com>
Message-ID: <19001b20-93de-6bf5-c72a-783e5d20b1bc@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/05/18 14:10, Jonathan Cameron wrote:
> On Fri, 11 May 2018 20:06:03 +0100
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
>> Add bind() and unbind() operations to the IOMMU API. Bind() returns a
>> PASID that drivers can program in hardware, to let their devices access an
>> mm. This patch only adds skeletons for the device driver API, most of the
>> implementation is still missing.
>>
>> IOMMU groups with more than one device aren't supported for SVA at the
>> moment. There may be P2P traffic between devices within a group, which
>> cannot be seen by an IOMMU (note that supporting PASID doesn't add any
>> form of isolation with regard to P2P). Supporting groups would require
>> calling bind() for all bound processes every time a device is added to a
>> group, to perform sanity checks (e.g. ensure that new devices support
>> PASIDs at least as big as those already allocated in the group).
> 
> Is it worth adding an explicit comment on this reasoning (or a minimal subset
> of it) at the check for the number of devices in the group?
> It's well laid out here, but might not be so obvious if someone is reading
> the code in the future.

Sure, I'll add something

Thanks,
Jean
