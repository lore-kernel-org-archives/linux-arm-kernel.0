From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 18 Apr 2015 12:41:41 -0700
Subject: [PATCH 1/7] Documentation: DT: Add Broadcom BCM63138 PMB binding
In-Reply-To: <1429310032-19402-2-git-send-email-f.fainelli@gmail.com>
References: <1429310032-19402-1-git-send-email-f.fainelli@gmail.com>
 <1429310032-19402-2-git-send-email-f.fainelli@gmail.com>
Message-ID: <CAGVrzcYtitBqqbdDYmKx-W++zBgnPbTEJAKv6oyFL325SnMcEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-17 15:33 GMT-07:00 Florian Fainelli <f.fainelli@gmail.com>:
> Add a Device Tree binding for the Broadcom BCM63138 Processor Monitor
> Bus, which is an internal bus used to access different power and reset
> signals within a BCM63138 System-on-a-Chip.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> +- compatible: must be "brcm,bcm63138-pmb"
> +- reg: base register address and size for this bus controller
> +- #reset-cells: must be 2 first cell is the internal bus number, and the third
> +  cell is the address on this bus

I missed the fact that we need to represent the number of zones per
devices as a third cell here since some devices may have multiple
zones to be powered on. Will re-spin this series along with addressing
Russell's comments in patch 7.
--
Florian
