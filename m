From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 14 Mar 2013 09:26:25 +0800
Subject: [PATCH V2 0/9] ARM: tegra: add platform suspend support
In-Reply-To: <5140B893.9010704@wwwdotorg.org>
References: <1363060916-8897-1-git-send-email-josephl@nvidia.com>
 <513F82EB.1030407@wwwdotorg.org>
 <1363154644.3998.140.camel@jlo-ubuntu-64.nvidia.com>
 <5140B893.9010704@wwwdotorg.org>
Message-ID: <1363224385.3308.8.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-03-14 at 01:34 +0800, Stephen Warren wrote:
> On 03/13/2013 12:04 AM, Joseph Lo wrote:
> ...
> > BTW, I want to mention one thing about PMC DT bindings. Because I can't
> > add all of the PMC DT bindings in one time, the PMC is related to too
> > many devices to work for runtime PM and power domain control. And some
> > wake up sources control for deep sleep mode (LP0). They are still under
> > developing for upstream. May I add more bindings for PMC later?
> 
> With DT you are supposed to define the complete DT binding for the HW up
> front. There have been some hints that incrementally defining bindings
> will start to get push-back. How hard is it in this case to simply
> define the entire binding right now?
> 
There are still two main features for PMC that we need to define
bindings/properties in DT. One is power main the other wake up source.
But we are not there yet. Because I don't have drivers to verify them is
enough or not. If I add all the bindings right now, I believe it will be
modify later.

> That said, in practice, you can certainly incrementally define bindings
> at the moment. The main issue here is to ensure that when you add the
> new properties/..., then:
> 
> a) You don't change anything that's already there. The old properties
> and content must continue to work without modification.
> 
Yes.
> b) For all nodes/properties that are newly required, either there is a
> suitable default if they are missing from the DT (as they would be for
> DTs written to the old specification), /or/ the new nodes/properties
> only enable new features, so that any old DT continues to work fine with
> at least as many features as it always did.
> 
Yes, it's only for new features.
> If you satisfy those conditions, I believe we can still get away with
> incrementally defining bindings. I don't know how long that will last
> though.

Thanks,
Joseph
