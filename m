From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Sun, 8 Oct 2017 11:45:11 -0500
Subject: [PATCH v4 00/26] KVM/ARM: Add support for GICv4
In-Reply-To: <20171006153401.5481-1-marc.zyngier@arm.com>
References: <20171006153401.5481-1-marc.zyngier@arm.com>
Message-ID: <0134a6cd-dfbc-6fe5-63a6-958b61d92f36@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

I've tested this patch series on QDF2400 server platform using NVME card, the basic
functionality works fine and the below log messages shows around 70 interrupts
are delivered to vCPU directly.


Tested-by: Shanker Donthineni <shankerd@codeaurora.org>


>From guest kernel:
 /mnt # cat /proc/interrupts | grep ITS
 51:         83   ITS-MSI 32768 Edge      nvme0q0, nvme0q1
 52:          0   ITS-MSI 16384 Edge      virtio0-config
 53:          0   ITS-MSI 16385 Edge      virtio0-input.0
 54:          0   ITS-MSI 16386 Edge      virtio0-output.0
 
>From host kernel:
 /mnt # cat /proc/interrupts | grep GICv4
 388:          9  GICv4-vpe   0 Edge      vcpu

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
