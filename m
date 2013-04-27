From: simon.guinot@sequanux.org (Simon Guinot)
Date: Sat, 27 Apr 2013 16:03:31 +0200
Subject: [PATCHv1 1/3] hwmon: Add support for GMT G762/G763 PWM fan
 controller
In-Reply-To: <63961d39aee9db94767f28fd441312bec2029473.1366753420.git.arno@natisbad.org>
References: <cover.1366753420.git.arno@natisbad.org>
 <63961d39aee9db94767f28fd441312bec2029473.1366753420.git.arno@natisbad.org>
Message-ID: <20130427140331.GL17771@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 12:05:56AM +0200, Arnaud Ebalard wrote:
> +	/*
> +	 * Set default configuration values before passing the structure
> +	 * to OF helpers to overload them using those provided by .dts
> +	 * file (if any). Final config is then commited.
> +	 */
> +	g762_config_init(&conf);
> +	g762_config_of_overload(client, &conf);
> +	err = g762_config_commit(client, &conf);
> +	if (err)
> +		goto out;

One more comment... Sorry for the multiple replies :)

I am not sure that applying a configuration anyway is a good idea.
I think it could be best to stick with the bootloader configuration if
no platform data nor device tree data are given.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130427/d3d421c7/attachment.sig>
