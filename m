From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Aug 2015 22:56:17 +0100
Subject: [PATCH] ARM: keystone: add a work around to handle asynchronous
 external abort
In-Reply-To: <55CE633C.10402@ti.com>
References: <1439320409-20084-1-git-send-email-m-karicheri2@ti.com>
 <55CDF579.4050408@ti.com>
 <20150814140934.GX7557@n2100.arm.linux.org.uk>
 <55CE05EC.4040909@oracle.com> <55CE633C.10402@ti.com>
Message-ID: <20150814215617.GA7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 05:53:00PM -0400, Murali Karicheri wrote:
> We have spend some time already to debug the root cause. Do you have idea on
> how this was hunted down on OMAP that we can learn from? The bad address is
> NULL and it seems to happen very rarely and is not easily reproducible.
> Don't want to put this workaround, but we couldn't track it down either. So
> any help to debug this will be appreciated.

If you try applying Lucas' patch, you should receive the abort earlier
in the kernel boot up, which may help narrow down what is provoking it.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
