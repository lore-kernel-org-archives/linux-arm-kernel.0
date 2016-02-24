From: dianders@chromium.org (Doug Anderson)
Date: Tue, 23 Feb 2016 16:22:31 -0800
Subject: [PATCH RESEND 1/2] usb: dwc2: Move register save and restore
 functions
In-Reply-To: <8cb0a09d08414388ad62f57320dc67bb2ee8d0f6.1456260533.git.johnyoun@synopsys.com>
References: <cover.1456260533.git.johnyoun@synopsys.com>
 <8cb0a09d08414388ad62f57320dc67bb2ee8d0f6.1456260533.git.johnyoun@synopsys.com>
Message-ID: <CAD=FV=Vr2q5Gz=VaS2k5u04zKqT-y48v2GmqJt_cmw3eib0UXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

John,

On Tue, Feb 23, 2016 at 1:33 PM, John Youn <johnyoun@synopsys.com> wrote:
> Move the register save and restore functions into the host and gadget
> specific files.
>
> Signed-off-by: John Youn <johnyoun@synopsys.com>
> ---
>  drivers/usb/dwc2/core.c   | 183 ----------------------------------------------
>  drivers/usb/dwc2/core.h   |  13 ++++
>  drivers/usb/dwc2/gadget.c | 102 ++++++++++++++++++++++++++
>  drivers/usb/dwc2/hcd.c    |  64 ++++++++++++++++
>  4 files changed, 179 insertions(+), 183 deletions(-)

I picked these back to my chromeos-3.14 kernel (with many many dwc2
backports) and I confirmed that I can still compile the kernel, boot
it, and use USB.  I also confirmed no warnings were introduced for me.
I'm only testing HOST, not gadget mode.

I also reviewed the code and agree that it looks good.  Thanks!

Tested-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
