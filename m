From: ladis@linux-mips.org (Ladislav Michl)
Date: Mon, 8 Jan 2018 22:57:18 +0100
Subject: [PATCH 0/5] Add capture functionality to OMAP pwm driver
In-Reply-To: <20180108215123.GU3875@atomide.com>
References: <20180108153926.GA3916@lenoch> <20180108215123.GU3875@atomide.com>
Message-ID: <20180108215718.GA17091@lenoch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 08, 2018 at 01:51:23PM -0800, Tony Lindgren wrote:
> * Ladislav Michl <ladis@linux-mips.org> [180108 15:42]:
> > Tony, I wanted to do something easy to understand as a base for
> > event capture interrupt, but either I do not understand hardware,
> > or it indeed cannot do pulse capture.
> 
> Hmm OK. Presumably it works as it's been around for a long time,
> I thought any edge trigger will just sample the current counter
> value and that's it..

Yes, indeed, _any_ edge will just sample the current counter value.
So what can hardware say about duty cycle of this signal?
  +-+        +-+
__| |________| |___

Depending time capture was started it will either trigger on first
falling or first rising edge.


	ladis
