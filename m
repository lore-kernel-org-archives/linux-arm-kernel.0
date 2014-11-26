From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 26 Nov 2014 10:14:48 -0500 (EST)
Subject: [PATCH 9/9] usb: {ohci,ehci}-platform: Use new OF big-endian
 helper function
In-Reply-To: <1416962994-27095-10-git-send-email-cernekee@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1411261013340.1322-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Nov 2014, Kevin Cernekee wrote:

> This handles the existing "big-endian" case, and in addition, it also does
> the right thing when "native-endian" is specified.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-ehci.txt | 2 ++
>  Documentation/devicetree/bindings/usb/usb-ohci.txt | 2 ++
>  drivers/usb/host/ehci-platform.c                   | 2 +-
>  drivers/usb/host/ohci-platform.c                   | 2 +-
>  4 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> index 43c1a4e..9505c31 100644
> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> @@ -12,6 +12,8 @@ Optional properties:
>   - big-endian-regs : boolean, set this for hcds with big-endian registers
>   - big-endian-desc : boolean, set this for hcds with big-endian descriptors
>   - big-endian : boolean, for hcds with big-endian-regs + big-endian-desc
> + - native-endian : boolean, enables big-endian-regs + big-endian-desc
> +   iff the kernel was compiled for big endian

Is this really a property of the hardware?  It appears to depend on the 
kernel configuration.  As such, is it appropriate for DT?

Alan Stern
