From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 9 Feb 2017 08:34:48 +0100
Subject: [PATCH -next] rtc: sun6i: Fix return value check in
 sun6i_rtc_clk_init()
In-Reply-To: <20170209001613.21665-1-weiyj.lk@gmail.com>
References: <20170209001613.21665-1-weiyj.lk@gmail.com>
Message-ID: <20170209073448.ua6qtptmpdjkren6@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2017 at 12:16:13AM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> In case of error, the function of_io_request_and_map() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
> 
> Fixes: 847b8bf62eb4 ("rtc: sun6i: Expose the 32kHz oscillator")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170209/a15a4a4f/attachment-0001.sig>
