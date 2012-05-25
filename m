From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 25 May 2012 10:50:43 -0600
Subject: [PATCH v4 5/6] of: add of_parse_phandle_with_args_ext function
In-Reply-To: <1337952980-14621-5-git-send-email-b29396@freescale.com>
References: <1337952980-14621-1-git-send-email-b29396@freescale.com>
 <1337952980-14621-5-git-send-email-b29396@freescale.com>
Message-ID: <4FBFB863.7060601@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/25/2012 07:36 AM, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> The api is used when user wants to get some more extended args except ones
> indicated by the cells_name.
> For example, gpio cells is 2.
> list = <&gpio 1 2 3 4>;

I assume either that property should be named "gpios", or ...

> If users want to get extended args including 3, 4, he can call:
> of_parse_phandle_with_args_ext(np, "gpios", "#gpio-cells", index, 2, &outargs);

The second parameter above should be "list".
