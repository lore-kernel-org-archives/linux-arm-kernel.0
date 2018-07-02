From: olof@lixom.net (Olof Johansson)
Date: Mon, 2 Jul 2018 16:27:35 -0700
Subject: [PATCH 12/15] arm: dts: highbank: Add missing OPP properties for
 CPUs
In-Reply-To: <CAL_JsqJRKMREfJ8LoDfuda8BU3g5Eq1AX5cPZGzO3uN3vUhrAQ@mail.gmail.com>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <f8a4e5c3062397736475ec599de730206846cb9b.1527244201.git.viresh.kumar@linaro.org>
 <CAL_JsqJRKMREfJ8LoDfuda8BU3g5Eq1AX5cPZGzO3uN3vUhrAQ@mail.gmail.com>
Message-ID: <20180702232735.eocdrdfwyj37577h@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2018 at 02:25:40PM -0600, Rob Herring wrote:
> On Fri, May 25, 2018 at 4:32 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > The OPP properties, like "operating-points", should either be present
> > for all the CPUs of a cluster or none. If these are present only for a
> > subset of CPUs of a cluster then things will start falling apart as soon
> > as the CPUs are brought online in a different order. For example, this
> > will happen because the operating system looks for such properties in
> > the CPU node it is trying to bring up, so that it can create an OPP
> > table.
> >
> > Add such missing properties.
> >
> > Fix other missing property (clock latency) as well to make it all
> > work.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  arch/arm/boot/dts/highbank.dts | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> ARM-SOC maintainers, Please apply this.

Applied to next/dt.


-Olof
