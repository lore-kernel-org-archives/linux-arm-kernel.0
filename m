From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Nov 2010 09:10:04 +0000
Subject: [Question] Local Timer based on SPI
In-Reply-To: <000001cb8d0d$dbacd760$93068620$%kim@samsung.com>
References: <000001cb8d0d$dbacd760$93068620$%kim@samsung.com>
Message-ID: <20101126091004.GD9310@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 26, 2010 at 11:01:31AM +0900, Kukjin Kim wrote:
> Current ARM Local Timer code is based on PPI using.
> If want to use SPI on local timer, what approach is right or better?

SPI interrupts only go to one core at a time.  You can't have local
timer support off a targetted interrupt.
