From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 12 Jun 2013 20:23:45 +0200
Subject: [PATCH v2 3/3] arm: dt: zynq: Add support for the zed platform
In-Reply-To: <1371055268-32337-4-git-send-email-soren.brinkmann@xilinx.com>
References: <1371055268-32337-1-git-send-email-soren.brinkmann@xilinx.com>
 <1371055268-32337-4-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <20130612182345.GA1656@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 09:41:08AM -0700, Soren Brinkmann wrote:
> Add a DT fragment for the Zed Zynq platform and a corresponding
> target to the Makefile
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> I used the 'xlnx,...' compat strings since it seems this is what is
> used in the Xilinx and Digilent vendor trees.
> 
> +/include/ "zynq-7000.dtsi"
> +
> +/ {
> +	model = "Zynq Zed Development Board";
> +	compatible = "xlnx,zynq-zed", "xlnx,zynq-7000";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0 0x20000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyPS1,115200 earlyprintk";
> +	};
> +
> +};

Hi!

This looks a little bit to basic. No?! Not even an UART?
The compatible should include digilent or avnet. Digilent only sells to academic
customers, Avnet doesn't.
I personally don't care what they do out of tree.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
