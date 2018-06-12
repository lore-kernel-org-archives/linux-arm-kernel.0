From: robh@kernel.org (Rob Herring)
Date: Tue, 12 Jun 2018 15:11:28 -0600
Subject: [RFC PATCH 5/8] dt-bindings: mailbox: ti,message-manager: Add
 support for secure proxy threads
In-Reply-To: <20180605061629.4759-6-nm@ti.com>
References: <20180605061629.4759-1-nm@ti.com> <20180605061629.4759-6-nm@ti.com>
Message-ID: <20180612211128.GA22038@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2018 at 01:16:26AM -0500, Nishanth Menon wrote:
> Secure Proxy is another communication scheme in Texas Instrument's
> devices intended to provide an unique communication path from various
> processors in the System on Chip(SoC) to a central System Controller.
> 
> Secure proxy is, in effect, an evolution of current generation Message
> Manager hardware block found in K2G devices. However the following
> changes have taken place:
> 
> Secure Proxy instance exposes "threads" or "proxies" which is
> primary representation of "a" communication channel. Each thread is
> preconfigured by System controller configuration based on SoC usage
> requirements. Secure proxy by itself represents a single "queue" of
> communication but allows the proxies to be independently operated.
> 
> Each Secure proxy thread can uniquely have their own error and threshold
> interrupts allowing for more fine control of IRQ handling.
> 
> Provide an hardware description of the same for device tree
> representation.
> 
> See AM65x Technical Reference Manual (SPRUID7, April 2018)
> for further details: http://www.ti.com/lit/pdf/spruid7
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  .../bindings/mailbox/ti,message-manager.txt        | 58 +++++++++++++++++++---
>  1 file changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt b/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
> index ebf0e3710cee..de796e90cac6 100644
> --- a/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
> +++ b/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
> @@ -7,22 +7,40 @@ manager is broken up into queues in different address regions that are called
>  "proxies" - each instance is unidirectional and is instantiated at SoC
>  integration level to indicate receive or transmit path.
>  
> +This can also be used to describe Texas Instrument's Secure Proxy
> +controller that allows for individually configurable "threads" or
> +"proxies" which allow for independent communication scheme.

There seems to be very little re-use here. I think I would make this 
its own doc.

Rob
