From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Mar 2013 10:35:45 +0000
Subject: [PATCH 3/6] ARM: remove fa526 CPU support
In-Reply-To: <op.wt6rbsvq2s3iss@ecaz>
References: <1363299178-8241-1-git-send-email-arnd@arndb.de>
 <5146FB70.9000706@openwrt.org> <op.wt6rbsvq2s3iss@ecaz>
Message-ID: <201303191035.45874.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 March 2013, Imre Kaloz wrote:
> I have two wbd111 boards, but their bootloader is fubared - for whatever
> reason the bootloader's ethernet support works horribly for me, as in an
> image transfer takes well over 10 mins, and 90% of the time it fails
> meantime. I have another gemini based board, which doesn't have mainline
> support, yet.
> 
> So for gemini, what I can offer is digging up the wbd111 and testing your
> patches this weekend - if that works, it can stay in mainline for another
> kernel release, and I can try to add support for the other board (so
> there would be a sane platform to test on). If you are going to drop it,
> I will likely keep it working in OpenWrt as long as those boards don't
> die on me.

Sounds good. If you are still interested in keeping the code alive, we
shouldn't drop it upstream. Can you also add a defconfig file that
enables all the gemini specific Kconfig code plus whatever you use
in OpenWRT?

Part of the reason why the platform was so broken is that it never had
a defconfig, and we didn't notice the bitrot.

	Arnd
