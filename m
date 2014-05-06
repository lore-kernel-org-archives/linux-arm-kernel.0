From: balbi@ti.com (Felipe Balbi)
Date: Tue, 6 May 2014 14:40:55 -0500
Subject: [PATCH V5 1/3] arm: dts: dra7: Add crossbar device binding
In-Reply-To: <1399384579-25620-2-git-send-email-r.sricharan@ti.com>
References: <1399384579-25620-1-git-send-email-r.sricharan@ti.com>
 <1399384579-25620-2-git-send-email-r.sricharan@ti.com>
Message-ID: <20140506194055.GA6962@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 06, 2014 at 07:26:17PM +0530, Sricharan R wrote:
> This adds the irq crossbar device node.
> 
> There is a IRQ crossbar device in the soc, which
> maps the irq requests from the peripherals to the
> mpu interrupt controller's inputs. The Peripheral irq
> requests are connected to only one crossbar
> input and the output of the crossbar is connected to only one
> controller's input line. The crossbar device is used to map
> a peripheral input to a free mpu's interrupt controller line.
> 
> Cc: Benoit Cousson <bcousson@baylibre.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> [V5] Rebased on top of 3.15-rc4 and corrected the
>      irqs-reserved list
> 
>  arch/arm/boot/dts/dra7.dtsi |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 149b550..0274a86 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -790,6 +790,14 @@
>  			status = "disabled";
>  		};
>  	};
> +
> +	crossbar_mpu: crossbar at 4a020000 {

shouldn't this be "status = disabled"; so that boards enable this
on-demand ??

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140506/e593d66e/attachment.sig>
