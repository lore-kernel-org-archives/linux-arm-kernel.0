From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 13 Sep 2011 00:28:34 +0530
Subject: [PATCH v3 4/6] DMA: PL330: Add device tree support
In-Reply-To: <1315852165-32402-5-git-send-email-thomas.abraham@linaro.org>
References: <1315852165-32402-1-git-send-email-thomas.abraham@linaro.org>
	<1315852165-32402-2-git-send-email-thomas.abraham@linaro.org>
	<1315852165-32402-3-git-send-email-thomas.abraham@linaro.org>
	<1315852165-32402-4-git-send-email-thomas.abraham@linaro.org>
	<1315852165-32402-5-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CABb+yY0QPQpfU=vvOLNG3U6idEv4Gy9btxt=-fRhMJwA+PLPzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2011 at 11:59 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> For PL330 dma controllers instantiated from device tree, the channel
> lookup is based on phandle of the dma controller and dma request id
> specified by the client node. During probe, the private data of each
> channel of the controller is set to point to the device node of the
> dma controller. The 'chan_id' of the each channel is used as the
> dma request id.
>
> Client driver requesting dma channels specify the phandle of the
> dma controller and the request id. The pl330 filter function
> converts the phandle to the device node pointer and matches that
> with channel's private data. If a match is found, the request id
> from the client node and the 'chan_id' of the channel is matched.
> A channel is found if both the values match.
>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Boojin Kim <boojin.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> Reviewed-by: Rob Herring <rob.herring@calxeda.com>
> ---

Acked-by: Jassi Brar <jassisinghbrar@gmail.com>

thanks
-jassi
