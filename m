From: marex@denx.de (Marek Vasut)
Date: Tue, 17 Feb 2015 09:09:02 +0100
Subject: [PATCH V2 RESEND] clk: mxs: Fix invalid 32-bit access to frac
 registers
In-Reply-To: <235965536.675649.1424118291283.JavaMail.open-xchange@oxbaltgw06.schlund.de>
References: <1422645610-3052-1-git-send-email-stefan.wahren@i2se.com>
 <CAOMZO5DJ82Yyq4Ch_kKR01-yYhjn53As7ZBt91Dd5sna9Z+wXg@mail.gmail.com>
 <235965536.675649.1424118291283.JavaMail.open-xchange@oxbaltgw06.schlund.de>
Message-ID: <201502170909.02767.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, February 16, 2015 at 09:24:51 PM, Stefan Wahren wrote:
> Hi Fabio,
> 
> > Fabio Estevam <festevam@gmail.com> hat am 12. Februar 2015 um 20:08
> > geschrieben:
> > 
> > 
> > Hi Stefan,
> > 
> > On Thu, Feb 12, 2015 at 4:59 PM, Stefan Wahren <stefan.wahren@i2se.com> 
wrote:
> > > Hi Fabio,
> > > 
> > >> Fabio Estevam <festevam@gmail.com> hat am 11. Februar 2015 um 22:10
> > >> geschrieben:
> > >> 
> > >> 
> > >> On Wed, Feb 11, 2015 at 6:31 PM, Stefan Wahren
> > >> <stefan.wahren@i2se.com>
> > >> 
> > >> wrote:
> > >> >> I always get 0x5e5b5513 with or without your patch.
> > >> > 
> > >> > very strange. Do you have any idea why IO1_STABLE is permanent low?
> > >> 
> > >> On my case it is always 1.
> > > 
> > > i expected the same behavior on my hardware.
> > > 
> > > Do you use u-boot as bootloader?
> > 
> > Yes, I do.
> 
> i will try to test it with u-boot.
> 
> > >> > Can you confirm the behavior according to your flash issue?
> > >> 
> > >> In my tests IO1_STABLE stays the same.
> > > 
> > > This wasn't the intension of my second question. I wanted to know about
> > > the state of the SPI NOR flash detection process.
> > > 
> > > Does it sucessed if you apply the patch, but revert the changes in
> > > clk_ref_set_rate() from clk-ref.c?
> > 
> > I don't have my mx28evk setup available at the moment, but when I
> > applied your patch and reverted all the changes in clk-ref.c, then the
> > SPI flash detection works.
> > 
> > I haven't tested to only reverting the changes inside
> > clk_ref_set_rate(), but I can do it tomorrow.
> 
> I think the reason for the problem in the flash detection is caused by the
> misaligned access on the frac register.

Misaligned ? In which way ? Can you please elaborate on this ?
