From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Sep 2014 16:00:00 +0200
Subject: [PATCH 0/4] ARM: mvebu: minor Armada 370 RD improvements
In-Reply-To: <20140911134323.GB29780@lunn.ch>
References: <1410429419-29820-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140911134323.GB29780@lunn.ch>
Message-ID: <20140911160000.55a4de80@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Thu, 11 Sep 2014 15:43:23 +0200, Andrew Lunn wrote:

> All looks O.K. to me
> 
> Acked-by: Andrew Lunn <andrew@lunn.ch>

Thanks!

> A point for discussion, triggered by 3/4. We have repeatedly seen
> issues with modular builds, which we don't see with everything built
> in. Can we improve our testing? Is there is way to take for example
> mvebu_v7_defconfig and turn any y tristate options into m? Build and
> boot? Get this added to the boot test farms?

I indeed agree that we are not testing much the modular case, but:

 1/ In my case, a mvebu_v7_defconfig where most the stuff would become
    enabled as a module would make mvebu_v7_defconfig pretty much
    useless for my daily work. When I'm doing active development, I
    typically have everything built-in including the initramfs itself,
    so that I don't rely on any storage/network to get the rootfs and
    additional kernel drivers.

 2/ I don't think it would change much in terms of runtime coverage:
    the tests done on the boot farm are just boot tests, I don't think
    they load any kernel module. We could ask Kevin and Olof what
    rootfs they use, but most likely it's some very small rootfs that
    doesn't even have udev/mdev for automatic module loading. So no
    module would be loaded, which would mean that a mvebu_v7_defconfig
    with everything as a module would actually test *less* thing than a
    configuration that has everything built in.

So, I agree on the observation, but I'm unsure the proposed solution
will really solve or even improve the situation :/

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
