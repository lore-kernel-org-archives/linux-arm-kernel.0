From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 1 Nov 2016 17:44:01 -0700
Subject: [PATCH] clk: stm32f4: don't assume 48MHz clock is derived from
 primary PLL
In-Reply-To: <CAN8YU5MFX0cwUv34fAL3PSaRQNhgPZFO3PiXBdE+fVeLgGJ8ZQ@mail.gmail.com>
References: <1473318063-21782-1-git-send-email-andrea.merello@gmail.com>
 <b39d3544-9512-9e0b-2f5b-4135835009f9@st.com>
 <CAN8YU5MFX0cwUv34fAL3PSaRQNhgPZFO3PiXBdE+fVeLgGJ8ZQ@mail.gmail.com>
Message-ID: <20161102004401.GR16026@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12, Andrea Merello wrote:
> On Fri, Sep 9, 2016 at 11:57 AM, Alexandre Torgue
> <alexandre.torgue@st.com> wrote:
> > Hi Andrea,
> >
> > On 09/08/2016 09:01 AM, Andrea Merello wrote:
> >>
> >> This driver just look at the PLLs configurations set by the
> >> bootloader, but it assumes the 48MHz clock is derived from the primary
> >> PLL; however using PLLSAI is another option for generating the 48MHz
> >> clock.
> >>
> >> This patch make the driver to check for this, and eventually adjust the
> >> clock tree accordingly
> >
> >
> > Another patch-set is ongoing concerning RTC clock for stm32f4. It is
> > developed by Gabriel Fernandez (I add him directly in this reply).
> > Can you check with him how he plans to manage this RTC clock in order to
> > have something similar / coherent for SAI clocks, 48MHz ....
> >
> > Concerning this patch,
> > When I look at the clock tree I see that 48 MHz is only provided by pll
> > named "PLL". So If you use PLL SAI to provide a clock at 48 MHz, you
> > actually use SAI_A or SAI_B clock. I'm right ?
> 
> No, SAI_A and SAI_B are two other clocks output, that comes from
> PLLSAI through other divisors and muxes; here I simply look at if the
> bootloader selected the "PLL48CLK" output of the SAI PLL instead of
> the "PLL48CLK" of the primary PLL.
> 
> > I think we need to have something more configurable. Each special clock (SAI
> > / RTC /LCd ...) have to be configurable and each "parents" (PLL / PLLI2S /
> > PLLSAI) should be described at least in the driver.
> 
> Yes, there are probably other possible clock configurations that the
> driver does not recognize yet; I just added this one because I found
> it useful in real-world scenario (USB/SDcard working and core running
> at the max speed at the same time).
> 
> >
> > Gabriel,
> >
> > Can you send a draft of your patch-set for RTC clock to Andrea, in order to
> > discuss about this topic.
> >
> > Thanks

I know this is a couple months old, but the RTC patches have been
applied. Please resend this patch rebased onto clk-next and
restart this discussion if this is still important.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
