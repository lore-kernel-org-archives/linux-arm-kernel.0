From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 23 Oct 2015 12:08:50 +0300
Subject: [PATCH 05/11] dt-binding: Add ngpios property to GPIO controller
 node
In-Reply-To: <CAL_JsqJP3SDwiQ95WLJo0isTTxsQkpXDNNBpfVJXqbK99qtC=g@mail.gmail.com>
References: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
 <56293052.80402@broadcom.com>
 <CAL_JsqJP3SDwiQ95WLJo0isTTxsQkpXDNNBpfVJXqbK99qtC=g@mail.gmail.com>
Message-ID: <3735458.2h6HCQhAOs@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 October 2015 18:41:05 Rob Herring wrote:
> On Thu, Oct 22, 2015 at 1:52 PM, Ray Jui wrote:
> > On 10/22/2015 11:43 AM, Rob Herring wrote:
> >> On Mon, Oct 19, 2015 at 12:43 AM, Pramod Kumar wrote:
> >>> Add ngpios property to the gpio controller's DT node so that controller
> >>> driver extracts total number of gpio lines present in controller
> >>> from DT and removes dependency on driver.
> >>> 
> >>> Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
> >>> Reviewed-by: Ray Jui <rjui@broadcom.com>
> >>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> >>> ---
> >>> 
> >>>  Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt | 5 +++
> >>>  1 file changed, 5 insertions(+)
> >>> 
> >>> diff --git
> >>> a/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt
> >>> b/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt
> >>> index f92b833..655a8d7 100644
> >>> --- a/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt
> >>> +++ b/Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt
> >>> 
> >>> @@ -10,6 +10,9 @@ Required properties:
> >>>       Define the base and range of the I/O address space that contains
> >>> the Cygnus
> >>>   GPIO/PINCONF controller registers
> >>> 
> >>> +- ngpios:
> >>> +    Total number of GPIOs the controller provides
> >> 
> >> This must be optional for compatibility and the driver needs to handle
> >> it not present.
> > 
> > You meant to be compatible with existing Cygnus devices, correct?
> > 
> > Just to clarify, here you suggest we still leave the existing hard coded
> > ngpios in the driver, in order to be compatible with all existing Cygnus
> > devices (while the Cygnus device tree changes to use ngpio is still being
> > merged and through different maintainer), and have all new iProc SoCs
> > switch to use ngpios from device tree, right?
> 
> Yes, an existing dtb should continue to work with a new kernel. You
> can add the DT property to the older devices too and then eventually
> remove the hard coded values some time in the future. That could be
> immediately (don't care about compatibility at all), a couple of
> kernel cycles, never... It all depends on users of the impacted
> platforms.

But shouldn't the property still be documented as required to ensure that new 
DTs always include it ?

-- 
Regards,

Laurent Pinchart
