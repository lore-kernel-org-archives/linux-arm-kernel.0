From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Fri, 4 May 2012 12:26:13 +0530
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
Message-ID: <CAJe_Zhe-SqDMDGOhrYZtBBJnCYqLR0H07cPKzG4SyUxiLrgFnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 May 2012 02:47, Jon Hunter <jon-hunter@ti.com> wrote:
> From: Jon Hunter <jon-hunter@ti.com>
>
> This is based upon the work by Benoit Cousson [1] and Nicolas Ferre [2]
> to add some basic helpers to retrieve a DMA controller device_node and the
> DMA request/channel information.
>
> Aim of DMA helpers
> - The purpose of device-tree (as far as I understand), is to describe the
> ?capabilites of the hardware. Thinking about DMA controllers purely from the
> ?context of the hardware to begin with, we can describe a device in terms of
> ?a DMA controller as follows ...
> ? ? ? ?1. Number of DMA controllers
> ? ? ? ?2. Number of channels (maybe physical or logical)
> ? ? ? ?3. Mapping of DMA requests signals to DMA controller
> ? ? ? ?4. Number of DMA interrupts
> ? ? ? ?5. Mapping of DMA interrupts to channels
> - With the above in mind the aim of the DT DMA helper functions is to extract
> ?the above information from the DT and provide to the appropriate driver.
> ?However, due to the vast number of DMA controllers and not all are using a
> ?common driver (such as DMA Engine) it has been seen that this is not a
> ?trivial task.
>
Sorry for being slow, but so far I thought DT is only to provide _h/w_
specific info
to the _controller_ drivers. It was not supposed to provide any info
pertaining to
some API (dmaengine in this case).

And I believe this is one of few situations where we are better off
not generalizing
the interface - pass controller specific info in the controller
driver's specified format.
Generalizing only seems to complicate things here, when we anyway have machine
specific dtb, which could always have clients requesting and the
controllers given
dma's info in controller driver's specific format.

Perhaps I am overlooking the need to generalize. If you think so, please help me
understand by pointing out some use case for it.

Thanks.
