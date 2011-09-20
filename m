From: cjb@laptop.org (Chris Ball)
Date: Tue, 20 Sep 2011 14:07:15 -0400
Subject: [PATCH REPOST 1/2] arm/dt: Tegra: Update SDHCI nodes to match
	bindings
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B732161E@HQMAIL01.nvidia.com>
	(Stephen Warren's message of "Tue, 20 Sep 2011 10:59:33 -0700")
References: <1316537186-26753-1-git-send-email-swarren@nvidia.com>
	<201109201943.29510.arnd@arndb.de>
	<74CDBE0F657A3D45AFBB94109FB122FF04B732161E@HQMAIL01.nvidia.com>
Message-ID: <m2d3evhyuk.fsf@bob.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 20 2011, Stephen Warren wrote:
> Arnd Bergmann wrote at Tuesday, September 20, 2011 11:43 AM:
>> On Tuesday 20 September 2011, Stephen Warren wrote:
>> > The bindings were recently updated to have separate properties for each
>> > type of GPIO. Update the Device Tree source to match that.
>> >
>> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> > Acked-by: Olof Johansson <olof@lixom.net>
>> > ---
>> > I'd previously sent these to Grant assuming they'd go in his dt/next branch,
>> > but perhaps these should go in through Arnd's arm-soc next/dt branch?
>> >
>> 
>> Which tree has the update that changed the bindings? I think it should
>> go into the same one.
>> 
>> If it's already upstream, I can take it into the fixes branch.
>
> Chris applied them to the mmc-next tree:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git
>
> which appears to be temporarily at:
>
> git://dev.laptop.org/users/cjb/mmc

Sending these via Arnd's next/dt sounds good to me.  I know we'd usually
take changes that require an atomic update through the same tree, but
Stephen said in https://lkml.org/lkml/2011/8/30/352 :

   I don't think there's actually any need for that; initializing
   Tegra's SDHCI from device-tree has never worked in mainline to date;
   it relies on patch 1 being there. And if patch 2 was there without
   patch 3, the worst that will happen is some port runs in 4-bit mode
   instead of 8-bit, which evidently works fine since I didn't even
   notice 8-bit support was missing...

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
