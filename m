From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Wed, 8 Jun 2011 14:23:27 +0900
Subject: [PATCH v2 1/3] dmaengine: add new dma API for max_segment_number
In-Reply-To: <BANLkTin7mqqTsosPHbztaPfL7s_TUGT1qg@mail.gmail.com>
References: <20110606094751.GC10508@n2100.arm.linux.org.uk>
	<20110606191041U.fujita.tomonori@lab.ntt.co.jp>
	<BANLkTin7mqqTsosPHbztaPfL7s_TUGT1qg@mail.gmail.com>
Message-ID: <20110608142121T.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Jun 2011 11:48:56 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> dmaengine expands the class of dma providers to include standalone dma
> agents on a host bus (or elsewhere) in addition to the traditional bus
> mastering host-bus-adapters that the existing api understands.  So in
> the case of slave dma the dma capabilities of the block-device are
> irrelevant because another agent will do the transfer on behalf of the
> block-device driver.  So the value should be whatever the dma device
> driver says it is.

The dma parameter restriction could be due to software (HBA drivers,
or subsystem). The value should be whatever the dma device driver says
it is in such case?
