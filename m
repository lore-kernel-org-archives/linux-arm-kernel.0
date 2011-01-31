From: dan.j.williams@intel.com (Dan Williams)
Date: Sun, 30 Jan 2011 21:56:02 -0800
Subject: [PATCH 2/2] dma: ipu_idmac: do not lose valid received data in
	the irq handler
In-Reply-To: <20110127092255.2cb6f0a3@wker>
References: <1296031789-1721-1-git-send-email-agust@denx.de>
	<1296031789-1721-3-git-send-email-agust@denx.de>
	<20110127092255.2cb6f0a3@wker>
Message-ID: <AANLkTinkv5PszU3-_rQx50rymJPXEc5oDkbvczbtjmfx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 27, 2011 at 12:22 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Reading the commit message again I now realize that there is
> a mistake.
>
> On Wed, 26 Jan 2011 09:49:49 +0100
> Anatolij Gustschin <agust@denx.de> wrote:
> ...
>> received data. DMA_BUFx_RDY won't be set by the IPU, so waiting
>> for this event in the interrupt handler is wrong.
>
> This should read 'DMAIC_x_CUR_BUF flag won't be flipped here by
> the IPU, so waiting for this event in the EOF interrupt handler
> is wrong.'
>
> I'll submit another patch fixing the commit message.
>

Ok, also looking for a reviewed/acked by Guennadi.

--
Dan
