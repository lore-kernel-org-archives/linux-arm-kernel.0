From: ivan.ivanov@linaro.org (Ivan T. Ivanov)
Date: Fri, 08 May 2015 17:17:20 +0300
Subject: [PATCH v2 2/2] arm64: dts: qcom: Add msm8916 CoreSight components
In-Reply-To: <CANLsYkyNYQf80c+8uMbZDr=kQ2YEOqy2aS8muEJsLsanDRGLOQ@mail.gmail.com>
References: <1431012969-16338-1-git-send-email-ivan.ivanov@linaro.org>
 <1431012969-16338-3-git-send-email-ivan.ivanov@linaro.org>
 <CANLsYkzNXBH0d6v1Ny_JwpW6NcKr9v0oAi9K3YfipwDgHWfMMA@mail.gmail.com>
 <1431092877.21307.18.camel@linaro.org>
 <CANLsYkyNYQf80c+8uMbZDr=kQ2YEOqy2aS8muEJsLsanDRGLOQ@mail.gmail.com>
Message-ID: <1431094640.21307.23.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Fri, 2015-05-08 at 08:13 -0600, Mathieu Poirier wrote:
> On 8 May 2015 at 07:47, Ivan T. Ivanov ivanov at linaro.org> wrote:
> > On Fri, 2015-05-08 at 07:38 -0600, Mathieu Poirier wrote:
> > > On 7 May 2015 at 09:36, Ivan T. Ivanov ivanov at linaro.org> wrote:
> > > > Add initial set of CoreSight components found on Qualcomm's 8x16 chipset.
> > > > 
> > > > 
> > > > +???????replicator at 824000 {
> > > > +               compatible = "qcom,coresight-replicator", "arm,primecell";
> > > 
> > > Shouldn't it be "qcom,coresight-replicator1x" ?
> > > 
> > 
> > 
> > 
> > True, I still wonder, why we have to have this compatible string?
> > Drivers are probed by amba_id and "arm,primecell", after all.
> > 
> 
> Drivers have their own compatible strings for historical reasons,
> something I've been meaning to fix for a long time now...
> 

Yep, I see that they have been platform drivers in the past, but now 
they are not, except coresight-replicator driver. IMHO, having
additional compatible string could lead just to confusion. 

Regards,
Ivan
