From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Tue, 4 Mar 2014 19:39:13 +0000
Subject: [PATCH RFC 3/6] tty: Rename xilinx_uart -> cadence_uart
In-Reply-To: <1393953449-28551-4-git-send-email-soren.brinkmann@xilinx.com>
References: <1393953449-28551-1-git-send-email-soren.brinkmann@xilinx.com>
 <1393953449-28551-4-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <20140304193913.71c6f307@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  4 Mar 2014 09:17:26 -0800
Soren Brinkmann <soren.brinkmann@xilinx.com> wrote:

> The UART controller in Zynq is Cadence IP. Rename the driver
> accordingly.
> Furthermore, this affects the DT bindings:
>  - the compatibility string changes to 'cdns,uart-r1p8'
>  - clock inputs are named according to Cadence documentation - 'pclk'
>    and 'uart_clk'
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Acked-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>

NAK. This breaks existing userspace builds, it breaks modules, it messes
with the history and it breaks third prty DT files. It's an absolute
no-no.

Yes this happens - it's happened before and will happen again. She who
merges first wins. If Cadence had submitted a driver first they'd have
won 8)

The following aspects of the change set are IMHO acceptable

- Cleaning up all the code formatting
- Update the driver comments and header to explain the Cadence/Xilinx
  thing
- change "Xilinx PS UART Support" text to "Cadence (Xilinx PS) Support"
  or similar wording in Kconfig
- Adding the cadence devicetree compatibility strings and inputs *in
  addition* to the existing ones.
- Documentation for the new options

Alan
