From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 28 Oct 2014 09:45:16 +0100
Subject: [PATCH 1/8] regulator: max77802: Remove support for board files
In-Reply-To: <544E9EB2.2010408@collabora.co.uk>
References: <1414422226-10948-1-git-send-email-k.kozlowski@samsung.com>
 <1414422226-10948-2-git-send-email-k.kozlowski@samsung.com>
 <544E9EB2.2010408@collabora.co.uk>
Message-ID: <1414485916.24949.15.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On pon, 2014-10-27 at 20:36 +0100, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 10/27/2014 04:03 PM, Krzysztof Kozlowski wrote:
> > The driver is used only on Exynos based boards with DTS support.
> > Convert the driver to DTS-only version.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> >  drivers/regulator/max77802.c | 44 +++++++++++++++-----------------------------
> >  1 file changed, 15 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/regulator/max77802.c b/drivers/regulator/max77802.c
> > index 5839c4509e1f..61d03e9f8acf 100644
> > --- a/drivers/regulator/max77802.c
> > +++ b/drivers/regulator/max77802.c
> 
> The original ChromeOS max77xxx driver supported both DT and platform data
> configuration and that's why the max77802 driver was not DT-only.

If you mean custom vendor kernel (probably 3.4, 3.8 or 3.10 with board
files) then we shouldn't care. It is out of tree. The driver is for the
mainline kernel.

> 
> But I looked at the ChromeOS kernel now and indeed even in that tree there
> are no board files using the max77802 platform data so I agree that it
> should be removed.
> 
> Acked-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Thanks! However Mark had some comments which will reorganize the patch
completely. I'll be sending next version and probably I would need your
ack and testing again.

Best regards,
Krzysztof

> 
> Best regards,
> Javier
