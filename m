From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jan 2015 19:52:04 +0000
Subject: [PATCH 2/9] regulator: core: Introduce set_optimum_mode op
In-Reply-To: <1422413199-17273-3-git-send-email-bjorn.andersson@sonymobile.com>
References: <1422413199-17273-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1422413199-17273-3-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <20150128195204.GN21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 06:46:32PM -0800, Bjorn Andersson wrote:

> +	/* set most efficient regulator operating mode for load */
> +	int (*set_optimum_mode)(struct regulator_dev *, int input_uV,
> +				int output_uV, int load_uA);

This is basically fine but can you please rename this to be something
that more directly reflects the fact that we're just informing the
driver about the operating parameters - there are other things a driver
could usefully do with this, for example set current limits so that if
something starts to consume excessive current the device will flag this
as an error.

It'd also be better to split the voltage specs out into a separate
function, especially for the output voltage where obviously we have a
separate range based interface for setting that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150128/534b8c8f/attachment.sig>
