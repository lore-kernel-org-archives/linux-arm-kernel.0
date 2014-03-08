From: robherring2@gmail.com (Rob Herring)
Date: Sat, 8 Mar 2014 13:53:45 -0600
Subject: [RFC PATCH 0/9] drivers: dma: Add support for dma-channel router
In-Reply-To: <1394194576-23741-1-git-send-email-r.sricharan@ti.com>
References: <1394194576-23741-1-git-send-email-r.sricharan@ti.com>
Message-ID: <CAL_JsqLF6Ey1t1BV4tnFcFK-KmOU9H2nQE+ZHoZRq2r_nRTxNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 7, 2014 at 6:16 AM, Sricharan R <r.sricharan@ti.com> wrote:
> In some SoCs the dma request lines from the peripherals are
> routed to the dma-controller through a crossbar. With this the
> dma controller's available request lines are shared between the
> peripherals.
>
> This adds support to register the crossbar router associated with
> a dma-channel and let the dma-controller driver map/unmap
> the peripheral dma crossbar line to dma-controller's request
> line.

This is not a unique concept and should follow some existing pattern.
Perhaps something like interrupt-map. For the dmas property, the
parent should be the crossbar and then the crossbar block has to
translate that into the DMA controller request. All the DMA ctrlr
request connections should be described in the crossbar node. In
theory, you could have chained crossbars. This should be documented as
part of the generic DMA binding.

There are also other similar IP like CoreSight CTI which are just
signal routers. So there is probably some possibility of common code
here.

Rob
