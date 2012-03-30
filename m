From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 30 Mar 2012 08:24:26 +0200
Subject: [PATCH v5 05/16] pwm: Add device tree support
In-Reply-To: <20120329214717.GG4153@opensource.wolfsonmicro.com>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
 <1332945238-14897-6-git-send-email-thierry.reding@avionic-design.de>
 <20120329214717.GG4153@opensource.wolfsonmicro.com>
Message-ID: <20120330062426.GA13051@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Brown wrote:
> On Wed, Mar 28, 2012 at 04:33:47PM +0200, Thierry Reding wrote:
> > +	pwm = pwm_request_from_chip(pc, args->args[0], NULL);
> > +	if (IS_ERR(pwm))
> > +		return ERR_PTR(-ENODEV);
> 
> It feels wrong to override the error code like this rather than passing
> the error we got back to the caller.  Is there any great reason for
> doing so?

Yes, this certainly looks wrong. I must have forgotten to fix this up when
of_pwm_simple_xlate() was converted to return a struct pwm_device instead of
an int. Previous to that pwm_request_from_chip() would return NULL and
-ENODEV seemed like the proper error code for that situation.

I'll change this to just return pwm.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120330/162206ae/attachment.sig>
