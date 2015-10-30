From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 30 Oct 2015 14:32:20 +0000
Subject: [PATCH] arm64: dts: Added syscon-reboot node for FSL's LS2085A SoC
In-Reply-To: <CY1PR0301MB07480A8EC25BB6987883AE5687220@CY1PR0301MB0748.namprd03.prod.outlook.com>
References: <1445650280-9966-1-git-send-email-German.Rivera@freescale.com>
 <20151027163441.GK3091@leverpostej>
 <CY1PR0301MB07480A8EC25BB6987883AE5687220@CY1PR0301MB0748.namprd03.prod.outlook.com>
Message-ID: <20151030143220.GC31073@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 06:25:04PM +0000, Stuart Yoder wrote:
> I think that comment "Currently supported enable-method is psci v0.2" is a statement of
> intent, not what is available currently.   And the only plan I am aware of is PSCI
> with UEFI based firmware.
> 
> U-boot is a key firmware platform for us and has no PSCI implementation available.

Please note that PSCI isn't implemented by UEFI. On ARM Juno (and other
platforms), PSCI is implemented by ARM Trusted Firmware [1], and the non-secure
side can be UEFI (EDK2), U-Boot, or something else entirely.

> So, we need this.  The device tree simply describes the hardware that is
> there and that's what this patch exposes.
>
> If down the road all firmware provides a PSCI based reset interface then
> we will naturally use that.  But we need something in the meantime to
> let us reboot the system.

I appreciate that you need this if you do not have a PSCI implementation. I was
mislead by the comment.

Thanks,
Mark.

[1] https://github.com/ARM-software/arm-trusted-firmware
