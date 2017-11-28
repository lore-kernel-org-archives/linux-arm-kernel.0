From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 28 Nov 2017 09:26:30 -0500
Subject: [PATCH V2 7/7] PCI: make reset poll time adjustable
In-Reply-To: <20171128142044.GC11228@bhelgaas-glaptop.roam.corp.google.com>
References: <1511763628-11856-1-git-send-email-okaya@codeaurora.org>
 <1511763628-11856-8-git-send-email-okaya@codeaurora.org>
 <20171128142044.GC11228@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <837be7ee-13c7-8e8a-1a6b-87fd5e42b166@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/28/2017 9:20 AM, Bjorn Helgaas wrote:
>> Introduce pci=resetpolltime= argument to override 60 seconds poll time in
>> units of milliseconds.
> I resist adding kernel parameters because they really complicate the
> user experience.  Obviously you added this for a reason, but I don't
> know what that is.  If we really need it, is there any way we could
> automatically figure out in the kernel when we need different poll
> times?
> 

No, we can drop this patch if we want to . This was mostly a
scalability concern. 

I worried adding 60 seconds would be too much for some use case. We can
hold onto this change until that use case happens if you want.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
