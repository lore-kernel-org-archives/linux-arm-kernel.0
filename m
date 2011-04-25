From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Sun, 24 Apr 2011 23:11:32 -0700
Subject: arm: msm: Convert irq-vic to generic irq chip
In-Reply-To: <alpine.LFD.2.02.1104211926550.3323@ionos>
References: <20110416211221.853079766@linutronix.de>
	<20110416211308.455390167@linutronix.de>
	<4DB0611D.6040902@codeaurora.org>
	<alpine.LFD.2.02.1104211926550.3323@ionos>
Message-ID: <4DB51094.3040003@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2011 10:28 AM, Thomas Gleixner wrote:
> On Thu, 21 Apr 2011, Abhijeet Dharmapurikar wrote:
>> On 04/16/2011 02:14 PM, Thomas Gleixner wrote:
>
> Another question is whether you could move to the arm/common/vic.c
> implementation completely.

arm/common/vic.c doesnt have a set_type callback. We have some edge 
triggered interrupts as wakeup interrupts and need the PENDING flag in 
the descriptor set when disabled. Can we move msm_irq_set_type() to 
arm/common/vic.c ?

Additionally
- the register map is different between msm's vic and the common one.
- the common one uses some PL190 registers, not sure what that is. The 
VIC can operate in few different modes, perhaps it refers to vectored 
mode as opposed to non vectored mode, msm uses the non vectored mode.
- vic_init2() seems like it is initializing a cascaded interrupt 
controller. msm doesnt use cascaded vics.

I dont think msm can move to using the common vic.c.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
