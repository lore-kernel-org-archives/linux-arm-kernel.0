From: mansoor.ahamed@ti.com (Basheer, Mansoor Ahamed)
Date: Mon, 10 Jan 2011 17:50:51 +0530
Subject: [PATCH v5 3/3] ahci_platforms: add support for CNS3xxx SoC devices
In-Reply-To: <1294557970-654-4-git-send-email-mkl0301@gmail.com>
References: <1294557970-654-1-git-send-email-mkl0301@gmail.com>
	<1294557970-654-4-git-send-email-mkl0301@gmail.com>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0373E1D99B@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Mac Lin <mkl0301@gmail.com>
> 
> CNS3xxx override the softreset function of ahci_platform
> ahci_softreset by cns3xxx_ahci_softreset, which would retry
> ahci_do_softreset again with pmp=0 if
> pmp=15 failed, for the controller has problem receiving D2H
> Reg FIS of the different PMP setting of the previous sent H2D Reg FIS.
> 

Is this issue only with your ahci platform controller? I came across another 
thread here,

http://www.spinics.net/lists/linux-ide/msg39865.html  

Also, the ahci platform controller on Texas Instruments OMAP L138 platform 
behaves in a similar fashion. 

Currently I see only Cavium Networks, Faraday and TI using ahci platform 
controller and all 3 facing same issue.

Hence, should we fix this in ahci_platform.c conditionally using platform data, 
otherwise we will end-up adding file for every platform (just for one 
function). 

Thanks
Mansoor Ahamed
