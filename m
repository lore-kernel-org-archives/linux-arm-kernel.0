From: nicolae.rosia@gmail.com (Nicolae Rosia)
Date: Sun, 28 Jun 2015 18:06:52 +0300
Subject: [PATCH v7] dma: Add Xilinx AXI Direct Memory Access Engine driver
 support
In-Reply-To: <20150628144529.GZ19530@localhost>
References: <1433831736-18253-1-git-send-email-appanad@xilinx.com>
 <20150622104932.GC19530@localhost>
 <C246CAC1457055469EF09E3A7AC4E11A49A91915@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20150627144054.GW19530@localhost>
 <CAH=tA9F3=oqWi66EpkG-ecWHuVbOua+ceeiQD03WjiA=QdgA-g@mail.gmail.com>
 <20150628144529.GZ19530@localhost>
Message-ID: <CAH=tA9EZ=C8rgB9Gb5i=SpnDJCX3R64a1w9esM0N4bTU+V=JAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,
On Sun, Jun 28, 2015 at 5:45 PM, Vinod Koul <vinod.koul@intel.com> wrote:
[...]
>> > I asked how the device address in configured. For both MM2S S2MM you are
>> > using sg for memory address, where are you getting device adress, are you
>> > assuming/hardcoding or getting somehow, if so how?
>> As the name says, one end is memory (MM) and the other end is an AXI4
>> Stream Bus (S) which has no concept of memory address.
>> So yes, it is hardcoded at design time.
> So where does the data go at the end of stream bus, who configures that?
> Shouldnt all this be at least documented...

You make the connection at design time. In Zynq7000 case, there's a
dual core Cortex A9 coupled with an FPGA.
While designing the FPGA part, you instantiate an Xilinx AXI DMA, on
one side you connect it to an AXI4 Lite bus (which is memory mapped)
and on the other side you connect your custom peripheral using an AXI4
Stream bus which has no concept of addresses.
Here's a picture which depicts all of this [0].
Does this clear things up?

[0] http://www.fpgadeveloper.com/wp-content/uploads/2014/08/fpga_developer_20140806_130447.png
