From: tushar.behera@linaro.org (Tushar Behera)
Date: Tue, 29 Oct 2013 17:15:10 +0530
Subject: [PATCH] clk: Zero-initialize memory for new clock in
 devm_clk_register
In-Reply-To: <1383043819-9123-1-git-send-email-tushar.behera@linaro.org>
References: <1383043819-9123-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <CAHbNUh1aKjkAx3xSHPeOdHH_8C6f64x6OTn_vtn_hj=TDORhBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 October 2013 16:20, Tushar Behera <tushar.behera@linaro.org> wrote:
> Earlier to commit 64c862a839a8 ("devres: add kernel standard devm_k.alloc
> functions") devres_alloc API used to zero-initialize the devres
> allocated object, but now only the devres header is zero-initialized.
>
> Since clk_register zero-initializes the memory while allocating for
> a new clock, passing explicit flag __GFP_ZERO to devres_alloc in
> devm_clk_register to match the behaviour.
>
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> ---

Please ignore this patch. Kevin Hilman already has got a nicer patch
[1] that fixes this problem at a generic level.

[1] https://lkml.org/lkml/2013/10/19/5

-- 
Tushar Behera
