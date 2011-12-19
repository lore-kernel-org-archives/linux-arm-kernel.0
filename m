From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 19 Dec 2011 13:41:38 +0800
Subject: serial tty name
In-Reply-To: <CAB4PhKd6bURP1SgvEeJ5+=iGO5reC7jaBcd1JGz07HiN-pwXZA@mail.gmail.com>
References: <20111214144344.GA2090@richard-laptop>
 <4EE8C16F.8060501@calxeda.com>
 <20111219040804.GF4962@S2100-06.ap.freescale.net>
 <CAB4PhKd6bURP1SgvEeJ5+=iGO5reC7jaBcd1JGz07HiN-pwXZA@mail.gmail.com>
Message-ID: <20111219054138.GB15863@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 12:49:11PM +0800, Jason Liu wrote:
> 2011/12/19 Shawn Guo <shawn.guo@freescale.com>:
> > On Wed, Dec 14, 2011 at 09:31:59AM -0600, Rob Herring wrote:
> >> Richard,
> >>
> >> On 12/14/2011 08:43 AM, Richard Zhao wrote:
> >> > How to map different uart port to ttymxc0 (take imx for example)?
> >> >
> >> > In rootfs, it usually "getty ttymxc0" ?to get
> >> > serial console. And the rootfs may be shared by different boards.
> >> > Traditionaly way is to set right platform device ID.
> >> >
> >> > But with DT, UART2 always generate ttymxc1, UART3 for ttymxc2. You
> >> > always needs to modify the getty command when your change another board.
> >> >
> >> > Is there a way to fix it?
> >>
> >> That's what the aliases are for.
> >>
> > I understand it differently. ?The aliases was introduced to help
> > tty/serial driver identify the correct hardware port for given serial
> > node from device tree. ?(Ab)using it to fool 'console' setting may
> > eventually confuse users, saying they will think the uart port on his
> > board is UART0.
> 
> We absolutely need document this in detail to avoid confusion. Otherwise,
> the ARM DT support will also mess up in the end.
Yes, why not come a patch to doc it?

THanks
Richard
> 
> >
> > --
> > Regards,
> > Shawn
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
