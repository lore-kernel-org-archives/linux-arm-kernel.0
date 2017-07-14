From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 14 Jul 2017 10:23:36 -0700
Subject: [PATCH 1/2] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <6ca041fa-533d-6c6b-8c77-4c079cb7e9f6@codeaurora.org>
References: <1499982763-29619-1-git-send-email-timur@codeaurora.org>
 <1499982763-29619-2-git-send-email-timur@codeaurora.org>
 <20170714171148.GH22780@codeaurora.org>
 <6ca041fa-533d-6c6b-8c77-4c079cb7e9f6@codeaurora.org>
Message-ID: <20170714172336.GO20973@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 14 Jul 10:17 PDT 2017, Timur Tabi wrote:

> On 07/14/2017 12:11 PM, Stephen Boyd wrote:
> 
> > > +/*
> > > + * Request a GPIO. If the number of pins for this GPIO group is zero,
> > > + * then assume that the GPIO is unavailable.
> > > + */
> > > +static int msm_request(struct pinctrl_dev *pctldev, unsigned int offset)
> > 
> > These names are awful. Reminds me of the serial driver that has
> > functions like msm_reset(). But when in Rome this is how it goes
> > I suppose.
> 
> I can change it to msm_pinctrl_request().
> 

msm_pinmux_request()

Regards,
Bjorn
