From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Tue, 6 Mar 2012 15:19:51 +0400
Subject: [PATCH/RFC 2/2] arm/tegra: add timeout to PCIe PLL lock
 detection loop
In-Reply-To: <CANndwHav6JcqNOuOXcD1dSNUmVYAV=MJ+y+ud6202q6Dh42Vgw@mail.gmail.com>
References: <1331023544-6439-1-git-send-email-mad_soft@inbox.ru>
 <1331023544-6439-3-git-send-email-mad_soft@inbox.ru>
 <CANndwHav6JcqNOuOXcD1dSNUmVYAV=MJ+y+ud6202q6Dh42Vgw@mail.gmail.com>
Message-ID: <20120306111951.GA8494@rainbow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:38 Tue 06 Mar     , Andi wrote:
> Hi,
> 
> On Tue, Mar 6, 2012 at 9:45 AM, Dmitry Artamonow <mad_soft@inbox.ru> wrote:
> > ? ? ? ?/* Wait for the PLL to lock */
> > + ? ? ? timeout = 2000;
> > ? ? ? ?do {
> > ? ? ? ? ? ? ? ?val = pads_readl(PADS_PLL_CTL);
> > + ? ? ? ? ? ? ? mdelay(1);
> 
> why are you using an mdelay? If you need to sleep 1ms just use
> usleep_range or similar

This driver uses mdelay(1) in other places, so I just used it for the sake
of consistency. And as this code runs just one time on boot, there's not
really much harm in doing delay with busy loop instead of sleeping.

Anyway, I agree that sleeping is better than busy waiting in general, so
I can respin this patch using usleep_range, or else prepare incremental
patch on top of this, which will change all mdelay in driver to usleep_range.

-- 
Best regards,
Dmitry "MAD" Artamonow
