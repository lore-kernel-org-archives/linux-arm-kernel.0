From: robh@kernel.org (Rob Herring)
Date: Tue, 25 Sep 2018 15:17:20 -0500
Subject: [RFC PATCH v2 2/3] dt-bindings: fpga: Add bindings for ZynqMP
 fpga driver
In-Reply-To: <20180905072448.12488-3-nava.manne@xilinx.com>
References: <20180905072448.12488-1-nava.manne@xilinx.com>
 <20180905072448.12488-3-nava.manne@xilinx.com>
Message-ID: <20180925201720.GA32354@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2018 at 12:54:47PM +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP fpga driver
> bindings.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v2:
>                 -Moved pcap node as a child to firwmare
>                  node as suggested by Rob.

Sorry, but I wasn't thinking that you already have a node defined under 
/firmware. There's no reason to have this pcap node as a child of it. 
The existing node can instantiate multiple providers including this and 
reset provider.

>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt        | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
