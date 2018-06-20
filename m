From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 19 Jun 2018 23:04:38 -0400
Subject: [PATCH V2] PCI: Enable PASID when End-to-End TLP is supported by
 all bridges
In-Reply-To: <dafc272d-0748-90ee-5d34-be5b2a2e5725@codeaurora.org>
References: <1529460886-23722-1-git-send-email-okaya@codeaurora.org>
 <dafc272d-0748-90ee-5d34-be5b2a2e5725@codeaurora.org>
Message-ID: <843fd601-0b81-d29f-0aa8-13a261a0b931@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/19/2018 11:02 PM, Timur Tabi wrote:
> On 6/19/18 9:14 PM, Sinan Kaya wrote:
>> +??? if (!(cap & PCI_EXP_DEVCAP2_E2ETLP))
>> +??????? return;
>> +
>> +??? dev->eetlp_prefix = 1;
> 
> How about:
> 
> ????if (cap & PCI_EXP_DEVCAP2_E2ETLP)
> ??????? dev->eetlp_prefix = 1;
> 

Both works. I'll wait until I get more feedback.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
