From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Nov 2014 11:01:35 +0000
Subject: IRQ #0 broken on ARM
In-Reply-To: <87zjbk966i.fsf@approximate.cambridge.arm.com>
References: <CALT56yPs-SSssff1waj81CRQfER4ZKKR=B1jOXVL-aBChicSjg@mail.gmail.com>
 <87zjbk966i.fsf@approximate.cambridge.arm.com>
Message-ID: <20141121110135.GS4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 10:52:37AM +0000, Marc Zyngier wrote:
> On Fri, Nov 21 2014 at 10:31:05 am GMT, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:
> > Hello,
> >
> > After the commit a71b092a9c68685a270ebdde7b5986ba8787e575
> > (ARM: Convert handle_IRQ to use __handle_domain_irq) IRQ #0 is broken
> > on ARM. It is a valid IRQ and it is quite imporant (on sa1100 it's a GPIO0).
> 
> Well, this is a valid IRQ number if you're not using irq domains. I may
> be a bit pedantic here, but I thing this is an important distinction.

Linus has decreed it to not be a valid IRQ number, and that's basically
the end of the discussion.  Generic code, and drivers, will increasingly
decide that IRQ0 is not valid, and objecting to it has, and will continue
to elicit a response of "fix ARM".

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
