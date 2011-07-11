From: dan.j.williams@intel.com (Dan Williams)
Date: Mon, 11 Jul 2011 14:39:17 -0700
Subject: [PATCH] dmaengine: add dma_ctrl_cmd to pass buffer stride
	configuration
In-Reply-To: <CAKnu2MqzSm8BVK4z9E-ud8e_jUohDfSfYO9aW-oN3RFw4p7GrA@mail.gmail.com>
References: <1310310203-12288-1-git-send-email-sundaram@ti.com>
	<CAKnu2MqzSm8BVK4z9E-ud8e_jUohDfSfYO9aW-oN3RFw4p7GrA@mail.gmail.com>
Message-ID: <CAA9_cmeWUjiTghKbjAvith5c6z9PDVdFSeK55RYWfyQKFSjA+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 2:28 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 2011/7/10 Sundaram Raju <sundaram@ti.com>:
>
>> Added new dma_ctrl_cmd TI_DMA_STRIDE_CONFIG to pass the TI DMA
>> controller specific configurations on how a buffer must be walked
>> through and how data is picked for transfer based on a specified
>> pattern over the channel.
>>
>> The configuration passed is specific to the TI DMA controller used.

...and I suspect the slave device drivers that use TI DMA are not
expected to ever work with other dmaengines?  Likely the case, but
just wondering out loud.

>> Signed-off-by: Sundaram Raju <sundaram@ti.com>
>
> This is exactly how I think we should do this.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
