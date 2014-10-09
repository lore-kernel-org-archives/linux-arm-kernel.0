From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 9 Oct 2014 16:47:04 +0200
Subject: [PATCH RFT 0/8] Marvell PXA168 libphy handling and Berlin Ethernet
In-Reply-To: <54369EAC.5040301@gmail.com>
References: <1412858346-11334-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20141009163315.2a9e1806@free-electrons.com>
 <54369EAC.5040301@gmail.com>
Message-ID: <20141009164704.7286fc3f@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Thu, 09 Oct 2014 16:41:48 +0200, Sebastian Hesselbarth wrote:

> > Hum, in mvneta, we already disabled the automatic negotiation and use
> > libphy. What makes you think the current mvneta driver is wrong in this
> > respect?
> 
> I didn't check mvneta, but remember Ezequiel didn't clear all AN bits
> in the barebox driver (which is based on Linux mvneta). Just mentioned
> that I'll have a closer look at it.

Ah, ok.

> But I agree, regarding libphy support mvneta is probably the best
> already.

Well, I initially remember that the original driver coming from Marvell
was using the HW PHY stuff, and that I changed that because it would
not integrate well with the kernel libphy.

A drawback of this is that because the hardware has built-in PHY
polling which triggers a MAC interrupt when the PHY status changes, they
typically don't wire up the PHY interrupt. Therefore, since we're not
able to use the MAC interrupt for PHY event notifications, we rely on
software PHY polling, which means that link up / link down events take
a few seconds to be noticed by the kernel. Unfortunately, I don't think
the hardware allows to use the hardware PHY polling to get link changes
interrupt, but not let the hardware configure the PHY itself.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
