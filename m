From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 4 Dec 2013 09:45:32 -0800
Subject: [PATCH 07/10] ASoC: ux500: Store DMA data in the DAI differently
 in the pdata and DT case
In-Reply-To: <1384859269-19801-8-git-send-email-lee.jones@linaro.org>
References: <1384859269-19801-1-git-send-email-lee.jones@linaro.org>
 <1384859269-19801-8-git-send-email-lee.jones@linaro.org>
Message-ID: <CAGa+x85c3y5+VXFjHAZYpUM0+2Tfnra6QKad7-aeUdwjSwo+Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 3:07 AM, Lee Jones <lee.jones@linaro.org> wrote:
> In this patch we do two things. Firstly, instead of open coding the
> store of DMA data in to the DAI for later use, we use the API provided.
> Secondly we create and store similar DMA data for the DT case, only
> this time we use 'struct snd_dmaengine_dai_dma_data' which is provided
> by the core for this very reason.
>
> Cc: alsa-devel at alsa-project.org
> Cc: Mark Brown <broonie@kernel.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  sound/soc/ux500/ux500_msp_dai.c | 42 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)

Today's next (next-20131204) has a new boot failure[1] on
ux500/snowball which bisected down to this commit.  Full boot log
attached.

It doesn't find the alsa device which in turn seems to prevent the
emmc rootfs from being mounted.  It boots fine to an initramfs.

Kevin

[1] http://lists.linaro.org/pipermail/kernel-build-reports/2013-December/001382.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: boot-snowball.log
Type: text/x-log
Size: 18759 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131204/88b1b30c/attachment-0001.bin>
