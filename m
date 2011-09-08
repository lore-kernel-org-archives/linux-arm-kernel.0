From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 8 Sep 2011 09:33:22 -0700
Subject: [PATCH 1/2] input: samsung-keypad: Add HAVE_SAMSUNG_KEYPAD
	config option
In-Reply-To: <CAJuYYwQg8pMaM7Y-AQD5eDqw32rMOHggL2gWOtJH_ri8gsH-yg@mail.gmail.com>
References: <1315317317-21873-1-git-send-email-thomas.abraham@linaro.org>
	<1315317317-21873-2-git-send-email-thomas.abraham@linaro.org>
	<20110907182248.GA2874@core.coreip.homeip.net>
	<CAJuYYwQg8pMaM7Y-AQD5eDqw32rMOHggL2gWOtJH_ri8gsH-yg@mail.gmail.com>
Message-ID: <20110908163322.GB17503@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2011 at 09:16:46AM +0530, Thomas Abraham wrote:
> Hi Dmitry,
> 
> On 7 September 2011 23:52, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > Hi Thomas,
> >
> > On Tue, Sep 06, 2011 at 07:25:16PM +0530, Thomas Abraham wrote:
> >> Samsung keyboard driver could be used with platforms using device tree.
> >> So the inclusion of samsung keyboard driver cannot be based on
> >> SAMSUNG_DEV_KEYPAD. A new config option HAVE_SAMSUNG_KEYPAD is added
> >> which device tree based platforms should use to include samsung keyboard
> >> driver.
> >
> > I am sorry, I do not follow... What is the difference between
> > SAMSUNG_DEV_KEYPAD and HAVE_SAMSUNG_KEYPAD? They look exactly the same.
> 
> The inclusion of platform device instance for keypad (in
> arch/arm/plat-samsung/dev-keypad.c) in the build depends on
> SAMSUNG_DEV_KEYPAD. The samsung-keypad driver is also dependent on
> SAMSUNG_DEV_KEYPAD.
> 
> In case of device tree based instantiation of keypad, compilation of
> dev-keypad.c file is not required. So SAMSUNG_DEV_KEYPAD config option
> will not be selected.In that case, the compilation of the keypad
> driver cannot be dependent on SAMSUNG_DEV_KEYPAD. There should be
> another option to select the keypad driver and so HAVE_SAMSUNG_KEYPAD
> was introduced. HAVE_SAMSUNG_KEYPAD can be selected on platforms that
> need the samsung-keypad driver but do no need the keypad platform
> device.

I still think that it is an extra option... What about the following
dependencies:

	depends on SAMSUNG_DEV_KEYPAD || OF
	depends on HAVE_CLK

although I think we should relax dependencies like I did in my other
patch. This will extend compile coverage of the driver and lessen the
chances that API changes will cause unintended breakage because noone
but Samsung platform users compile it.

Thanks.

-- 
Dmitry
