From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 21 Jan 2013 20:26:38 -0300
Subject: [PATCH 1/6] arm: mvebu: Add support for local interrupt
In-Reply-To: <50FDBC0E.1030706@free-electrons.com>
References: <1358790842-2986-1-git-send-email-gregory.clement@free-electrons.com>
 <1358790842-2986-2-git-send-email-gregory.clement@free-electrons.com>
 <20130121191744.0a04b941@skate>
 <50FDBC0E.1030706@free-electrons.com>
Message-ID: <20130121232637.GA3412@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas and Gregory,

On Mon, Jan 21, 2013 at 11:07:10PM +0100, Gregory CLEMENT wrote:
> On 01/21/2013 07:17 PM, Thomas Petazzoni wrote:
> >> +		irq_set_percpu_devid(virq);
> >> +		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
> >> +					handle_percpu_devid_irq);
> >> +
> >> +	} else {
> >> +		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
> >> +					handle_level_irq);
> >> +	}
> > 
> > Braces useless since there is only one statement in the else.
> > 

IMHO, this is an exception to the rule.
Since the first block is more than one line,
we usually put braces on the single line block too.
(or at least that's what Documentation/CodingStyle says).

Regards,

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
