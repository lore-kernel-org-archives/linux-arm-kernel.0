From: swami.iyer@ti.com (Subbrathnam, Swaminathan)
Date: Wed, 30 Dec 2009 09:16:08 +0530
Subject: [PATCH RFC 1/2] MUSB: CPPI 4.1 DMA driver (take 4)
In-Reply-To: <20091229125403.GD17147@nokia.com>
References: <19F8576C6E063C45BE387C64729E7394044A2779F5@dbde02.ent.ti.com>
	<19F8576C6E063C45BE387C64729E7394044A2779F6@dbde02.ent.ti.com>,
	<20091229125403.GD17147@nokia.com>
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FFF44876@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe,

We have been on this front months together now!!! Ideally the place holder would be a place independant of platforms as this piece of code is more of a platform independant library relating to TI CPPI DMA operations.  This would be used during initialization and confiuration  of CPPI4.x based peripherals.  Though today USB is the only peripheral that falls in that catagory ideally other like TI EMAC could fall in the same space.

Having said that I also see that there seems to be no roadmap/plan for any other peripheral other than USB to use CPPI4.x in the near future.  TI EMAC seems to continue use CPPI3.x.

This was the reason I had recommended earlier to locate this generic CPPI 4.x functionality within MUSB.  This definitely helps in having a functional peripheral in the near (and most probably long) term.

I think it is prudent to locate this functionality in the musb directory for now.  In future if need arises we can relook at this later (I am sure this in all probabilities would not be required).

In either way I would really appreiciate if we can come to a conclusion at the earliest.  Appreciate everybody's feedback and direction.

regards
swami

________________________________________
From: Felipe Balbi [felipe.balbi at nokia.com]
Sent: Tuesday, December 29, 2009 6:24 PM
To: Gupta, Ajay Kumar
Cc: linux-usb at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Sergei Shtylyov; Balbi Felipe (Nokia-D/Helsinki); Subbrathnam, Swaminathan
Subject: Re: [PATCH RFC 1/2] MUSB: CPPI 4.1 DMA driver (take 4)

Hi,

On Tue, Dec 29, 2009 at 09:43:49AM +0100, ext Gupta, Ajay Kumar wrote:
>As this discussion is taking time which is affecting the further
>development and bug fixes on CPPI4.1.
>
>So can we move CPPI4.1 files to drivers/usb/musb for time being and submit
>a replacement patch whenever we all agree on the location of CPPI4.1
>related files.

problem is that once it's applied, no-one seems to care anymore. And
it'll be there for good. Better is to decide what really is the correct
place for this otherwise it'll be like tusb6010_omap.c

--
balbi
