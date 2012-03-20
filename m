From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 20 Mar 2012 06:51:22 +0100
Subject: [PATCH v4 03/10] pwm: Add device tree support
In-Reply-To: <4F67E7A3.3090603@wwwdotorg.org>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-4-git-send-email-thierry.reding@avionic-design.de>
 <4F67E7A3.3090603@wwwdotorg.org>
Message-ID: <20120320055122.GA25778@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> On 03/14/2012 09:56 AM, Thierry Reding wrote:
> > This patch adds helpers to support device tree bindings for the generic
> > PWM API. Device tree binding documentation for PWM controllers is also
> > provided.
> ...
> > +static struct pwm_device *of_pwm_simple_xlate(struct pwm_chip *pc,
> > +					      const struct of_phandle_args *args)
> ...
> > +	if (args->args_count < pc->of_pwm_n_cells)
> > +		return ERR_PTR(-EINVAL);
> 
> I think you can drop that error-check given the code quoted below?
> 
> (and if not, shouldn't it be != not >= ?)
> 
> > +struct pwm_device *of_pwm_request(struct device_node *np,
> > +				  const char *propname, int index)
> ...
> > +	if (args.args_count != pc->of_pwm_n_cells) {
> > +		pr_debug("%s: wrong #pwm-cells for %s\n", np->full_name,
> > +			 args.np->full_name);
> > +		pwm = ERR_PTR(-EINVAL);
> > +		goto put;
> > +	}
> > +
> > +	pwm = pc->of_xlate(pc, &args);

Yes, you're right. It is completely redundant.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120320/657e8c0e/attachment.sig>
