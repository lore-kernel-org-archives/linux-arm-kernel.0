From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sun, 21 Feb 2010 14:51:25 -0800
Subject: [PATCH 2/4] s3c24xx_ts: report touch only when stylus is down
In-Reply-To: <201002212344.39633.anarsoul@gmail.com>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
	<201002211210.12306.anarsoul@gmail.com>
	<2accc2ff1002210627i25a76293x398b2806a6dbb200@mail.gmail.com>
	<201002212344.39633.anarsoul@gmail.com>
Message-ID: <20100221225125.GA18604@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 21, 2010 at 11:44:34PM +0200, Vasily Khoruzhick wrote:
> ? ????????? ?? 21 ??????? 2010 16:27:13 ????? Nelson Castillo ???????:
> > I remember I got bit by this also when I scheduled more conversions
> > without a timer; pen-up event would not get noticed. I didn't check
> > the specs to see if there was a way to configure the HW to do
> > otherwise.
> 
> UPDOWN bits in ADCDAT0 and ADCDAT1 are valid only in WAIT4INT mode, it's wrong 
> to check them in select callback because ADC is not in WAIT4INT mode.

We do put it in WAIT4INT mode rigtht there though so it looks like we
just need to move that call (well the original doing WAIT4INT | INT_UP)
before we check for pen state.

-- 
Dmitry
