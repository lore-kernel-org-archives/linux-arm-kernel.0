From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Thu, 7 Sep 2017 17:32:13 +0100
Subject: [RFC PATCH 0/6] Add platform device SVM support for ARM SMMUv3
In-Reply-To: <1d358989-48bb-ccde-d7d9-36e004bc2d78@huawei.com>
References: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
 <95d1a9e2-1816-ff7d-9a8d-98406a6c2c22@arm.com>
 <caf68193-6aff-1e1c-86cd-9cc7069b0e37@huawei.com>
 <2874a1f3-22f1-20d4-4009-50add127a10f@arm.com>
 <1d358989-48bb-ccde-d7d9-36e004bc2d78@huawei.com>
Message-ID: <bde256dd-6550-6c40-fe2c-2bd1cc1339d3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/17 02:41, Bob Liu wrote:
>> This would require some work in moving the PCI bits at the end of the
>> series. I can reserve some time in the coming months to do it, but I need
>> to know what to focus on. Are you able to test SSID as well?
>>
> 
> Yes, but the difficulty is our devices are on-chip integrated hardware accelerators which requires complicate driver.
> You may need much time to understand the driver.
> That's the same case as intel/amd SVM, the current user is their GPU :-(
> 
> Btw, what kind of device/method do you think is ideal for testing arm-SVM?

A simple, bare DMA engine would be ideal. Something just capable of
performing memcpy with parameters (PASID, input IOVA, output IOVA, size)
can be used for validating SVM and virtualization. You could easily create
reproducible unit tests and userspace drivers. If it supports isolated
channels (as in SR-IOV), even better.

As you said, having a useful device like a full GPU/accelerator as opposed
to a dummy validation engine makes it difficult to fully test the SMMU.
However it can be helpful for evaluating driver performances and is still
good enough for confirming that the IOMMU works.

Thanks,
Jean
