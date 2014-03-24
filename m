From: robherring2@gmail.com (Rob Herring)
Date: Mon, 24 Mar 2014 12:46:47 -0500
Subject: [PATCH RFC 1/4] arm64: kernel: implement DT based idle states
 infrastructure
In-Reply-To: <CADHgK6vGf0gfVoAWO2FiXzCf-Sf_P_u+d7Dg04xn1O5t2LeKwg@mail.gmail.com>
References: <1395138028-19630-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1395138028-19630-2-git-send-email-lorenzo.pieralisi@arm.com>
 <CAL_Jsq+M8fCreXrd7R1m=3_LKD_+jma3Pha06hRoTPMpcOb1_g@mail.gmail.com>
 <20140318180856.GB792@e102568-lin.cambridge.arm.com>
 <CADHgK6uwUDndVHQaWU=3R7A16hc4PYJCAfMLi3uBnrDjYidPXg@mail.gmail.com>
 <20140319172338.GA31368@e102568-lin.cambridge.arm.com>
 <CADHgK6vGf0gfVoAWO2FiXzCf-Sf_P_u+d7Dg04xn1O5t2LeKwg@mail.gmail.com>
Message-ID: <CAL_JsqJikdsna7KUjEwZ0qj-fdcC50M7e3e1D0LgfQuUuJQ0SA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 1:19 PM, Sebastian Capella
<sebastian.capella@linaro.org> wrote:
> On 19 March 2014 10:23, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
>> Rob is asking a property describing hw, and honestly unless we define
>> a power consumption property value (defining what it means will be rather
>> complicated though) I'd rather remove index altogether and use min_residency
>> as a comparison value instead.
>
> I like having a separate ranking for power to sort the states.  To me
> it seems that min residency could be ambiguous for this.  We could
> have states with inverted min_residencies: where a lower consumption
> state has a lower target residency because the cost is recovered more
> quickly.  Such a state might have higher latency for exit, so even
> though the lower min_residency/lower power state is clearly
> preferable, selection of the lower power state may be prevented by
> kernel latency constraints.

Perhaps you can add the min residency and exit latency times.

Another piece to consider is the affinity level of the state should
probably be the basis for 1st order sorting.

Rob
