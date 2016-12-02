From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 Dec 2016 17:30:24 +0100
Subject: [PATCH 2/2] arm64: dts: juno: fix cluster sleep state entry
 latency on all SoC versions
In-Reply-To: <ed75f674-feaf-9c4b-a995-3e815054918d@arm.com>
References: <1479317491-7435-1-git-send-email-sudeep.holla@arm.com>
 <1479317491-7435-2-git-send-email-sudeep.holla@arm.com>
 <ed75f674-feaf-9c4b-a995-3e815054918d@arm.com>
Message-ID: <2147537.n9PO7PDDnn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, December 1, 2016 10:11:24 AM CET Sudeep Holla wrote:
> On 16/11/16 17:31, Sudeep Holla wrote:
> > The core and the cluster sleep state entry latencies can't be same as
> > cluster sleep involves more work compared to core level e.g. shared
> > cache maintenance.
> >
> > Experiments have shown on an average about 100us more latency for the
> > cluster sleep state compared to the core level sleep. This patch fixes
> > the entry latency for the cluster sleep state.
> >
> > Fixes: 28e10a8f3a03 ("arm64: dts: juno: Add idle-states to device tree")
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: "Jon Medhurst (Tixy)" <tixy@linaro.org>
> > Reviewed-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> You missed to pick up this, I posted this along with vexpress config bus
> fix. Sorry for the confusion, I feel pull request are better/easier to
> track than single patches. I will send PR from next time if also prefer
> that. Let me know.

Ok, I've applied that to the 4.9-fixes branch. Thanks for double-checking.

	Arnd
