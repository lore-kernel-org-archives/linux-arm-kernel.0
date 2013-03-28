From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 28 Mar 2013 00:06:57 +0000
Subject: [PATCH 07/46] regulator: ab8500: Add support of low voltage
 battery
In-Reply-To: <1363881583-15234-8-git-send-email-lee.jones@linaro.org>
References: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
 <1363881583-15234-8-git-send-email-lee.jones@linaro.org>
Message-ID: <20130328000657.GF18316@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 03:59:04PM +0000, Lee Jones wrote:
> Low voltage batteries have a wider voltage range with
> lower operating voltages. Some consumers in the platform
> may not work with the lower voltages and therefore need
> an extra regulator to boost the voltage in this case.

So, the reason I keep stopping at this commit is that the changelog
bears no relationship to what the code is actually doing - the low
voltage battery stuff is a board specific thing not the device feature
which is rather buried here...  this all suggests that there's a
confusion between device and system code here.

> This driver adds support for checking the consumers that
> need higher voltage (Vaux1, 2 and 3 regulators, 3 V SIM)
> and control the external buck/boost regulator
> accordingly.

> Note that to utilize the low voltage battery support,
> the battery voltage thresholds must be changed. This
> applies for the low battery voltage threshold of the
> battery manager and the OTP setting for the AB8500
> BattOk levels.

This all looks board specific really, there's presumably a few signals
coming out of the AB8500 but the regulator definitions themselves (and
the names they're given) look rather more specific than that.

Which bits of this are for the AB8500 external regulator feature and
which bits are the external regulators?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130328/f55b9afc/attachment.sig>
