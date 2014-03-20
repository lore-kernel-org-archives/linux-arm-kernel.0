From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Thu, 20 Mar 2014 11:19:40 -0700
Subject: [PATCH RFC 1/4] arm64: kernel: implement DT based idle states
 infrastructure
In-Reply-To: <20140319172338.GA31368@e102568-lin.cambridge.arm.com>
References: <1395138028-19630-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1395138028-19630-2-git-send-email-lorenzo.pieralisi@arm.com>
 <CAL_Jsq+M8fCreXrd7R1m=3_LKD_+jma3Pha06hRoTPMpcOb1_g@mail.gmail.com>
 <20140318180856.GB792@e102568-lin.cambridge.arm.com>
 <CADHgK6uwUDndVHQaWU=3R7A16hc4PYJCAfMLi3uBnrDjYidPXg@mail.gmail.com>
 <20140319172338.GA31368@e102568-lin.cambridge.arm.com>
Message-ID: <CADHgK6vGf0gfVoAWO2FiXzCf-Sf_P_u+d7Dg04xn1O5t2LeKwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 March 2014 10:23, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> Rob is asking a property describing hw, and honestly unless we define
> a power consumption property value (defining what it means will be rather
> complicated though) I'd rather remove index altogether and use min_residency
> as a comparison value instead.

I like having a separate ranking for power to sort the states.  To me
it seems that min residency could be ambiguous for this.  We could
have states with inverted min_residencies: where a lower consumption
state has a lower target residency because the cost is recovered more
quickly.  Such a state might have higher latency for exit, so even
though the lower min_residency/lower power state is clearly
preferable, selection of the lower power state may be prevented by
kernel latency constraints.

Thanks,

Sebastian
