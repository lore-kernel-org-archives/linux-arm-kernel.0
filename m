From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 13 Apr 2012 22:18:43 +0200
Subject: [PATCH] rtc: add support for Freescale SNVS RTC
In-Reply-To: <4F88515A.2020805@linaro.org>
References: <1332162269-16789-1-git-send-email-paul.liu@linaro.org>
 <20120322151156.GF2213@S2101-09.ap.freescale.net>
 <4F88515A.2020805@linaro.org>
Message-ID: <20120413201843.GF20478@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 14, 2012 at 12:16:26AM +0800, Ying-Chun Liu (PaulLiu) wrote:
> > 
> > I haven't completely understood this, and will need more study.
> > 
> 
> Hi Shawn,
> 
> About the above ioctl() related blocks. I think it is used by some user
> space libs that requires accurate time (47BIT TIME). And it have to be
> sure that the time continuously flowing so the apps wants to be notified
> that the rtc is changed dramatically by the set command.
> 
> I'm guessing that it might be related to the Multimedia binary libs. A/V
> sync or something like that. But I don't have those source code. Please
> make sure those libs are not using it.
> 
> I also see other Freescale RTC driver implement the same function. For
> example:
> http://tinyurl.com/cnp93jv
> So I guess it might be a common ioctl that Freescale uses somewhere.
> 
> So my plan is to split the IOR to a header file. And keep the rest as is.

'think', 'might' and 'something like that' are the wrong words to
convince anybody that these ioctls are needed. So unless you find real
usecases and also can convince us that it's not possible to reach your
goal using either the existing ioctls or an additional common (non fsl
specific) ioctl please just drop them.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
