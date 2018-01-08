From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Jan 2018 13:59:31 -0800
Subject: [RFC 5/5] pwm: pwm-omap-dmtimer: Add capture functionality
In-Reply-To: <20180108154336.GE4077@lenoch>
References: <20180108153926.GA3916@lenoch>
 <20180108154336.GE4077@lenoch>
Message-ID: <20180108215931.GV3875@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ladislav Michl <ladis@linux-mips.org> [180108 15:46]:
> Here it seems hardware can capture both edges, but I do not see a way
> how to tell it I want start from either low to high or high to low
> transition. Clues?

At least dm3730 TRM documents TCM bits [9:8] for TCLR, but you
probably know that already..

If you're having hard time getting things starting, maybe something
like this helps:

stop timer in TCLR register
configure timer in TCLR
write some value to TLDR, maybe 0?
set ST bit in TCLR to start

Regards,

Tony
