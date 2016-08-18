From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 18 Aug 2016 12:30:28 -0700
Subject: [PATCH v2] dt-bindings: touchscreen: silead gsl1680: Document
 all compatibles
In-Reply-To: <1471424340-4201-1-git-send-email-hdegoede@redhat.com>
References: <1471424340-4201-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160818193028.GA39271@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2016 at 10:59:00AM +0200, Hans de Goede wrote:
> The silead gsl1680 driver / binding supports a whole series of devices,
> list the compatibles for all of them in the binding.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Drop the "silead,mssl1680" compatible thing, the "mssl1680" name is an
>  ACPI thing and does not belong in the dt bindings
> ---
>  .../devicetree/bindings/input/touchscreen/silead_gsl1680.txt          | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
> index b0eca54..ad7f41a 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
> @@ -2,6 +2,10 @@
>  
>  Required properties:
>  - compatible		  : "silead,gsl1680"
> +			or: "silead,gsl1688"
> +			or: "silead,gsl3670"
> +			or: "silead,gsl3675"
> +			or: "silead,gsl3692"

Hmm, why do we need to document all compatible strings? We usually have
only least common denominator in drievr, and device tree uses form:

	compatible = "silead,<exact model>", "silead,gsl1680";

Rob?

BTW, I do not see OF match table in the driver, did I manage to drop it?

Thanks.

-- 
Dmitry
