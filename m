From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 20 Jun 2017 11:11:32 +0800
Subject: [PATCH 1/2] ASoC: add bindings for ZTE zx-aud96p22 audio codec
In-Reply-To: <20170619161606.g6nabi2w5mmmjbcw@sirena.org.uk>
References: <1497708574-22380-1-git-send-email-shawnguo@kernel.org>
 <1497708574-22380-2-git-send-email-shawnguo@kernel.org>
 <20170619161606.g6nabi2w5mmmjbcw@sirena.org.uk>
Message-ID: <20170620031131.GB4818@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 19, 2017 at 05:16:06PM +0100, Mark Brown wrote:
> On Sat, Jun 17, 2017 at 10:09:33PM +0800, Shawn Guo wrote:
> 
> > +Optional properties:
> > + - zte,pa-gpios: The GPIO to enable external power amplifier
> 
> If there's an external power amplifier this is a separate chip to this
> CODEC and should therefore be separately controlled and integrated as
> part of the machine integration.

Yes, that should be the best.  But we do not have a particular machine
driver for our platform, and we are using simple-audio-card driver
instead.  I'm not sure if it's generic enough to patch simple-audio-card
driver support this pa-gpios, so chose to fold this quick change in the
codec driver.

Should I patch simple-audio-card driver to support pa-gpios property
and create a DAPM widget with event for it?  I'm currently using
SND_SOC_DAPM_OUT_DRV_E.  Is it the correct one?

Shawn
