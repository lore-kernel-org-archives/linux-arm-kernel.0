From: r.sricharan@ti.com (Sricharan R)
Date: Mon, 10 Mar 2014 19:28:55 +0530
Subject: [RFC PATCH 0/9] drivers: dma: Add support for dma-channel router
In-Reply-To: <CAL_JsqLF6Ey1t1BV4tnFcFK-KmOU9H2nQE+ZHoZRq2r_nRTxNw@mail.gmail.com>
References: <1394194576-23741-1-git-send-email-r.sricharan@ti.com>
 <CAL_JsqLF6Ey1t1BV4tnFcFK-KmOU9H2nQE+ZHoZRq2r_nRTxNw@mail.gmail.com>
Message-ID: <531DC51F.50309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Sunday 09 March 2014 01:23 AM, Rob Herring wrote:
> On Fri, Mar 7, 2014 at 6:16 AM, Sricharan R <r.sricharan@ti.com> wrote:
>> In some SoCs the dma request lines from the peripherals are
>> routed to the dma-controller through a crossbar. With this the
>> dma controller's available request lines are shared between the
>> peripherals.
>>
>> This adds support to register the crossbar router associated with
>> a dma-channel and let the dma-controller driver map/unmap
>> the peripheral dma crossbar line to dma-controller's request
>> line.
> This is not a unique concept and should follow some existing pattern.
> Perhaps something like interrupt-map. For the dmas property, the
> parent should be the crossbar and then the crossbar block has to
> translate that into the DMA controller request. All the DMA ctrlr
> request connections should be described in the crossbar node. In
> theory, you could have chained crossbars. This should be documented as
> part of the generic DMA binding.
  The idea here was to do the map/unmap crossbar<->dma-request
 from the  dma-controller at runtime just like any other resource, unlike
  interrupt-map fixed in DTS. I did not think about the chained
  crossbars case. I will add this here. And as you have suggested will
  make it work like irq_parse_and_map.

Regards,
 Sricharan
> There are also other similar IP like CoreSight CTI which are just
> signal routers. So there is probably some possibility of common code
> here.
>
> Rob
