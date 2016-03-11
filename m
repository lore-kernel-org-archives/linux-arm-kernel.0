From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 11 Mar 2016 12:16:15 -0800
Subject: [PATCH] arm64: dts: vulcan: Update PCI ranges
In-Reply-To: <1456645037-12978-1-git-send-email-jchandra@broadcom.com>
References: <56D200F5.7010505@broadcom.com>
 <1456645037-12978-1-git-send-email-jchandra@broadcom.com>
Message-ID: <56E3278F.5090200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/02/16 23:37, Jayachandran C wrote:
> The PCI memory windows available in vulcan.dtsi are limited to 128MB
> for 32-bit BARs, and 4GB for 64-bit BARs. Given the memory mapped IO
> space available in arm64, these windows can be increased substantially
> to support more use cases.
> 
> The change increases the 32-bit window to 256MB and the 64-bit window
> to 128 GB. The firmware on vulcan boards will use these ranges as well.
> 
> PCI IO windows are not supported on Vulcan, so remove them instead of
> keeping an unused value.
> 
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
> 
> This is an update to the patch with subject
> "arm64: Broadcom Vulcan support"
> I had sent earlier, please fold it into that patch if possible

Arnd, I do not have any other Broadcom ARM64 DT changes for 4.6 to be
sent at the moment, do you mind taking this patch directly?

Feel free to add my:

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!

> 
> Thanks,
> JC.
> 
> 
>  arch/arm64/boot/dts/broadcom/vulcan.dtsi | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/broadcom/vulcan.dtsi b/arch/arm64/boot/dts/broadcom/vulcan.dtsi
> index c49b5a8..85820e2 100644
> --- a/arch/arm64/boot/dts/broadcom/vulcan.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/vulcan.dtsi
> @@ -108,12 +108,15 @@
>  		reg = <0x0 0x30000000  0x0 0x10000000>;
>  		reg-names = "PCI ECAM";
>  
> -			  /* IO 0x4000_0000 - 0x4001_0000 */
> -		ranges = <0x01000000 0 0x40000000 0 0x40000000 0 0x00010000
> -			  /* MEM 0x4800_0000 - 0x5000_0000 */
> -			  0x02000000 0 0x48000000 0 0x48000000 0 0x08000000
> -			  /* MEM64 pref 0x6_0000_0000 - 0x7_0000_0000 */
> -			  0x43000000 6 0x00000000 6 0x00000000 1 0x00000000>;
> +		/*
> +		 * PCI ranges:
> +		 *   IO		no supported
> +		 *   MEM        0x4000_0000 - 0x6000_0000
> +		 *   MEM64 pref 0x40_0000_0000 - 0x60_0000_0000
> +		 */
> +		ranges =
> +		  <0x02000000    0 0x40000000    0 0x40000000    0 0x20000000
> +		   0x43000000 0x40 0x00000000 0x40 0x00000000 0x20 0x00000000>;
>  		interrupt-map-mask = <0 0 0 7>;
>  		interrupt-map =
>  		      /* addr  pin  ic   icaddr  icintr */
> 


-- 
Florian
