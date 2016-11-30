From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Nov 2016 23:31:21 +0100
Subject: [PATCH 1/2] bus: vexpress-config: fix device reference leak
In-Reply-To: <1479317491-7435-1-git-send-email-sudeep.holla@arm.com>
References: <1479317491-7435-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <7686444.YJLCo5m10k@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 16, 2016 5:31:30 PM CET Sudeep Holla wrote:
> From: Johan Hovold <johan@kernel.org>
> 
> Make sure to drop the reference to the parent device taken by
> class_find_device() after populating the bus.
> 
> Fixes: 3b9334ac835b ("mfd: vexpress: Convert custom func API to regmap")
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/bus/vexpress-config.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> Hi ARM-SoC team,
> 
> I am not sure if these couple of patches can be considered as fixes for
> v4.9. I will leave that to you guys.
> 
> Can you pick these couple of patches directly either for v4.9 or v4.10 ?
> I am trying to avoid single patch pull requests here. Let me know if
> you prefer PR instead.
> 

Sorry for the delay. I think it's find to wait till 4.10, so
I've applied it to next/fixes-non-critical.

	Arnd
