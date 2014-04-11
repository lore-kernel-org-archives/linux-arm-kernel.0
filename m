From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Apr 2014 13:29:02 +0100
Subject: [PATCH v4 7/9] ARM: sun7i/sun4i: dt: Add AXP209 support to
 various boards
In-Reply-To: <1397209093-10077-8-git-send-email-carlo@caione.org>
References: <1397209093-10077-8-git-send-email-carlo@caione.org>
Message-ID: <20140411122901.GE28800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 11:38:11AM +0200, Carlo Caione wrote:

> In all the DTs the min and max microvolt allowed for each regulator are actually
> the min and max voltage possible for the regulator itself. This is not safe but
> we do not have the ranges allowed for each board and the original Allwinner 
> driver does exactly this way.

Is there any code in their kernel which varies the supply voltages?  If
there isn't then simply omitting the voltage ranges is the best option,
leaving the supplies fixed.  If there is then the range it uses is a
good starting point.  In general supplies will be fixed voltage on a
given board unless there is a specific reason to vary them.

> +				regulators {
> +					compatible = "x-powers,axp20x-reg";

This compatible isn't part of the driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140411/afa8ad0f/attachment.sig>
