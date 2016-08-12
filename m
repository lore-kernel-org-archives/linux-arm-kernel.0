From: tfiga@chromium.org (Tomasz Figa)
Date: Fri, 12 Aug 2016 16:33:09 +0900
Subject: [PATCH 6/8] drivers: platform: Remove call to
 of_dma_(con/decon)figure_ops
In-Reply-To: <1470696550-3416-7-git-send-email-sricharan@codeaurora.org>
References: <1470696550-3416-1-git-send-email-sricharan@codeaurora.org>
 <1470696550-3416-7-git-send-email-sricharan@codeaurora.org>
Message-ID: <CAAFQd5DZ0ZpW2eEm8Bvh8=di6kOgUG4bGY_iTNbVBHsj0KPmeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 9, 2016 at 7:49 AM, Sricharan R <sricharan@codeaurora.org> wrote:
> The dma_ops gets configured for the device generically during
> the device_attach call. So remove it from the platform bus probe.
> Similarly remove the deconfigure calls as well, since it is
> now called form the device_detach path.

Doesn't this patch need to be squashed with previous one to avoid
breaking things in between by having the of_dma_configure_ops() called
two times?

Best regards,
Tomasz
