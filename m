From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 18 Nov 2014 09:12:40 -0800
Subject: [PATCH v4 3/6] mfd: ti_am335x_tscadc: Remove unwanted
 reg_se_cache save
In-Reply-To: <20141118143005.GF24004@x1>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
 <1415941651-28962-4-git-send-email-vigneshr@ti.com>
 <20141118143005.GF24004@x1>
Message-ID: <20141118171240.GB3003@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 18, 2014 at 02:30:05PM +0000, Lee Jones wrote:
> On Fri, 14 Nov 2014, Vignesh R wrote:
> 
> > In one shot mode, sequencer automatically disables all enabled steps at
> > the end of each cycle. (both ADC steps and TSC steps) Hence these steps
> > need not be saved in reg_se_cache for clearing these steps at a later
> > stage.
> > Also, when ADC wakes up Sequencer should not be busy executing any of the
> > config steps except for the charge step. Previously charge step was 1 ADC
> > clock cycle and hence it was ignored.
> > 
> > Signed-off-by: Vignesh R <vigneshr@ti.com>
> > ---
> >  drivers/mfd/ti_am335x_tscadc.c       | 7 +++++--
> >  include/linux/mfd/ti_am335x_tscadc.h | 1 +
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> Code looks better now.
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> What's the plan for this series?

I am waiting for the interested parties to provide more feedback. So far
I have seen a few reports saying that they see issues with the series
applied.

-- 
Dmitry
