From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 18 Sep 2015 12:22:56 -0700
Subject: [PATCH v2 2/3] soc: brcmstb: Add Bus Interface Unit control setup
In-Reply-To: <1442340900-15320-3-git-send-email-f.fainelli@gmail.com>
References: <1442340900-15320-1-git-send-email-f.fainelli@gmail.com>
 <1442340900-15320-3-git-send-email-f.fainelli@gmail.com>
Message-ID: <55FC6490.7000204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/09/15 11:14, Florian Fainelli wrote:
> Broadcom STB SoCs (brcmstb) require an early setup of their Bus
> Interface Unit control register, this needs to happen before SMP is
> brought up because it affects how the CPU complex will be interfaced to
> the memory controller.
> 
> Add support code which properly initializes the BIU registers based on
> whether "brcm,write-pairing" is present in Device Tree, and take care of
> saving and restoring credit register settings during system-wide
> suspend/resume operations.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to soc/next with Gregory's tag and the revised function
prototype returning void.
-- 
Florian
