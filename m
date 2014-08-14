From: pavel@denx.de (Pavel Machek)
Date: Thu, 14 Aug 2014 20:54:32 +0200
Subject: [PATCH 3/3] ARM: dts: socfpga: memreserve first 4KB for SMP code
In-Reply-To: <1408031491-15609-4-git-send-email-dinguyen@opensource.altera.com>
References: <1408031491-15609-1-git-send-email-dinguyen@opensource.altera.com>
 <1408031491-15609-4-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <20140814185432.GE11558@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2014-08-14 10:51:31, dinguyen at opensource.altera.com wrote:
> From: Dinh Nguyen <dinguyen@opensource.altera.com>
> 
> The SOCFPGA's SMP code uses 0x0 for as the location for the trampoline to
> bring secondary cores online. This patch adds a /memreserve/ section to
> reserve the first 4K for the SMP trampoline code.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> ---
>  arch/arm/boot/dts/socfpga_arria5.dtsi   | 1 +
>  arch/arm/boot/dts/socfpga_cyclone5.dtsi | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
> index 468fc4c..73b939e 100644
> --- a/arch/arm/boot/dts/socfpga_arria5.dtsi
> +++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
> @@ -15,6 +15,7 @@
>   */
>  
>  /dts-v1/;
> +/memreserve/ 0x00000000 0x0001000;

Actually, comment here explaining that ROM code uses 0x0 for the
trampoline would be nice here... if I understand it correctly.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
