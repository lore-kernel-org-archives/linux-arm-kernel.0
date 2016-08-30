From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Aug 2016 08:41:06 +0100
Subject: [PATCH 05/33] gpio: add generic single-register fixed-direction
 GPIO driver
In-Reply-To: <1472537283.46556776@f170.i.mail.ru>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
 <87eg57e54l.fsf@belgarion.home>
 <20160829231232.GI1041@n2100.armlinux.org.uk>
 <1472537283.46556776@f170.i.mail.ru>
Message-ID: <20160830074105.GJ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 09:08:03AM +0300, Alexander Shiyan wrote:
> >???????, 30 ??????? 2016, 2:12 +03:00 ?? Russell King - ARM Linux <linux@armlinux.org.uk>:
> >
> >On Mon, Aug 29, 2016 at 09:39:54PM +0200, Robert Jarzmik wrote:
> >> Hi Russell,
> >> 
> >> Russell King < rmk+kernel@armlinux.org.uk > writes:
> >> 
> >> > Add a simple, generic, single register fixed-direction GPIO driver.
> >> > This is able to support a single register where a fixed number of
> >> > bits are used for input and a fixed number of bits used for output.
> >> >
> >> > Signed-off-by: Russell King < rmk+kernel@armlinux.org.uk >
> 
> There is a GPIO driver which already performs these tasks.
> Plaease take a look on the gpio-74xx-mmio driver.

I did, and no it doesn't, because:

1. It is either all-in or all-out, it doesn't support a mixture of
   fixed-directions for a single register.
2. It is DT-only, I need it for legacy platforms.
3. It uses the bgpio stuff, which is unsuitable for reasons already
   covered in a previous reply.

So, gpio-74xx-mmio is unsuitable.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
