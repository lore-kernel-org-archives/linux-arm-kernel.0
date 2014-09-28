From: broonie@kernel.org (Mark Brown)
Date: Sun, 28 Sep 2014 11:33:01 +0100
Subject: [PATCH v1 1/3] regulator: act8865: Add support to turn off all
 outputs
In-Reply-To: <1411834906-9533-1-git-send-email-romain.perier@gmail.com>
References: <1411834906-9533-1-git-send-email-romain.perier@gmail.com>
Message-ID: <20140928103301.GN27755@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 27, 2014 at 04:21:44PM +0000, Romain Perier wrote:
> When the property "active-semi,system-power-controller" is found in the
> devicetree, the function pm_power_off is defined. This function sends the
> rights bit fields to the global off control register. shutdown/poweroff
> commands are now supported for hardware components which use these PMU.

We really need to come up with a standard property for this and document
it rather than continuing to add individual device specific properties
all doing the same thing, and probably also some helper code and/or a
standard operation for this - there's a lot of drivers implementing the
same pattern here.

> +	if (dev->of_node &&
> +	    of_property_read_bool(dev->of_node,
> +				  "active-semi,system-power-controller")) {
> +		act8865_i2c_client = client;

Indentation seems messed up here - tabs vs spaces?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140928/60d61c13/attachment-0001.sig>
