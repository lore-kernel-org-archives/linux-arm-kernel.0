From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 5 May 2017 00:58:29 +0200
Subject: [PATCH 1/1] rtc: gemini: add return value validation
In-Reply-To: <1492951687-16777-1-git-send-email-bianpan201602@163.com>
References: <1492951687-16777-1-git-send-email-bianpan201602@163.com>
Message-ID: <20170504225829.2cjck4vab7d4swu5@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/04/2017 at 20:48:07 +0800, Pan Bian wrote:
> From: Pan Bian <bianpan2016@163.com>
> 
> Function devm_ioremap() will return a NULL pointer if it fails to remap
> IO address, and its return value should be validated before it is used.
> However, in function gemini_rtc_probe(), its return value is not
> checked. This may result in bad memory access bugs on future access,
> e.g. calling the function gemini_rtc_read_time().
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/rtc/rtc-gemini.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
