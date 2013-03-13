From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Mar 2013 11:34:11 -0600
Subject: [PATCH V2 0/9] ARM: tegra: add platform suspend support
In-Reply-To: <1363154644.3998.140.camel@jlo-ubuntu-64.nvidia.com>
References: <1363060916-8897-1-git-send-email-josephl@nvidia.com>
 <513F82EB.1030407@wwwdotorg.org>
 <1363154644.3998.140.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <5140B893.9010704@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2013 12:04 AM, Joseph Lo wrote:
...
> BTW, I want to mention one thing about PMC DT bindings. Because I can't
> add all of the PMC DT bindings in one time, the PMC is related to too
> many devices to work for runtime PM and power domain control. And some
> wake up sources control for deep sleep mode (LP0). They are still under
> developing for upstream. May I add more bindings for PMC later?

With DT you are supposed to define the complete DT binding for the HW up
front. There have been some hints that incrementally defining bindings
will start to get push-back. How hard is it in this case to simply
define the entire binding right now?

That said, in practice, you can certainly incrementally define bindings
at the moment. The main issue here is to ensure that when you add the
new properties/..., then:

a) You don't change anything that's already there. The old properties
and content must continue to work without modification.

b) For all nodes/properties that are newly required, either there is a
suitable default if they are missing from the DT (as they would be for
DTs written to the old specification), /or/ the new nodes/properties
only enable new features, so that any old DT continues to work fine with
at least as many features as it always did.

If you satisfy those conditions, I believe we can still get away with
incrementally defining bindings. I don't know how long that will last
though.
