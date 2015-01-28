From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jan 2015 20:06:00 +0000
Subject: [RFC V2] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <cbe949d7a69c3b16a3e9d6e5429eb81d3ae9d8b9.1422009157.git.viresh.kumar@linaro.org>
References: <cbe949d7a69c3b16a3e9d6e5429eb81d3ae9d8b9.1422009157.git.viresh.kumar@linaro.org>
Message-ID: <20150128200600.GR21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 04:14:50PM +0530, Viresh Kumar wrote:

> +- opp-listN:
> +  List of nodes defining performance points. Following belong to the nodes
> +  within the opp-lists.

Why is there the N here?  It doesn't correspond to the examples...

> +  Required properties:
> +  - opp-khz: Frequency in kHz
> +  - opp-microvolt: voltage in micro Volts

I thought the goal here was to specify ranges?

> +- oppN:
> +  Operating performance point node per device. Devices using it should have its
> +  phandle in their "operating-points-v2" property.
> +
> +  Required properties:
> +  - compatible: allow OPPs to express their compatibility.
> +  - opp-list: phandle to opp-list defined above.

I don't understand what that compatible property is intended to mean and
I expect other readers might be similarly confused - is it a standard
compatbile property meaning this noe corresponds to some sort of device?

There also appears to be no code matching these bindings...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150128/e6dd0d9e/attachment.sig>
