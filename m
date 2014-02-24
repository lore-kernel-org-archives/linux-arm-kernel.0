From: broonie@kernel.org (Mark Brown)
Date: Mon, 24 Feb 2014 10:58:26 +0900
Subject: [RFC PATCH 3/6] PM / Voltagedomain: introduce voltage domain
 driver support
In-Reply-To: <1392755543-28335-4-git-send-email-nm@ti.com>
References: <1392755543-28335-1-git-send-email-nm@ti.com>
 <1392755543-28335-4-git-send-email-nm@ti.com>
Message-ID: <20140224015826.GU25940@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 02:32:20PM -0600, Nishanth Menon wrote:

> The current regulator model provides the basic building blocks for the
> transitions, however SoC drivers specific to each of these devices, be
> it cpufreq/devfreq have to replicate the logic for functionality.

> To simply the logic, we can hence introduce a layer that takes care
> of the mundane transition logic, registration mechanisms to provide
> the "user drivers" such as cpufreq/devfreq a generic interface, whose
> details are abstracted by the device tree description for the SoC on
> which the driver operates on.

This doesn't really provide a picture of what the generic interface
that's being offered is and...

>  drivers/power/voltdm/Kconfig                  |    5 +
>  drivers/power/voltdm/Makefile                 |    3 +
>  drivers/power/voltdm/core.c                   |  347 +++++++++++++++++++++++--
>  drivers/power/voltdm/voltage_domain_private.h |   86 ++++++
>  4 files changed, 424 insertions(+), 17 deletions(-)

...the diffstat doesn't make it obvious what the external interface is
either.  It would be much easier to review this with a clearer picture
of what it's aiming to implement.

> +	voltdm_np = of_parse_phandle(np, prop_name, 0);
> +	if (voltdm_np) {
> +		ret = of_parse_phandle_with_args(np, prop_name, "#voltdm-cells",
> +						 0, args);
> +		if (ret)
> +			return ERR_PTR(ret);

There seems to be some DT stuff going on here, is the interface DT only?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140224/98907364/attachment.sig>
