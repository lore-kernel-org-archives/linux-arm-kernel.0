From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 19 Jun 2015 12:06:04 +0200
Subject: [PATCHv2 3/5] dmaengine: mv_xor: remove support for dmacap,* DT
 properties
In-Reply-To: <1434557086-9520-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1434557086-9520-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1434557086-9520-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150619100604.GY11732@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 06:04:44PM +0200, Thomas Petazzoni wrote:
> The only reason why we had dmacap,* properties is because back when
> DMA_MEMSET was supported, only one out of the two channels per engine
> could do a memset operation. But this is something that the driver
> already knows anyway, and since then, the DMA_MEMSET support has been
> removed.
> 
> The driver is already well aware of what each channel supports and the
> one to one mapping between Linux specific implementation details (such
> as dmacap,interrupt enabling DMA_INTERRUPT) and DT properties is a
> good indication that these DT properties are wrong.
> 
> Therefore, this commit simply gets rid of these dmacap,* properties,
> they are now ignored, and the driver is responsible for knowing the
> capabilities of the hardware with regard to the dmaengine subsystem
> expectations.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150619/a304e919/attachment-0001.sig>
