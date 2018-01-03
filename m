From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 3 Jan 2018 12:04:54 -0800
Subject: [RESEND PATCH v2 14/15] ASoC: qcom: apq8096: Add db820c machine
 driver
In-Reply-To: <3acca412-4ef7-6e61-d250-2b35c1fe9fe8@linaro.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-15-srinivas.kandagatla@linaro.org>
 <20180103001654.GU478@tuxbook>
 <3acca412-4ef7-6e61-d250-2b35c1fe9fe8@linaro.org>
Message-ID: <20180103200454.GC478@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 03 Jan 08:27 PST 2018, Srinivas Kandagatla wrote:

> Thanks for the review comments.
> 
> 
> On 03/01/18 00:16, Bjorn Andersson wrote:
> > On Thu 14 Dec 09:34 PST 2017, srinivas.kandagatla at linaro.org wrote:
> > 
> > > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > 
> > > uThis patch adds support to DB820c machine driver.
> > 
> > Drop 'u' and expand the message to claim that this is the machine driver
> > for 8996, used by the db820c.
> > 
> > [..]
> > > +static struct snd_soc_dai_link msm8996_dai_links[] = {
> > 
> > Are there any differences between the DAI links of apq8096 and msm8996?
> > 
> This driver is more of board specific,
> Am not 100% sure about msm8996, on apq8096 in particularly on db820c we got
> hdmi and analog audio connected via slimbus and also I2S on lowspeed
> connector.
> 

Can this be kept platform specific and the board specific routing put in
DT?

I don't think we want to have a machine-driver for each board. Right now
you have 25 dtbs in mainline, that's going to be a lot of machine
drivers...

Regards,
Bjorn
