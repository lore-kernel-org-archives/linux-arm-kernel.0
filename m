From: balbi@ti.com (Felipe Balbi)
Date: Thu, 18 Jul 2013 21:25:04 +0300
Subject: [PATCH 1/3] misc: Add crossbar driver
In-Reply-To: <1374165830-6367-2-git-send-email-r.sricharan@ti.com>
References: <1374165830-6367-1-git-send-email-r.sricharan@ti.com>
 <1374165830-6367-2-git-send-email-r.sricharan@ti.com>
Message-ID: <20130718182504.GA7497@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 18, 2013 at 10:13:48PM +0530, Sricharan R wrote:
> Some socs have a large number of interrupts/dma requests to service
> the needs of its many peripherals and subsystems. All of the
> requests lines from the subsystems are not needed at the same
> time, so they have to be muxed to the controllers appropriately.
> In such places a interrupt/dma controllers are preceded by an
> IRQ/DMA CROSSBAR that provides flexibility in muxing the device
> requests to the controller inputs.
> 
> The Peripheral irq/dma requests are connected to one crossbar's input
> and the output of the crossbar is connected to controller's input
> line. On POR, there are some mappings which are done by default.
> Those peripherals which do not have a mapping on POR, should be configured
> to route its requests using the crossbar.
> 
> The drivers identifies every controller's crossbar as individual devices.
> The mappings can be specified from the DT crossbar nodes and those gets mapped
> during the crossbar device's probe. The mappings can also be specified by adding
> the crossbar lines to the peripheral device nodes and map it with
> crossbar_map/unmap apis.
> 
> Signed-off-by: Sricharan R <r.sricharan@ti.com>

why isn't this done under pinctrl ? If all it does is mux DMA and IRQ
request lines, it should be written as a pinctrl driver no ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130718/fc2553ee/attachment.sig>
