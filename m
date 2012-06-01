From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 1 Jun 2012 09:48:51 +0100
Subject: [PATCH 08/22] regulator: Change ab8500 match names to reflect
 Device Tree
In-Reply-To: <4FC846CC.20801@linaro.org>
References: <1338353260-10097-9-git-send-email-lee.jones@linaro.org>
 <CACRpkdbQv8Q07iRAmG3UQRm7UNDi_Y+s_vvACDKKxR9tg+1iqg@mail.gmail.com>
 <20120530100302.GD9947@opensource.wolfsonmicro.com>
 <CAF2Aj3gZMF9ev9B46rBM+aY-srwthef09ad2CWfuXXFHmqqAjA@mail.gmail.com>
 <20120530121547.GJ9947@opensource.wolfsonmicro.com>
 <4FC63632.4030504@linaro.org>
 <20120530151119.GN9947@opensource.wolfsonmicro.com>
 <4FC63B39.6040905@linaro.org>
 <20120530164152.GP9947@opensource.wolfsonmicro.com>
 <4FC846CC.20801@linaro.org>
Message-ID: <20120601084850.GJ24139@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2012 at 12:36:28PM +0800, Lee Jones wrote:

> This:

> >sdi at 80126000 {
> >         vmmc-supply = <&ab8500_ldo_aux3_reg>;
> >};

> Is the same as, and will cause no more issues than:

> >static struct regulator_consumer_supply ab8500_vaux3_consumers[] = {
> >        REGULATOR_SUPPLY("vmmc", "sdi0"),
> >};

> ... because only nodes which we care about (dictated by compatible
> declaration protections) will be parsed. So different platforms will
> not affect each other.

What makes you say the two are equivalent?  The former is a reference
from a consumer device to a named regulator while the latter is a
reference from a regulator to a named consumer.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120601/da25c84f/attachment.sig>
