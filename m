From: thor.thayer@linux.intel.com (Thor Thayer)
Date: Wed, 31 Jan 2018 16:09:39 -0600
Subject: ARM64 SMMU Setup
Message-ID: <fc00c99b-7766-2ac5-83a5-2ed9e13a15e1@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm enabling the ARM SMMU-500 on an ARM64 A53. I'm hitting a data abort 
in the probe functions because I'm accessing the registers in EL1 mode.

Linux starts in EL2 mode but drops down to EL1 mode by the time it 
reaches the arm-smmu probe function.

Is there something else I need to add to either move the arm-smmu probe 
earlier or remain in EL2 until after the arm-smmu probe?

A Google search didn't turn up anything so I hoped posting to the list 
would help.

Thanks in advance,

Thor
