From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 12 Oct 2010 14:55:22 +0200
Subject: [PATCH 0/2 v2] S3C64XX: Fix 48M clock enable
In-Reply-To: <20101012123945.16469.2779.stgit@localhost.localdomain>
References: <20101012123945.16469.2779.stgit@localhost.localdomain>
Message-ID: <005701cb6a0c$be774370$3b65ca50$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, October 12, 2010 2:41 PM Paulius Zaleckas wrote:

> To enable 48M clock USB PHY must be initialized since 48M
> is output of USB PHY PLL.
> So fix a problem where other devices requiring 48M clock will
> not work unless USB OTG driver is enabled.
> is_osc was removed from OTG drivers platform data and implemented
> as separate function s3c6400_clk_xusbxti_is_osc which should be
> called from machine_init. Currently there is no in-kernel users
> of it.
> 
> This fix is only for S3C64xx family, but I am sure something
> similar will be needed for S5P family. I have started the work
> but I am unable to finnish it since I only have datasheet for
> S5PC100. Maybe Samsung guys could help me with this..?
> However current patches doesn't break S5P since it is not
> using s3c-hsotg driver (yet?).

There are patches that enables the driver on S5PC110/S5PV210 series
on kgene/for-next tree. Please note that at least Samsung Goni and
Samsung Aquila uses external oscillator to supply usb clock. Please
refer to:

http://git.kernel.org/?p=linux/kernel/git/kgene/linux-samsung.git;a=commit;h=e5e044e637228be8bdf033c0772f9e5926269ae0
http://git.kernel.org/?p=linux/kernel/git/kgene/linux-samsung.git;a=commit;h=a33bc34103b4fc4eca13cdd61f2579857797bbf7

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
