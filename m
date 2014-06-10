From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 Jun 2014 11:53:34 +0100
Subject: [PATCH 2/5] regulator: Add driver for Maxim 77802 PMIC regulators
In-Reply-To: <5396434D.3020402@collabora.co.uk>
References: <1402306670-17041-1-git-send-email-javier.martinez@collabora.co.uk>
 <1402306670-17041-3-git-send-email-javier.martinez@collabora.co.uk>
 <20140609193849.GE5099@sirena.org.uk>
 <5396434D.3020402@collabora.co.uk>
Message-ID: <20140610105334.GF5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 10, 2014 at 01:29:17AM +0200, Javier Martinez Canillas wrote:
> On 06/09/2014 09:38 PM, Mark Brown wrote:
> > On Mon, Jun 09, 2014 at 11:37:47AM +0200, Javier Martinez Canillas wrote:

> >> +	case REGULATOR_MODE_STANDBY:			/* switch off */
> >> +		if (id != MAX77802_LDO1 && id != MAX77802_LDO20 &&
> >> +			id != MAX77802_LDO21 && id != MAX77802_LDO3) {
> >> +			val = MAX77802_OPMODE_STANDBY;
> >> +			break;
> >> +		}
> >> +		/* no break */

> > This sounds very broken...

> The problem is that not all regulators supports the same operational modes. For
> instance regulators LDO 1, 20, 21 and 3 does not support REGULATOR_MODE_STANDBY
> so if the condition is not met a break is not needed since the default case is
> to warn that the mode is not supported.

No, it's the "switch off" comment...

> But I'll rework that logic on v2 to make it cleaner and have a break on each
> case and don't rely on case cascading.

...though you should also consider splitting things up so you have
separate ops for separate regulators if they behave differently.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140610/8897b49f/attachment.sig>
