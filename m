From: geoff@infradead.org (Geoff Levand)
Date: Wed, 03 Sep 2014 10:23:11 -0700
Subject: [PATCH V2 4/6] arm64: Add DTS support for FSL's LS2085A SoC
In-Reply-To: <1409219706-14843-5-git-send-email-bhupesh.sharma@freescale.com>
References: <1409219706-14843-1-git-send-email-bhupesh.sharma@freescale.com>
 <1409219706-14843-5-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1409764991.21254.139.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bhupesh,

On Thu, 2014-08-28 at 15:25 +0530, Bhupesh Sharma wrote:
> This patch adds the device tree support for FSL LS2085A SoC
> based on ARMv8 architecture.
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		/* We have 4 clusters having 2 Cortex-A57 cores each */
> +		cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a57";
> +			reg = <0x0 0x0>;
> +		};

arm64 needs a cpu enable-method property.  Is your boot loader adding
that?

Be aware that if you have set it up this way, users will not be able to
use this file with kexec's --dtb=FILE to specify a 2nd stage DT file.
kexec will use a copy of the DT from the 1st stage in this case.

-Geoff
