From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Jun 2015 11:10:05 +0100
Subject: [PATCH 5/8] regulator: pwm-regulator: Don't assign structure
 attributes right away
In-Reply-To: <20150609070347.GE2982@x1>
References: <1433529771-24496-1-git-send-email-lee.jones@linaro.org>
 <1433529771-24496-6-git-send-email-lee.jones@linaro.org>
 <20150608180718.GR14071@sirena.org.uk> <20150609070347.GE2982@x1>
Message-ID: <20150609101005.GZ14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 09, 2015 at 08:03:47AM +0100, Lee Jones wrote:

> Admittedly this is an extreme example, but I do consider:

> 	init_data = of_get_regulator_init_data(<blah>);
> 	if (init_data)
>         	return -ENOMEM;

> ... neater than:

> 	config.init_data = of_get_regulator_init_data(<blah>);
> 	if (!config.init_data)
>         	return -ENOMEM;

Oh, I see.  I pretty much see things the other way for things where the
temporary has no other users.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150609/f9d5ce95/attachment.sig>
