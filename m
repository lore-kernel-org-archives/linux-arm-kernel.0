From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 21 Mar 2013 21:15:33 +0100
Subject: [PATCH 5/5] arm: dts: Convert mvebu device tree files to 64 bits
In-Reply-To: <1363883179-1361-6-git-send-email-gregory.clement@free-electrons.com>
References: <1363883179-1361-1-git-send-email-gregory.clement@free-electrons.com>
 <1363883179-1361-6-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130321201533.GN21478@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  		/*
> -		 * 4 GB of plug-in RAM modules by default but only 3GB
> -		 * are visible, the amount of memory available can be
> -		 * changed by the bootloader according the size of the
> -		 * module actually plugged
> +		 * 8 GB of plug-in RAM modules by default.The amount
> +		 * of memory available can be changed by the
> +		 * bootloader according the size of the module
> +		 * actually plugged. Only 7GB are usable because
> +		 * addresses from 0xC0000000 to 0xffffffff are used by
> +		 * the internal registers of the SoC.
>  		 */
> -		reg = <0x00000000 0xC0000000>;
> +		reg = <0x00000000 0x00000000 0x00000000 0xC0000000>,
> +		      <0x00000001 0x00000000 0x00000001 0x00000000>;
> +

Hi Gregory

Could you recommend a document which introduces LPAE.

Only being able to address 7GB seems a bit odd to me. I kind of
expected you set up the translation tables to map a page in the 32 bit
address range to any arbitrary page in the 40 bit address range. So
leaving 0xC0000000 to 0xffffffff in the 32bit address range clear is
easy. But why do you loose space in the 40bit address range?

      Thanks
	Andrew
