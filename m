From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 28 Oct 2013 12:31:04 +0100
Subject: [PATCH 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
In-Reply-To: <CAKohpomedpd8XBPcdZX2vHy6b5=FMtbSVpNTG-eVLK1YPyPaMA@mail.gmail.com>
References: <1382533461-31021-1-git-send-email-andrew@lunn.ch>
 <CAKohpombg7mAmgxxvUg8kz1MaFwcycR1eL0UrgELY2WdGfrAag@mail.gmail.com>
 <20131023135116.GC31126@lunn.ch>
 <CAKohpokTgCz0c=PeaJHKiZEiYc0jPVq-vwkhP5pM0hh1-0QnLA@mail.gmail.com>
 <20131023143657.GA31536@lunn.ch>
 <CAKohpomedpd8XBPcdZX2vHy6b5=FMtbSVpNTG-eVLK1YPyPaMA@mail.gmail.com>
Message-ID: <20131028113104.GE27015@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 08:30:02PM +0530, Viresh Kumar wrote:
> On 23 October 2013 20:06, Andrew Lunn <andrew@lunn.ch> wrote:
> >> So, you have actually tested your code without interrupt handler?
> >
> > No.
> 
> It would be better if you atleast try this and confirm that this dummy
> handler is required.

Hi Viresh

I have tested this now. The dummy handler is required. Without it, it
seems like the WFI exits at the next timer tick, not immediately once
the cpufreq change has finished. I get poor numbers out of
cpufreq-bench without the handler.

	      Andrew
