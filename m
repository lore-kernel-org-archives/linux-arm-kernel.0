From: martin@kaiser.cx (Martin Kaiser)
Date: Thu, 3 Aug 2017 18:29:48 +0200
Subject: [PATCH] ARM: dts: i.MX25: add ranges to tscadc
In-Reply-To: <20170803022007.GI31819@dragon>
References: <1501704371-28151-1-git-send-email-martin@kaiser.cx>
 <20170803022007.GI31819@dragon>
Message-ID: <20170803162948.GA28042@botnar.kaiser.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Thus wrote Shawn Guo (shawnguo at kernel.org):

> On Wed, Aug 02, 2017 at 10:06:11PM +0200, Martin Kaiser wrote:
> > Add a ranges; line to the tscadc node. This creates a 1:1 mapping between
> > the addresses used by tscadc and those in its child nodes (adc, tsc).

> > Without such a mapping, the reg = ... lines in the tsc and adc nodes do
> > not create a resource. Probing the fsl-imx25-tcq and fsl-imx25-tsadc
> > drivers will then fail since there's no IORESOURCE_MEM.

> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>

> Do we need the following Fixes tag?

> Fixes: 92f651f39b42 ("ARM: dts: imx25: Add TSC and ADC support")

yes, looks like this has never worked correctly.

If you're ok with the fix, I can add the tag in v2.

> @Markus, we didn't the changes when we were submitting?

Both Markus' and Denis' mail addresses bounced...

Best regards,
Martin
