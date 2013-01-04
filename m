From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 04 Jan 2013 18:26:35 +0100
Subject: [PATCH 1/4] arm: mvebu: limit OpenBlocks AX3-4 to 1 GB of RAM
In-Reply-To: <1357315498-4570-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1357315498-4570-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1357315498-4570-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <50E710CB.8070007@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/13 17:04, Thomas Petazzoni wrote:
> Signed-off-by: Thomas Petazzoni<thomas.petazzoni@free-electrons.com>
> ---
> This is a fix for 3.8, should be pushed for some 3.8-rc.
> ---
>   arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |    8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
> index 72a9dd0..3e9ee1b 100644
> --- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
> +++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
> @@ -23,7 +23,13 @@
>
>   	memory {
>   		device_type = "memory";
> -		reg =<0x00000000 0xC0000000>; /* 3 GB */
> +		/*
> +		 * The board has an additional 2 GB DRAM chip in an
> +		 * expansion slot, but using it makes the system very
> +		 * unstable: it even doesn't boot reliably. So we use
> +		 * only the soldered 1 GB chip for now.
> +		 */
> +		reg =<0x00000000 0x40000000>; /* 1 GB */
>   	};
>
>   	soc {

Hi Thomas

How many different boards have you tried?

I've not had problems with the board i have. Using the plathome supplied 
kernel, i've rebuilt the kernel, which is a good memory test. Using 
mainline, i've booted a number of times when developing the thermal 
driver and not had problems.

I would hate to disable 2GB of RAM just because your board has a fault.

	Andrew
