From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Feb 2013 22:25:58 +0000
Subject: [v2 3/3] ARM: tegra: Unify Device tree board files
In-Reply-To: <511AAB81.4000306@wwwdotorg.org>
References: <5119849B.1070300@wwwdotorg.org>
 <201302121732.14960.arnd@arndb.de> <511AAB81.4000306@wwwdotorg.org>
Message-ID: <201302122225.58322.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 February 2013, Stephen Warren wrote:
> I believe U-Boot enabled -ffunction-sections -fdata-sections or similar
> (recently?) to get this kind of behaviour. I wonder why the kernel
> didn't need that. Perhaps -O2 is more aggressive (within a file at
> least) than I thought.

-ffunction-sections works across files, while the trick I described
only works on file static symbols. David Woodhouse at some point
had a working kernel build with -ffunction-sections but for some
reason that never got merged.

	Arnd
