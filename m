From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 5 Jul 2012 13:45:49 +0100
Subject: [PATCH 1/1] mfd: Fix runtime warning caused by duplicate device
 registration
In-Reply-To: <4FF58B68.5000703@linaro.org>
References: <20120703132447.GN29030@opensource.wolfsonmicro.com>
 <4FF2F82D.9080507@linaro.org>
 <20120703142123.GQ29030@opensource.wolfsonmicro.com>
 <4FF54406.3000307@linaro.org>
 <20120705094541.GK4111@opensource.wolfsonmicro.com>
 <4FF57EA9.7060107@linaro.org>
 <20120705120600.GT4111@opensource.wolfsonmicro.com>
 <4FF58571.2090807@linaro.org>
 <20120705122947.GY4111@opensource.wolfsonmicro.com>
 <4FF58B68.5000703@linaro.org>
Message-ID: <20120705124549.GD4111@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2012 at 01:41:12PM +0100, Lee Jones wrote:
> On 05/07/12 13:29, Mark Brown wrote:

> If DT is _not_ enabled, we do:

>   From platform code:
>    - Register the DB8500-PRCMU
>    - Register the AB8500

> So you see the registration is separate.

Right, so what I'm saying is that what I'd expect unless there's
something unusual going on is that you wouldn't be doing the separate
registration of the AB8500 here and would instead be passing the
platform data for the AB8500 through in the same way you pass the DT
data through.

DT and non-DT do have a very similar model for this stuff.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120705/3cfff40b/attachment.sig>
