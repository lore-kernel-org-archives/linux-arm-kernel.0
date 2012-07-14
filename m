From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 14 Jul 2012 11:42:58 -0600 (MDT)
Subject: [RFC RESEND 1/4] arm/dts: OMAP: Add timer nodes
In-Reply-To: <50017BB1.8010702@gmail.com>
References: <1342218413-30116-1-git-send-email-jon-hunter@ti.com>
 <1342218413-30116-2-git-send-email-jon-hunter@ti.com>
 <5000D647.4090200@gmail.com>
 <alpine.DEB.2.00.1207140048210.3876@utopia.booyaka.com>
 <50017BB1.8010702@gmail.com>
Message-ID: <alpine.DEB.2.00.1207141138160.3876@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

thanks for your response.

On Sat, 14 Jul 2012, Rob Herring wrote:

> On 07/14/2012 01:56 AM, Paul Walmsley wrote:
> > On Fri, 13 Jul 2012, Rob Herring wrote:
> > 
> >> I'm not sure this is really a good use of aliases. UARTs use aliases 
> >> because it is important that the UART number to tty number is known and 
> >> fixed. IIUC, as an example you are picking timer1 because it has 
> >> properties X, Y and Z. If so, then you should describe those h/w 
> >> properties within the timer nodes so you can pick which timer to use 
> >> based on it's h/w properties.
> > 
> > Some GPTIMER blocks have input and output signals that can be routed to 
> > external package balls.  So it's possible that some application may need 
> > to request a specific timer ID, since that timer would be connected to a 
> > specific off-chip device.
> 
> Yes, I understand that. So you

(just to clarify, these are Jon's patches)

> should be describing which ones have i/o and what they are connected to. 

Right, agreed.

> The PWM binding is probably a starting point.

My point, perhaps unclear, was about the aliases.  Do you have a different 
approach in mind that applications should use, other than requesting a 
specific timer by ID?


- Paul
