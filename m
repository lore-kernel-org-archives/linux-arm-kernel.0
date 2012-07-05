From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 5 Jul 2012 14:57:20 +0100
Subject: [PATCH 1/1] mfd: Fix runtime warning caused by duplicate device
 registration
In-Reply-To: <4FF59C7C.5020406@linaro.org>
References: <20120705120600.GT4111@opensource.wolfsonmicro.com>
 <4FF58571.2090807@linaro.org>
 <20120705122947.GY4111@opensource.wolfsonmicro.com>
 <4FF58B68.5000703@linaro.org>
 <20120705124549.GD4111@opensource.wolfsonmicro.com>
 <4FF58ED6.40106@linaro.org>
 <20120705130306.GI4111@opensource.wolfsonmicro.com>
 <4FF592A9.5050706@linaro.org>
 <20120705132021.GJ4111@opensource.wolfsonmicro.com>
 <4FF59C7C.5020406@linaro.org>
Message-ID: <20120705135719.GK4111@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2012 at 02:54:04PM +0100, Lee Jones wrote:
> On 05/07/12 14:20, Mark Brown wrote:

[Moving registration to the MFD]
> >But surely this would, if anything, remove code?  You already have the
> >code to do the registration in the MFD so all you're going to be doing
> >here is removing the code from

> No, it will add platform code if we were to register the ab8500 from
> the platform area.

Why would this be the case?  You've already got registration code in
there for use in DT...

> >Hrm, the usual pattern for this stuff is that the DT is parsed into
> >platform data so the DT code is isolated to the parser.  It sounds like
> >you've got a very different structure here?

> Yes we do. Ref that commit ID I sent you you a few days ago:

> 5f3fc8adeec9bb12742fbfa777fa1947deda21a2

This doesn't appear to reference the platform data?

> >Well, it also introduces code into mainline which is likely to be used
> >as a template by other people - I'd be especially worried about the next
> >ST platform ending up repeating the same mistakes.

> There are no mistakes. It would work for other platforms. :)

Working and good idea aren't the same thing!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120705/cb0022f5/attachment-0001.sig>
