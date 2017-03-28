From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 28 Mar 2017 09:04:29 -0400
Subject: [PATCH V5 0/4] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
In-Reply-To: <c9820456-d9b1-cd97-533b-889905e27603@codeaurora.org>
References: <1490477893-9517-1-git-send-email-okaya@codeaurora.org>
 <f062dc8f-df66-bfd8-a0d7-50ac1cadf975@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B2846675AEDC@IRSMSX101.ger.corp.intel.com>
 <c9820456-d9b1-cd97-533b-889905e27603@codeaurora.org>
Message-ID: <1f677feb-b561-1dd3-69ad-afd4049b6d59@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/28/2017 8:52 AM, Sinan Kaya wrote:
> On 3/28/2017 2:02 AM, Patel, Mayurkumar wrote:
>> Thanks for your patches. I am seeing kernel panic after applying
>> these patches (on top of latest kernel) each time during early boot in pci_aspm_init() (any hints already?) function.
>> Need to check if it's something related to my local setup or it's because of these changes.
>> For now I don't have more details why it crashes but I will dig in further and I will provide
>> you more data as soon as I have it.
>>
> 
> Interesting, I retested Qemu and I don't see an issue. 
> Can you share your bootlog when you see the crash?
> 
Thinking more...

Can you add this to the top of pci_aspm_init() and try again?

if (!pci_is_pcie(pdev))
          return -EINVAL;

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
