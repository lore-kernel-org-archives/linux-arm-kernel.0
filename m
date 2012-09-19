From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 Sep 2012 08:23:49 +0900
Subject: [PATCH 1/2] ARM: Exynos4: Put PCM, Slimbus,
 Spdif clocks to off state
In-Reply-To: <CAJuYYwT443=NPZX4n2Y9TToWZ9-yH5YQyCa3iq_LRCv1XnF0WQ@mail.gmail.com>
References: <1346940968-4423-1-git-send-email-chander.kashyap@linaro.org>
 <CAJuYYwT443=NPZX4n2Y9TToWZ9-yH5YQyCa3iq_LRCv1XnF0WQ@mail.gmail.com>
Message-ID: <09a101cd96bd$d33e4030$79bac090$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> 
> On 6 September 2012 19:46, Chander Kashyap <chander.kashyap@linaro.org>
> wrote:
> > The clocks for PCM, Slimbus, Spdif added to off list in order
> > to turn them off at boot time.
> >
> > Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> > ---
> >  arch/arm/mach-exynos/clock-exynos4.c |   19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/arch/arm/mach-exynos/clock-exynos4.c b/arch/arm/mach-
> exynos/clock-exynos4.c
> > index 7cc5491..6a45c9a 100644
> > --- a/arch/arm/mach-exynos/clock-exynos4.c
> > +++ b/arch/arm/mach-exynos/clock-exynos4.c
> > @@ -627,6 +627,25 @@ static struct clk exynos4_init_clocks_off[] = {
> >                 .enable         = exynos4_clk_ip_peril_ctrl,
> >                 .ctrlbit        = (1 << 21),
> >         }, {
> > +               .name           = "pcm",
> > +               .devname        = "samsung-pcm.1",
> > +               .enable         = exynos4_clk_ip_peril_ctrl,
> > +               .ctrlbit        = (1 << 22),
> > +       }, {
> > +               .name           = "pcm",
> > +               .devname        = "samsung-pcm.2",
> > +               .enable         = exynos4_clk_ip_peril_ctrl,
> > +               .ctrlbit        = (1 << 23),
> > +       }, {
> > +               .name           = "slimbus",
> > +               .enable         = exynos4_clk_ip_peril_ctrl,
> > +               .ctrlbit        = (1 << 25),
> > +       }, {
> > +               .name           = "spdif",
> > +               .devname        = "samsung-spdif",
> > +               .enable         = exynos4_clk_ip_peril_ctrl,
> > +               .ctrlbit        = (1 << 26),
> > +       }, {
> >                 .name           = "ac97",
> >                 .devname        = "samsung-ac97",
> >                 .enable         = exynos4_clk_ip_peril_ctrl,
> > --
> > 1.7.9.5
> 
> Acked-by: Thomas Abraham <thomas.abraham@linaro.org>

Sangbeom, could you please check this one more?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
