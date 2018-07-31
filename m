From: rui.zhang@intel.com (Zhang Rui)
Date: Tue, 31 Jul 2018 14:00:58 +0800
Subject: [PATCH 0/2] dt: thermal: Fix broken cooling-maps
In-Reply-To: <20180731045151.gqsgsm6l3gwr5m4z@vireshk-i7>
References: <cover.1530766981.git.viresh.kumar@linaro.org>
 <20180731045151.gqsgsm6l3gwr5m4z@vireshk-i7>
Message-ID: <1533016858.2550.21.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?, 2018-07-31 at 10:21 +0530, Viresh Kumar wrote:
> On 05-07-18, 10:39, Viresh Kumar wrote:
> > 
> > Hi,
> > 
> > This is an attempt to fix the broken or partially defined DT
> > bindings
> > for cooling-maps. We should list every device that participates in
> > cooling down at a certain trip point, instead of just the first in
> > the
> > list as that depends on certain ordering of events to work
> > properly.
> > 
> > The first patch extends the binding to allow a list of phandles in
> > "cooling-device" property and the second patch fixes one of the
> > platform's DT.
> > 
> > This will be followed up by fixing all platform DT bindings that
> > have
> > these issues after this set is accepted.
> > 
> > The kernel also requires some changes to handle the phandle list,
> > but
> > wouldn't break with these changes as it reads the first phandle in
> > the
> > list for now. We can update that separately.
> @Zhang: Are you going to apply this for 4.19-rc1 ? There are lot of
> patches that
> I am holding up until this gets merged,
> 
I suppose this patch should go via Eduardo' tree.
Eduardo, can you please take a look at this patch set?

thanks,
rui
