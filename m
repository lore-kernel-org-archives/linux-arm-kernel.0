From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 15 Apr 2014 19:02:27 -0300
Subject: [PATCH] ARM: dts: imx27-pdk: Add PMIC support
In-Reply-To: <20140415215819.GA24070@n2100.arm.linux.org.uk>
References: <1397598912-5464-1-git-send-email-festevam@gmail.com>
 <20140415215819.GA24070@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5DwUGJvWxH2zBfQNf4stxm0LHh-BrAZ9Gvabwf-_B_RUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 6:58 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Apr 15, 2014 at 06:55:12PM -0300, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> imx27-pdk has a MC13783 PMIC connected to CSPI2 port.
>>
>> Add support for it.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>
> The issue I referred to in my reply to your oops does still need fixing
> (and testing whether it fixes the oops.)
>
> It's really not on to code drivers such that it's possible to use
> resources before they are initialised.  That means mutexes and locks
> must be initialised before requesting (threaded) IRQs if they're used
> by those functions.
>
> In your case, that mutex *definitely* needs initialisation before the
> threaded IRQ handler is requested.

Yes, I agree. I will look at it.

The dt file I sent initially had the wrong SPI port connected to the PMIC.

The PMIC is connected to SPI2 (spi1 in Linux), not SPI1 (spi0 in Linux).

Now it probes correctly, but yes, I will address the issue you raised.

Thanks,

Fabio Estevam
