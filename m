From: bharatku@xilinx.com (Bharat Kumar Gogada)
Date: Tue, 19 Dec 2017 11:28:49 +0000
Subject: Linux Kernel handling AXI DECERR/SLVERR
In-Reply-To: <20171219104500.5otagp7m7dqretd2@lakrids.cambridge.arm.com>
References: <BLUPR0201MB1505A278D2EF1EABD80555EEA50F0@BLUPR0201MB1505.namprd02.prod.outlook.com>
 <20171219104500.5otagp7m7dqretd2@lakrids.cambridge.arm.com>
Message-ID: <BLUPR0201MB150517EAFAF3A46B8A19489CA50F0@BLUPR0201MB1505.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> When Linux is booted on ARM64 platform and an access to peripheral 
> returns DECERR or SLVERR on AXI.
> 
> In the above error cases how would Linux kernel handle these faults ? 
> Will it hang/recover ?

I believe that on contemporary CPUs these will result in an SError. As SErrors are asynchronous, and (in the absence of RAS extensions) their cause cannot be determined, these are treated as fatal, and the kernel will panic().

Thanks, Mark. 
In our case the peripheral returns SLVERR first time and we see the following print but kernel do not hang.
[  231.484186] Unhandled fault: synchronous external abort (0x92000210) at 0x0000007f9241f880
Bus error

And from simulation we know that subsequent access to peripheral returns OKAY response, however we
see subsequent access fail with same above bus error when we boot Linux.

Is there a way to handle these synchronous abort  gracefully in Linux or are these fatal ?

Regards,
Bharat
