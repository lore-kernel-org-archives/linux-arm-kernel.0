From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 19 Oct 2016 08:54:03 -0700
Subject: [PATCH] dmaengine: qcom_hidma: cleanup sysfs entries during remove
In-Reply-To: <20161019132622.GN2467@localhost>
References: <1475796189-26553-1-git-send-email-okaya@codeaurora.org>
 <20161019132622.GN2467@localhost>
Message-ID: <e15e8c6a-35fa-5a9f-6b42-a91489716e85@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/2016 6:26 AM, Vinod Koul wrote:
>> -static int hidma_create_sysfs_entry(struct hidma_dev *dev, char *name,
>> > -				    int mode)
>> > +static int hidma_sysfs_uninit(struct hidma_dev *dev)
>> > +{
>> > +	if (!dev->chid_attrs)
>> > +		return -ENOMEM;
> why is this check required? Probe would fail in init case right.
> Second returning error doesnt help as you are calling this from remove and
> return is not checked so redundant!

Agreed, I'll get rid of the attrs and also the return value.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
