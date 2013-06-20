From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 10:02:01 +0200
Subject: [PATCH RFC 0/2] Extend multi_v7_defconfig
In-Reply-To: <51C291D0.6000401@monstr.eu>
References: <1371664384-24974-1-git-send-email-soren.brinkmann@xilinx.com>
 <201306192046.41005.arnd@arndb.de> <51C291D0.6000401@monstr.eu>
Message-ID: <201306201002.01702.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 June 2013, Michal Simek wrote:
> On 06/19/2013 08:46 PM, Arnd Bergmann wrote:
> > On Wednesday 19 June 2013, Soren Brinkmann wrote:
> >> I don't know how much a defconfig is supposed to provide, hence as RFC.
> >> This patches are needed for booting Zynq into a minimum ramfs based
> >> system with a serial console.
> > 
> > In my opinion we should provide enable all the platform specific drivers
> > in the defconfigs, as well as everything needed to boot the system,
> > to get proper compile coverage as well as the ability to test changes
> > easily. Your patches look good. Michal, would you apply them and
> > send another pull request or should I just take them directly?
> 
> Soren asked me 2 days ago if make sense to create zynq defconfig or not.
> I just suggested him to better extend this multi_v7_defconfig.
> But still question is if we can/should create zynq specific defconfig?
> Or are you going to remove all of these platform specific defconfig?

We don't have a consistent policy across platforms at the moment.
Traditionally we had multiple defconfigs per platform, in some cases
one per board, but moving towards one defconfig per platform at
the moment.

I guess whether or not to have a separate defconfig for one platform
or to use only multi_*_defconfig is a question of how many people
would use a zynq_defconfig in practice.

> Definitely agree that multi_v7 defconfig should enable everything needed
> to boot the system.
> Does it also mean that we should also enable all zynq drivers
> to get better compile coverage?

I would say yes.

My feeling is that multi_v7_defconfig should enable all hardware
support for the platforms in it, and that users would take it
as a starting point if they want to have a configuration for
an embedded system, disabling everything they don't need.

	Arnd
