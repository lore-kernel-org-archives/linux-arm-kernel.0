From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 12 Feb 2017 00:39:21 +0100
Subject: [PATCH -next] rtc: sun6i: Fix return value check in
 sun6i_rtc_clk_init()
In-Reply-To: <20170209001613.21665-1-weiyj.lk@gmail.com>
References: <20170209001613.21665-1-weiyj.lk@gmail.com>
Message-ID: <20170211233921.brhtcoaozzhyw2wn@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2017 at 00:16:13 +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> In case of error, the function of_io_request_and_map() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
> 
> Fixes: 847b8bf62eb4 ("rtc: sun6i: Expose the 32kHz oscillator")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/rtc/rtc-sun6i.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
