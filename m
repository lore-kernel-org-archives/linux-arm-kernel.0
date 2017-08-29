From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 29 Aug 2017 12:02:41 +0200
Subject: [PATCH V3 2/8] drivers: boot_constraint: Add
 boot_constraints_disable kernel parameter
In-Reply-To: <20170829063734.GC12198@kroah.com>
References: <cover.1501578037.git.viresh.kumar@linaro.org>
 <4bec0c3e58f76e06e5305c5ddbab859e2a87935e.1501578037.git.viresh.kumar@linaro.org>
 <20170829063734.GC12198@kroah.com>
Message-ID: <20170829100241.GB3101@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-08-17, 08:37, Greg Kroah-Hartman wrote:
> On Tue, Aug 01, 2017 at 02:53:43PM +0530, Viresh Kumar wrote:
> > +	boot_constraints_disable
> > +			Do not set any boot constraints for devices.
> 
> Shouldn't that be the default?  As really, that is what the situation is
> today, why force everyone to always enable the disable value?  And
> enabling a value to disable something is usually a sign of bad naming...

I will explain once again how it is getting used and then will do whatever you
suggest.

- Platforms that don't need boot constraints should not enable the CONFIG in the
  first place. Though we use the same kernel image on multiple hardware types
  many times.
- If a platform doesn't have a platform-specific driver that adds constraints at
  boot, then the boot constraint core wouldn't get into picture at all and it is
  as good as being disabled.
- And the above boot-argument (boot_constraints_disable) is used ONLY in the
  case where the platform driver is adding boot constraints at runtime.

So, the boot-constraints are disabled by default for everyone even if the
configuration is enabled. And that's why I named it the way it is right now.

Do you still feel that it needs to be renamed? 

-- 
viresh
