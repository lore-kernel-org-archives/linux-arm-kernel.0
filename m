From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Sep 2010 09:25:44 +0100
Subject: [PATCH v5 3/7] wireless: wl12xx: add platform data passing support
In-Reply-To: <AANLkTikAFCd+3ggZKhQXY=+bG==KgLkv3qNVdEGa=GBX@mail.gmail.com>
References: <1283376410-9999-1-git-send-email-ohad@wizery.com>
	<1283376410-9999-4-git-send-email-ohad@wizery.com>
	<AANLkTi=goLEUqM1XQ__PrGu4=Erw2utaNP4qFmSgRta2@mail.gmail.com>
	<20100906120716.GE20903@n2100.arm.linux.org.uk>
	<AANLkTikAFCd+3ggZKhQXY=+bG==KgLkv3qNVdEGa=GBX@mail.gmail.com>
Message-ID: <20100915082544.GA4625@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 06, 2010 at 09:42:41PM +0200, Micha? Miros?aw wrote:
> W dniu 6 wrze?nia 2010 14:07 u?ytkownik Russell King - ARM Linux
> <linux@arm.linux.org.uk> napisa?:
> > On Sat, Sep 04, 2010 at 02:23:19PM +0200, Micha? Miros?aw wrote:
> >> 2010/9/1 Ohad Ben-Cohen <ohad@wizery.com>:
> >> > Add a simple mechanism to pass platform data to the
> >> > SDIO instances of wl12xx.
> [cut patch]
> >> Why do you need all that copying? Isn't the data constant?
> >
> > The first copy is to allow platforms to have their data marked with
> > __initdata. ?The second copy probably isn't necessary, but avoids
> > problems where the driver may decide to modify the platform data.
> 
> Sorry for pushing at this, but why would you mark data that's meant to
> be used after init phase as __initdata?

Because you may have many instances of the data (due to multiple platform
support), and only need one of them at run-time.
