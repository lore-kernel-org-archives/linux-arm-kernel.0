From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 7 Jun 2011 23:56:21 -0700
Subject: [PATCH v2 1/3] dmaengine: add new dma API for max_segment_number
In-Reply-To: <20110608142121T.fujita.tomonori@lab.ntt.co.jp>
References: <20110606094751.GC10508@n2100.arm.linux.org.uk>
	<20110606191041U.fujita.tomonori@lab.ntt.co.jp>
	<BANLkTin7mqqTsosPHbztaPfL7s_TUGT1qg@mail.gmail.com>
	<20110608142121T.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <BANLkTi=FcNncT_6HpvB_6OnQ94f0_sz7Gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 7, 2011 at 10:23 PM, FUJITA Tomonori
<fujita.tomonori@lab.ntt.co.jp> wrote:
> On Mon, 6 Jun 2011 11:48:56 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
>> dmaengine expands the class of dma providers to include standalone dma
>> agents on a host bus (or elsewhere) in addition to the traditional bus
>> mastering host-bus-adapters that the existing api understands. ?So in
>> the case of slave dma the dma capabilities of the block-device are
>> irrelevant because another agent will do the transfer on behalf of the
>> block-device driver. ?So the value should be whatever the dma device
>> driver says it is.
>
> The dma parameter restriction could be due to software (HBA drivers,
> or subsystem). The value should be whatever the dma device driver says
> it is in such case?

I'm assuming that the dma driver is taking responsibility for setting
this correctly.  How would this work otherwise... HBA driver or
subsystem queries the dmaengine device and then sets this parameter on
its behalf?  In other words dmanengine *is* the subsystem, if I am
understanding your definition.
