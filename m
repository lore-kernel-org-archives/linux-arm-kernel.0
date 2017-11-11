From: Jonathan.Cameron@huawei.com (Jonathan Cameron)
Date: Sat, 11 Nov 2017 00:37:37 +0000
Subject: [PATCH v4 0/4] fix the clock setting for SAR ADC
In-Reply-To: <CAFBinCB=2pb9dZkpSqdVAiumkSCzgaW0oejftjZNP7aYbiQJuw@mail.gmail.com>
References: <20171107140942.29243-1-yixun.lan@amlogic.com>
 <CAFBinCB=2pb9dZkpSqdVAiumkSCzgaW0oejftjZNP7aYbiQJuw@mail.gmail.com>
Message-ID: <20171111003737.000038f0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 Nov 2017 22:36:00 +0100
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Hi Yixun,
> 
> On Tue, Nov 7, 2017 at 3:09 PM, Yixun Lan <yixun.lan@amlogic.com> wrote:
> > patch [1/4]:
> >   Fix wrong SARADC/SANA clock gate bit in Meson-GXBB/GXL,
> > the published datasheets[4] also has wrong description about this.
> >   This patch should be explicitly merged *before* other patches.
> >
> > patch [2-4/4]:
> >   Drop the "sana" clock from SAR ADC module,  
> I agree with Jerome that patch 2/4 should be applied last.

Let me know when I should take this.

Thanks,

Jonathan

> when I wrote the driver I couldn't get it to work on my GXBB board
> (which unfortunately has died since then) because the clocks were
> disabled (they weren't enabled by the bootloader). people who are
> using an old .dtb would get the same problem again until the clock
> driver is merged
> 
> >   From the hardware perspective, the SAR ADC module doesn't
> > require "sana" clock to wrok. This should apply to all SoC,
> > including meson6,8, GXBB, GXL..  
> thank you for clarifying this!
> 
> > Note: the whole patchset series has been tested at GXL-P212 board,
> > we haven't got any meson6,8 board to test, so I would appreciate
> > if someone (Martin?) could help to confirm it works there.  
> I can test this on a Meson8b and a Meson8m2 board on the weekend -
> I'll let you know about the results
> 
> 
> Regards
> Martin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
