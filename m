From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 16 Feb 2011 08:53:49 -0800
Subject: platform data and mfd design question
In-Reply-To: <4D5B8F61.3090105@stericsson.com>
References: <4D5AF554.2030208@codeaurora.org> <4D5B8F61.3090105@stericsson.com>
Message-ID: <20110216165348.GB4390@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 16, 2011 at 09:48:33AM +0100, Linus Walleij wrote:
> On 02/15/2011 10:51 PM, Abhijeet Dharmapurikar wrote:
> >Msm on the other hand declares the struct mfd_cell subdevice[] array in
> >the board file and passes this on to the core driver via platfom data.

> This way the platform data tells the core driver what kind of
> silicon it has "hey, PM8058, guess what, you have an RTC!"
> which looks backwards to me, especially given that it does
> not need any fancy platform data at all, just two IRQ numbers
> which the core driver can very well handle.

Indeed, and the RTC would still be useful even without IRQ support I
imagine (it should still be able to tell you the time).
