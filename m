From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Jan 2010 13:48:57 +0000
Subject: Use of data types
In-Reply-To: <20100118134120.GB31345@pengutronix.de>
References: <2703439e1001180443t761947e0idc144ced64ca3a4f@mail.gmail.com>
	<20100118134120.GB31345@pengutronix.de>
Message-ID: <20100118134857.GB2695@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2010 at 02:41:20PM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Mon, Jan 18, 2010 at 09:43:12PM +0900, Khushhua Mogambo wrote:
> > Hi
> >   I starting to port Linux kernel to my companies new ARM based
> > SoC and development board.
> > 
> > Some of the regs is 16bits wide and some is 32bits width. I ask if
> > my using u16 and u32 in place of 'unsigned short' and 'unsigned int'
> > in the whole porting would be acceptable or not?
> > 
> > In different wording, using only u16 and u32 always is considered good
> > quality or bad?
> I prefer using u32 over int.  Still more if your register space isn't uniform.

u32 should be used for things that you want to be an unsigned 32-bit and
nothing else.  int and unsigned int for integers where the size doesn't
matter that much.

So, if you want a data type that is unsigned 32-bit, use u32.  If not,
use unsigned int or similar.
