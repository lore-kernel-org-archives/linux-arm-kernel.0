From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Wed, 29 Aug 2018 21:52:57 -0300
Subject: [PATCH 4/4] media: platform: Add Aspeed Video Engine driver
In-Reply-To: <1535576973-8067-5-git-send-email-eajames@linux.vnet.ibm.com>
References: <1535576973-8067-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1535576973-8067-5-git-send-email-eajames@linux.vnet.ibm.com>
Message-ID: <CAAEAJfBpmFPLTMAr+Azc-53JXHPkCU4bjtwqE6nDWUvm=J_x-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eddie,

On 29 August 2018 at 18:09, Eddie James <eajames@linux.vnet.ibm.com> wrote:
> The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs
> can capture and compress video data from digital or analog sources. With
> the Aspeed chip acting a service processor, the Video Engine can capture
> the host processor graphics output.
>
> Add a V4L2 driver to capture video data and compress it to JPEG images,
> making the data available through a standard read interface.
>
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
> ---
>  drivers/media/platform/Kconfig        |    8 +
>  drivers/media/platform/Makefile       |    1 +
>  drivers/media/platform/aspeed-video.c | 1307 +++++++++++++++++++++++++++++++++
>  3 files changed, 1316 insertions(+)
>  create mode 100644 drivers/media/platform/aspeed-video.c
>
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index 94c1fe0..e599245 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -32,6 +32,14 @@ source "drivers/media/platform/davinci/Kconfig"
>
>  source "drivers/media/platform/omap/Kconfig"
>
> +config VIDEO_ASPEED
> +       tristate "Aspeed AST2400 and AST2500 Video Engine driver"
> +       depends on VIDEO_V4L2

It seems you are not using videobuf2. I think it should simplify the read
I/O part and at the same time expose the other capture methods.

There are plenty of examples to follow.

Regards,
Eze
