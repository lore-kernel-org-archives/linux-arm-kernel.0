From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Mon, 12 May 2014 11:02:26 -0300
Subject: [PATCH v2] ARM: dts: am33xx: Move the cppi41dma node so it's
 probed early
In-Reply-To: <53705548.7020400@ti.com>
References: <1398373881-23369-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <53705548.7020400@ti.com>
Message-ID: <20140512140226.GA20360@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 May 10:29 AM, George Cherian wrote:
> On 4/25/2014 2:41 AM, Ezequiel Garcia wrote:
> >The DMA controller is needed for the USB controller to be correctly
> >registered. Therefore, if the DMA node is located at the end an unecessary
> >probe deferral is produced systematically.
> >
> >This is easily fixed by moving the node at the beggining of the child list,
> >so it's probed first.
> >
> >Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> Acked-by: George Cherian <george.cherian@ti.com>

Actually, I'm having second thoughts about this patch. I think it's really
fragile to depend on the devicetree ordering. Instead, I've prepared a patch
that forces the driver to probe the nodes in strict order, based in the
compatible string.
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
