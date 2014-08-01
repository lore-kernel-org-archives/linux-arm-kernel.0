From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Aug 2014 08:58:43 +0100
Subject: [PATCH] ARM: l2x0: fix build warning without CONFIG_OF
In-Reply-To: <1406860920-23520-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1406860920-23520-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20140801075843.GO30282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 01, 2014 at 10:42:00AM +0800, Kefeng Wang wrote:
> Commit cf9ea8f13(ARM: l2c: remove obsolete l2x0 ops for non-OF init)
> remove some obsolete l2x0 ops, the rest of ops: l2x0_cache_sync,
> l2x0_cache_sync, l2x0_disable only use under OF enable, so move them
> into OF part, or "defined but not used" warning occurs.

I'm not interested; I've stated previously that I want these warnings
to stay until such time that the code which uses them is fixed up to
use the new methods.

The warnings act as an advertisment that it needs fixing properly.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
