From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 12 Oct 2010 16:15:11 +0200
Subject: [PATCH 0/2 v2] S3C64XX: Fix 48M clock enable
In-Reply-To: <AANLkTinCAJ1ypsQMKf75SnEU=9LcLv93ToeGQ=GkMG8w@mail.gmail.com>
References: <20101012123945.16469.2779.stgit@localhost.localdomain>
	<005701cb6a0c$be774370$3b65ca50$%szyprowski@samsung.com>
	<AANLkTinCAJ1ypsQMKf75SnEU=9LcLv93ToeGQ=GkMG8w@mail.gmail.com>
Message-ID: <005d01cb6a17$e53307f0$af9917d0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, October 12, 2010 3:49 PM Paulius Zaleckas wrote:

> >> To enable 48M clock USB PHY must be initialized since 48M
> >> is output of USB PHY PLL.
> >> So fix a problem where other devices requiring 48M clock will
> >> not work unless USB OTG driver is enabled.
> >> is_osc was removed from OTG drivers platform data and implemented
> >> as separate function s3c6400_clk_xusbxti_is_osc which should be
> >> called from machine_init. Currently there is no in-kernel users
> >> of it.
> >>
> >> This fix is only for S3C64xx family, but I am sure something
> >> similar will be needed for S5P family. I have started the work
> >> but I am unable to finnish it since I only have datasheet for
> >> S5PC100. Maybe Samsung guys could help me with this..?
> >> However current patches doesn't break S5P since it is not
> >> using s3c-hsotg driver (yet?).
> >
> > There are patches that enables the driver on S5PC110/S5PV210 series
> > on kgene/for-next tree. Please note that at least Samsung Goni and
> > Samsung Aquila uses external oscillator to supply usb clock. Please
> > refer to:
> >
> > http://git.kernel.org/?p=linux/kernel/git/kgene/linux-
> samsung.git;a=commit;h=e5e044e637228be8bdf033c0772f9e5926269ae0
> 
> Interesting patch... If Goni uses oscillator then it will fail with current
> otg driver since it will configure phy for crystal, because is_otg is not set
> in the platform data.

Right, but the interesting is that fact that it was working. I will check it
tomorrow again.

> > http://git.kernel.org/?p=linux/kernel/git/kgene/linux-
> samsung.git;a=commit;h=a33bc34103b4fc4eca13cdd61f2579857797bbf7
> 
> This patch contains some really nasty workaround for S3C64XX_OTHERS
> Mine version allows to get rid of it.

Right that approach was a hack. I really like the idea behind your patch.

> I have some preliminary version of patch for s5p. I will send it to you in
> the evening.

Ok, I will check it tomorrow.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
