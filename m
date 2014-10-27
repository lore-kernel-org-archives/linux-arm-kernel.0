From: balbi@ti.com (Felipe Balbi)
Date: Mon, 27 Oct 2014 11:39:18 -0500
Subject: [PATCH v1 02/10] dt-bindings: Document the standard property
 "system-power-controller"
In-Reply-To: <1414427215-14380-2-git-send-email-romain.perier@gmail.com>
References: <1414427215-14380-1-git-send-email-romain.perier@gmail.com>
 <1414427215-14380-2-git-send-email-romain.perier@gmail.com>
Message-ID: <20141027163918.GB14253@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 04:26:47PM +0000, Romain Perier wrote:
> This simply renames the previous documentation to something more generic and adds
> updates according to last changes.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  .../devicetree/bindings/power/power-controller.txt     | 18 ++++++++++++++++++
>  Documentation/devicetree/bindings/power/poweroff.txt   | 18 ------------------
>  2 files changed, 18 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/power-controller.txt
>  delete mode 100644 Documentation/devicetree/bindings/power/poweroff.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/power-controller.txt b/Documentation/devicetree/bindings/power/power-controller.txt
> new file mode 100644
> index 0000000..e0a1abe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/power-controller.txt
> @@ -0,0 +1,18 @@
> +* Generic system power control capability
> +
> +Power-management integrated circuits or miscellaneous harware components are
> +sometimes able to control the system power. The device driver associated to these
> +components might needs to define this capability, which tells to the kernel
> +how to switch off the system. The corresponding driver must have the standard
> +property "system-power-controller" in its device node. This property marks the device as
> +able to controller the system-power. In order to test if this property is found
> +programmatically, use the helper function "of_is_system_power_controller" from
> +of.h .
> +
> +Example:
> +
> +act8846: act8846 at 5 {
> +	 compatible = "active-semi,act8846";
> +	 status = "okay";
> +	 system-power-controller;
> +}

there is no mention here that system-power-controller superseeds
poweroff-source and deprecates that.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141027/660b5436/attachment-0001.sig>
