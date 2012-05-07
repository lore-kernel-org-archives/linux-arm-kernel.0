From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 May 2012 08:58:00 +0100
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <20120507075800.GL26481@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2012 at 11:10:48AM +0800, Haojian Zhuang wrote:
> If resource region isn't requested, component devices will fail to request
> their resources.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>

This looks wrong.

This driver looks broken.  IO regions are for PC IO stuff, not for I2C
buses.  There is no resource reservation system in the kernel for
registers on I2C devices.
