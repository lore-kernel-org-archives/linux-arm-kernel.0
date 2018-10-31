From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Wed, 31 Oct 2018 11:38:00 -0700
Subject: [PATCH v2 09/10] irqchip: ti-sci-inta: Add support for Interrupt
 Aggregator driver
In-Reply-To: <da27ecc5-db32-cf3a-c194-962c44bc782f@arm.com>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <20181018154017.7112-10-lokeshvutla@ti.com>
 <b20127dc-be43-3b00-9960-663738df0069@arm.com>
 <9969f24c-cdb0-1f5c-d0f4-b1c1f587325c@ti.com>
 <86va5ssrfm.wl-marc.zyngier@arm.com>
 <2369ea50-55db-c97b-5b43-99d572c97dc9@ti.com>
 <da27ecc5-db32-cf3a-c194-962c44bc782f@arm.com>
Message-ID: <18df8960-9165-ba50-2c25-9f00d32198e8@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2018 11:21 AM, Marc Zyngier wrote:
> Hi Grygorii,
> 

[...]

> 
> Well, I'm convinced that we do not want a networking driver to be tied
> to an interrupt architecture, and that the two should be completely
> independent. But that's my own opinion. I can only see two solutions
> moving forward:
> 
> 1) You make the IA a real interrupt controller that exposes real
> interrupts (one per event), and write your networking driver
> independently of the underlying interrupt architecture.
> 
> 2) you make the IA an integral part of your network driver, not exposing
> anything outside of it, and limiting the interactions with the IR
> *through the standard IRQ API*. You duplicate this knowledge throughout
> the other client drivers.
> 
> I believe that (2) would be a massive design mistake as it locks the
> driver to a single of the HW (and potentially a single revision of the
> firmware) while (1) gives you the required level of flexibility by
> hiding the whole event "concept" at a single location.
> 
> Yes, (1) makes you rewrite your existing, out of tree drivers. Oh well...
> 
My preference is also not tie the network driver with IA. BTW, this is
very standard functionality with other network drivers too. And this
is handled using MSI-X.

So strong NO for 1) from me as well.

regards,
Santosh
