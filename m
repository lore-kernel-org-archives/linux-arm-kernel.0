From: andrew@aj.id.au (Andrew Jeffery)
Date: Fri, 20 Jul 2018 09:37:56 +0930
Subject: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
In-Reply-To: <9787b471abc49c0b3db60e3471473a7a5b45ade7.camel@kernel.crashing.org>
References: <20180711053122.30773-1-andrew@aj.id.au>
 <20180711053122.30773-2-andrew@aj.id.au>
 <20180711200450.GB17291@rob-hp-laptop>
 <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
 <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
 <b6ced4cad4d7ff78330181b2c893855c23103953.camel@kernel.crashing.org>
 <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
 <CAL_JsqLZo-=7UkuvvUFYdCR4asBBiWyC=Q1ryH=-HLU6vzf9tA@mail.gmail.com>
 <ece91112ecfdc7218184c4c4519e455cf9397e11.camel@kernel.crashing.org>
 <CAL_JsqL_bMXLAA0091-g8PmhXR5g5Pf2y2=ey7Ss5ofHm46sWw@mail.gmail.com>
 <c69d0e7c3a95d83da87b566a62619462671a233b.camel@kernel.crashing.org>
 <1531967302.2140539.1445583600.0F5ED287@webmail.messagingengine.com>
 <9787b471abc49c0b3db60e3471473a7a5b45ade7.camel@kernel.crashing.org>
Message-ID: <1532045276.1219110.1446722072.546C1F9D@webmail.messagingengine.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> Andrew, can you start with a list that shows what you expect us to need
> on our systems ?
> 

Okay, our Witherspoon and Romulus platforms containing the ASPEED AST2500 currently need the following tuneables exposed:

>From the SCU:
- Debug UART enable
- VGA DAC mux
- VGA scratch registers 0-7
- LPC SuperIO decode enable
- VGA MMIO decode enable

>From the LPC controller:
- iLPC2AHB enable
- SuperIO scratch registers 0x20-0x2f

(The LPC controller is just as much of a collection of random bits as the SCU)

Lastly, our Palmetto platform uses an AST2400 which has fewer features compared to the AST2500. Its tuneable list is the same as the above with the exception of "Debug UART enable".

Tuneables that we may need to expose in the future include:

>From the SCU:
- PCI VID/DID for the BMC PCIe device
- VGA device enable (may need to be disabled if the platform contains a discrete graphics processor)

>From the LPC controller:
- UART mux

Alexander, Eugene, can you chime in with your platforms' needs?

Cheers,

Andrew
