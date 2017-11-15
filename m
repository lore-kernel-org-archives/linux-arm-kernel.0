From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Nov 2017 08:48:50 +0100
Subject: [PATCH 07/10] dmaengine: amba-pl08x: Use vchan_terminate_vdesc()
 instead of desc_free
In-Reply-To: <20171114143212.8311-8-peter.ujfalusi@ti.com>
References: <20171114143212.8311-1-peter.ujfalusi@ti.com>
 <20171114143212.8311-8-peter.ujfalusi@ti.com>
Message-ID: <CACRpkdYCcLdJvNisoi942tyrC4R6vCvb0a=afhEQ4gs5fmfQAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 14, 2017 at 3:32 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> To avoid race with vchan_complete, use the race free way to terminate
> running transfer.
>
> Implement the device_synchronize callback to make sure that the terminated
> descriptor is freed.
>
> CC: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

I had to read patch 1 before I understood how the descriptor
gets free:ed now, but now I see it :)
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

(Good work with hunting down these corner cases, I'm
very happy you're doing this!)

Yours,
Linus Walleij
