From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Oct 2011 10:35:07 +0100
Subject: [PATCH 3/3] spi/pl022: skip default configuration before
	suspending
In-Reply-To: <4E9D433E.70401@st.com>
References: <1318857163-32193-1-git-send-email-linus.walleij@stericsson.com>
	<4E9D433E.70401@st.com>
Message-ID: <20111018093507.GL21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2011 at 02:43:34PM +0530, Viresh Kumar wrote:
> On 10/17/2011 6:42 PM, Linus WALLEIJ wrote:
> > From: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>
> > 
> > The loading of the default configuration before suspending has
> > been in the driver since its inception, but it is not really
> > needed. Especially so since we take to all the trouble of
> > enabling and disabling power and clock just to do this. Let's
> > scrap this now.
> > 
> > Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  drivers/spi/spi-pl022.c |    5 -----
> >  1 files changed, 0 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> > index 0a1d8ed..29dc70f 100644
> > --- a/drivers/spi/spi-pl022.c
> > +++ b/drivers/spi/spi-pl022.c
> > @@ -2342,11 +2342,6 @@ static int pl022_suspend(struct amba_device *adev, pm_message_t state)
> >  		return status;
> >  	}
> >  
> > -	amba_vcore_enable(adev);
> > -	amba_pclk_enable(adev);
> > -	load_ssp_default_config(pl022);
> > -	amba_pclk_disable(adev);
> > -	amba_vcore_disable(adev);
> >  	dev_dbg(&adev->dev, "suspended\n");
> >  	return 0;
> >  }
> 
> Reviewed-by: Viresh Kumar <viresh.kumar@st.com>

This definitely conflicts with patches I have queued for this window.
