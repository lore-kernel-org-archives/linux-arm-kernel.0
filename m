From: Rob Herring <robh@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: xhci: add support for performing fake doorbell
Message-ID: <20161008223240.GA13162@rob-hp-laptop>
References: <20161001215817.25384-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161001215817.25384-1-zajec5@gmail.com>
Date: Sat, 8 Oct 2016 17:32:46 -0500
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 01, 2016 at 11:58:10PM +0200, Rafa?? Mi??ecki wrote:
> From: Rafa?? Mi??ecki <rafal@milecki.pl>
> 
> Broadcom's Northstar XHCI controllers seem to need a special start
> procedure to work correctly. There isn't any official documentation on
> this, the problem is that controller doesn't detect any connected
> devices with default setup. Moreover connecting USB device to controller
> that doesn't run properly can cause SoC's watchdog issues.
> 
> A workaround that was successfully tested on multiple devices is to
> perform a fake doorbell. This patch adds code for doing that and a DT
> binding enabling it.
> 
> Signed-off-by: Rafa?? Mi??ecki <rafal@milecki.pl>
> ---
>  Documentation/devicetree/bindings/usb/usb-xhci.txt |  2 +
>  drivers/usb/host/xhci-plat.c                       |  6 +++
>  drivers/usb/host/xhci.c                            | 63 ++++++++++++++++++++--
>  drivers/usb/host/xhci.h                            |  1 +
>  4 files changed, 69 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> index 966885c..ce01b7f 100644
> --- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> @@ -26,6 +26,8 @@ Required properties:
>  Optional properties:
>    - clocks: reference to a clock
>    - usb3-lpm-capable: determines if platform is USB3 LPM capable
> +  - usb3-fake-doorbell: determines if controller requires a fake doorbell when
> +			starting it

You should use Northstar XHCI compatible string to enable this. Then the 
DT doesn't need updating.

Rob
