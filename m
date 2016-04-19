From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Apr 2016 01:18:28 +0200
Subject: [PATCH 0/3] arm64: defconfig updates
In-Reply-To: <1461105540-23799-1-git-send-email-stuart.yoder@nxp.com>
References: <1461105540-23799-1-git-send-email-stuart.yoder@nxp.com>
Message-ID: <7790483.f4tRIAaceA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 April 2016 17:39:00 Stuart Yoder wrote:
> This patch series was based on 4.6-rc4.
> 
> As far as I know, when doing a 'make defconfig' immediately followed by 
> 'make savedefconfig', the resulting defconfig should exactly match
> the original defconfig.  This was not the case for arm64 and patch 1 cleans
> that up.
> 
> Patch 2 enables 48-bit VA to allow certain armv8 SoCs to cover all of
> their physical memory regions. (see email thread:
> http://www.spinics.net/lists/arm-kernel/msg497210.html)
> 
> Patch 3 enables some additional device for Freescale/NXP SoCs.
> 

The series looks fine to me. I'd suggest merging it through the
platform maintainer path, e.g. having the i.MX mainainers pick
them up and forward them to arm at kernel.org for inclusion in arm-soc.

If the arm64 maintainers want to pick them up (or maybe just patches
1 and 2, which are not platform specific), that's fine too, and you
can add my

Acked-by: Arnd Bergmann <arnd@arndb.de>

We haven't come up with a really good way to deal with this kind of
update for arm64, as a lot of the changes to the defconfig file are
related to stuff that goes through arm-soc, but some other stuff
doesn't.

	Arnd
