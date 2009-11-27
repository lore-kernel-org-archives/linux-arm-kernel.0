From: daniel@caiaq.de (Daniel Mack)
Date: Fri, 27 Nov 2009 11:27:42 +0100
Subject: [PATCH 1/3] ARM: pxa/raumfeld: add platform support
In-Reply-To: <f17812d70911262146s2d044b06n8be1aec10b2c117c@mail.gmail.com>
References: <1259258341-31114-1-git-send-email-daniel@caiaq.de>
	<1259258341-31114-2-git-send-email-daniel@caiaq.de>
	<f17812d70911262146s2d044b06n8be1aec10b2c117c@mail.gmail.com>
Message-ID: <20091127102742.GQ14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Fri, Nov 27, 2009 at 01:46:57PM +0800, Eric Miao wrote:
> On Fri, Nov 27, 2009 at 1:58 AM, Daniel Mack <daniel@caiaq.de> wrote:
> > This adds support for Raumfeld's 'Controller', 'Connector', 'Speaker S'
> > and 'Speaker M' devices. They're all based on PXA303 SoCs.
> >
> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> 
> Sorry Daniel, late on this.Patches are really clean and I assume you
> have merged all the previous patchset into these three ones in your
> v2 submission right? Some minor issues see below:

Yes, that was all merged.

> ...
> > +/* inputs */
> > +#define GPIO_ON_OFF ? ? ? ? ? ?MFP_PIN_GPIO14
> > +#define GPIO_VOLENC_A ? ? ? ? ?MFP_PIN_GPIO19
> 
> This is incorrect, MFP_PIN_GPIOxx is definition for the MFP, not strictly
> equal to the GPIO number, mfp_to_gpio() is for that purpose, but for
> simplicity, I'd prefer the following definition:
> 
> #define GPIO_ON_OFF (14)
> 
> And same to all the GPIO definitions below.

I took care to use those defines with mfp_to_gpio() all over the place,
but ok, simply defining them as a pure number looks cleaner. Will resend
later.

Thanks,
Daniel
