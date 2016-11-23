From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 23 Nov 2016 16:08:49 +0000
Subject: [RFC PATCH 03/11] ARM: omap: do not select HIGHMEM explicitly
In-Reply-To: <20161123154957.GD4082@atomide.com>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-4-git-send-email-vladimir.murzin@arm.com>
 <20161122095136.GU1041@n2100.armlinux.org.uk>
 <20161123154957.GD4082@atomide.com>
Message-ID: <5835BF11.6000405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/11/16 15:49, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@armlinux.org.uk> [161122 01:51]:
>> On Tue, Nov 22, 2016 at 09:26:00AM +0000, Vladimir Murzin wrote:
>>> Explicit selection of HIGHMEM breaks NOMMU builds. It seems that
>>> HIGHMEM is user selectable option, so probably it would be better to
>>> let user to make a decision on this options or, at least, move it to
>>> defconfig.
>>
>> That's kind of the point of ARCH_OMAP2PLUS_TYPICAL - it's a user
>> option to let the user select a range of options for typical OMAP2+
>> configurations, so that the user doesn't have to dig around looking
>> for multiple options, some of which are hard requirements for OMAP
>> to be functional.  OMAP is a particularly difficult case because the
>> hardware tends to be very complex.
>>
>> However, HIGHMEM should never be a requirement to boot, so this looks
>> sane.
> 
> Yeah we can add that to the defconfig:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 

Thanks!

Vladimir
