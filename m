From: r.sh.open@gmail.com (Rahul Sharma)
Date: Sat, 24 Aug 2013 12:09:40 +0530
Subject: [PATCH v2 5/5] clk/exynos5420: assign sclk_pixel id to pixel
 clock divider
In-Reply-To: <3550203.JkdqaguvYB@flatron>
References: <1377241078-11808-1-git-send-email-rahul.sharma@samsung.com>
 <1377241078-11808-6-git-send-email-rahul.sharma@samsung.com>
 <3550203.JkdqaguvYB@flatron>
Message-ID: <CAPdUM4O75Qcv6DD7NNRUG2vf+hs7bs0sFX+MAReS6JH_9B7rhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 August 2013 01:32, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Rahul,
>
> On Friday 23 of August 2013 12:27:58 Rahul Sharma wrote:
>> sclk_pixel is used to represent pixel clock divider on all exynos
>> SoCs not as a gate clock. It is queried in driver to pass as the
>> parent to hdmi clock while switching between parents. A new ID can
>> be asssigned Pixel gate clock which is currently not in use. Pixel
>> clock gate is default 'on'.
>
> This doesn't sound like a correct assumption, especially if you recall how
> common clock framework works - it disables any unclaimed clock
> automatically. Also we might want to support gating from power management
> reasons.
>
> IMHO you should simply export the dout_hdmi_pixel clock, keeping the
> original sclk_pixel exported as well.
>

Hi Tomasz,

Yea correct. I will export the divider clock and let hdmi driver use that
to pass as parent opf mout_pixel.

Regards,
Rahul Sharma.

> Best regards,
> Tomasz
>
