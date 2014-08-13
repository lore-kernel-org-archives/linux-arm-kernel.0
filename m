From: broonie@kernel.org (Mark Brown)
Date: Wed, 13 Aug 2014 13:29:10 +0100
Subject: [PATCH 6/6] ARM: dts: Add tps65090 FETs constraints
In-Reply-To: <53EB4CA0.3010006@collabora.co.uk>
References: <1407861868-20097-1-git-send-email-javier.martinez@collabora.co.uk>
 <1407861868-20097-7-git-send-email-javier.martinez@collabora.co.uk>
 <20140812172552.GU17528@sirena.org.uk>
 <53EA61B9.2070805@collabora.co.uk>
 <20140812212757.GY17528@sirena.org.uk>
 <53EB4CA0.3010006@collabora.co.uk>
Message-ID: <20140813122910.GQ17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 01:31:44PM +0200, Javier Martinez Canillas wrote:

Please fix your mailer to word wrap at less than 80 columns, it makes
your mails very hard to read when replying.

> On 08/12/2014 11:27 PM, Mark Brown wrote:

> > Well, I think the question is if you understand where those numbers come
> > from and if they make sense.  I've not seen the schematic for the board
> > so I can't comment but it is quite unusual to see ranges listed for so
> > many supplies, for things like SD it's obviously normal but things like
> > video_mid are a bit more surprising.  Does anything actually vary those
> > voltages?

> You are right, in fact even the voltage for the SD supply (tps65090 fet4) does
> not change but still their constraints have to be defined, since it is used as a
> vmmc-supply and the series "Adding UHS support for dw_mmc driver" [0] calls
> mmc_regulator_get_ocrmask()/mmc_regulator_set_ocr() for mmc->supply.vmmc.

No, that makes no sense.  If the voltage isn't allowed to change why
should the constraints be specifying a range of voltages for it to be
set to, especially a range with more than one value in it?

Please try to think about what you're doing in design terms rather than
just bashing on things until you get something that works in your use
case, it's important that things are understandable so that we avoid
fragility and special casing.

> For fixed regulators (like fet4), mmc_regulator_set_ocr() just skips varying the
> regulator voltage but still expects to be able to obtain its voltage.

Which can be done with regulator_get_voltage().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140813/ccb4533e/attachment.sig>
