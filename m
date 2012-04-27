From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Apr 2012 08:41:30 +0000
Subject: [PATCH 04/17] ARM: ep93xx: use machine specific hook for late init
In-Reply-To: <4F99CF07.5020006@gmail.com>
References: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
 <ADE657CA350FB648AAC2C43247A983F002069887EDC4@AUSP01VMBX24.collaborationhost.net>
 <4F99CF07.5020006@gmail.com>
Message-ID: <201204270841.30621.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 26 April 2012, Ryan Mallon wrote:
> > 
> > See Shawn's "[PATCH 00/17] arch/arm/mach-* late_initcall cleanup".
> > 
> > I haven't looked closely at this yet. I think there may be some platforms
> > where the late_initcall's might cause a problem when making an ARM
> > unified kernel.
> 
> 
> Hmm, I see. It's a bit annoying that it makes the code less clean, but I
> can't really see any other nice way of doing it :-/.

Well, we could treat crunch as a special case and not call it through
the init_late callback but instead add a check in crunch_init() detect
the presence of crunch hardware. We don't have to replace every
late_initcall with the new method, although it only makes sense to
apply the series if we do most of them.

	Arnd
