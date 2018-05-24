From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 May 2018 22:38:59 +0100
Subject: uImage target support on arm64
In-Reply-To: <CA+Kvs9=x4kxkj-amni+E_KVjH2qjq_mXU88Dr-x5NNyz64gfuA@mail.gmail.com>
References: <CA+Kvs9=mgW4Z=UcBZZLL82fJ=c--OXF3=B2Zbho+CfMTr8Wk-Q@mail.gmail.com>
 <20180524193449.jql27apudwaevwpf@tarshish>
 <CA+Kvs9=x4kxkj-amni+E_KVjH2qjq_mXU88Dr-x5NNyz64gfuA@mail.gmail.com>
Message-ID: <20180524213859.GA17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 11:17:19PM +0300, Ramon Fried wrote:
> On Thu, May 24, 2018 at 10:34 PM, Baruch Siach <baruch@tkos.co.il> wrote:
> > Hi Ramon,
> >
> > On Thu, May 24, 2018 at 10:05:15PM +0300, Ramon Fried wrote:
> >> I've noticed that it's not supported.
> >> Is it on purpose ?
> >
> > Yes. The 32bit load address in the uImage header in pretty limited when
> > applied to 64bit ARM64. Even for ARM zImage is the preferred kernel format for
> > quite some time now, since it allows flexible load address, as well as
> > multi-platform kernels.
> Hi Baruch.
> I though that in terms of U-boot, the new FIT image is the preferred
> kernel format.

u-boot keeps inventing new image formats for itself that are specific
to u-boot.  Not every boot loader is u-boot.

For 32-bit ARM, zImage has _always_ since day one been the preferred
format.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
