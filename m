From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 12 Oct 2012 15:00:23 +0530
Subject: [PATCH 2/3] dmaengine: dw_dmac: Enhance device tree support
In-Reply-To: <CAHp75Ve9uETO0Wx=bNbPxjOxO_MoE_bkFCHtwBZAA6+7m8fdMw@mail.gmail.com>
References: <142ef9170a2c69657d8a05ac127a9970d7b04965.1350020375.git.viresh.kumar@linaro.org>
 <91e41b4cc972d298f714cbd6f400569a9710304c.1350020375.git.viresh.kumar@linaro.org>
 <1350030203.10584.139.camel@smile>
 <CAKohpon4FZdPXFOXvVqExY=xrwozELYvNbE3_zHoRw2O0nszhw@mail.gmail.com>
 <CAHp75Ve9uETO0Wx=bNbPxjOxO_MoE_bkFCHtwBZAA6+7m8fdMw@mail.gmail.com>
Message-ID: <CAKohpokcW=zGP-OYQm-ZLhHJFRdnZZGyWZEbVWnj2rjqfb+j2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 October 2012 14:55, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> I understand your way of allocating memory, but what about using
> linked list instead of array?

I gave it a thought. Overhead was 4 bytes more per slave structure +
more cycles in filter routine (arrays are more faster :) ).

Because the DT capture is a one time activity, its better to save time
in filter fns.

> And one more thing. May be we could introduce backlink to the platform
> data in the dw_dma structure instead of copying certain parameters?

Will do that in a separate patch, outside the scope of this patchset. :)

--
viresh
