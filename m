From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 20 Jan 2016 17:18:29 -0500
Subject: [PATCH V12 3/7] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <569917C7.9000804@codeaurora.org>
References: <1452523550-8920-1-git-send-email-okaya@codeaurora.org>
 <1452523550-8920-4-git-send-email-okaya@codeaurora.org>
 <20160115145629.GI3262@leverpostej> <56990CD4.6020405@arm.com>
 <20160115153656.GM3262@leverpostej> <569917C7.9000804@codeaurora.org>
Message-ID: <56A007B5.9070502@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On 1/15/2016 11:01 AM, Sinan Kaya wrote:
>> I'm concerned with how this is safe, and with the userspace interface.
>> > e.g. if the user wants to up the QoS for a VM, how to they find the
>> > right channel in sysfs  to alter?
> The HW supports changing the QoS values on the flight. In order to locate the
> object, I'm exporting a 
> 
> I tried to address your concern on v10 last series. Here is brief summary.
> 
> Each channel device has a sysfs entry named chid.
> What:		/sys/devices/platform/hidma-*/chid
> +		/sys/devices/platform/QCOM8061:*/chid
> 
> 
> Each management object has one priority and weight file per channel.
> +What:		/sys/devices/platform/hidma-mgmt*/chanops/chan*/priority
> +		/sys/devices/platform/QCOM8060:*/chanops/chan*/priority
> 
> Suppose you want to change the priority of a channel you assigned to guess,
> the userspace application goes and reads the chid value of the channel.
> 
> Then goes to chanops/chan<chid>/ directory and can change priority and weight 
> parameters here.
> 
> Here is how the directory looks like. QCOM8060:00 is a management object.
> QCOM8061:0x are the channel objects.
> 
> /sys/devices/platform/QCOM8060:00# ls
> QCOM8061:00
> QCOM8061:01
> QCOM8061:02
> QCOM8061:03
> QCOM8061:04
> QCOM8061:05
> chanops
> <other common attributes>
> 
> 
> 
> 


Did this answer your question? 

I'm capturing all the questions and answers as FAQ into the cover letter as I keep
repeating myself for every single reviewer.

Besides from the "lack of documentation", is there any code related change you'd like to
discuss in the series.


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
