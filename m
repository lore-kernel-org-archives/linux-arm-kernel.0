From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 21:58:16 +0200
Subject: [PATCH 09/63] dmaengine: ste_dma40: Rectify incorrect
 configuration validation checking
In-Reply-To: <1367591569-32197-10-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-10-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYY7Z2invp-Eq2+n+hqdqxKx05QuKCqAe+PudU9JWGXrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:31 PM, Lee Jones <lee.jones@linaro.org> wrote:

> If we compare an event's group (dev_type / 16) with STEDMA40_DEV_DST_MEMORY
> (-1), the only way we'd obtain a positive result is if we passed -16 as a
> device type, which is unfeasible. Instead, it would be much more sane to
> compare STEDMA40_DEV_DST_MEMORY against the raw dev_type in order to expect
> the expected result.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I'd like Vinod's ACK on this before I send it to ARM SoC but tentatively
applied (and just what I wanted!)

Vinod can I have your ACK on this?

Yours,
Linus Walleij
