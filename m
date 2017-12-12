From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 12 Dec 2017 23:23:59 +0100
Subject: [PATCH] rtc: sun6i: ensure rtc is kfree'd on error
In-Reply-To: <20171122171618.2460-1-colin.king@canonical.com>
References: <20171122171618.2460-1-colin.king@canonical.com>
Message-ID: <20171212222359.GM8318@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/11/2017 at 17:16:18 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The error return path on clk_data allocation failure does not kfree
> the allocated rtc object. Fix this with a kfree of rtc on the error
> exit path.
> 
> Detected by CoverityScan, CID#1452264 ("Resource Leak")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/rtc/rtc-sun6i.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
