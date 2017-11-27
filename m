From: edubezval@gmail.com (Eduardo Valentin)
Date: Mon, 27 Nov 2017 11:21:38 -0800
Subject: [PATCH 2/3] thermal: armada: add support for AP806
In-Reply-To: <20171123163510.q34rndd4b4p4da4s@tarshish>
References: <7102bb32704ac9f70ef3ae61682d50de8af61b57.1511361725.git.baruch@tkos.co.il>
 <320800cce532d6ae1927b36f82b007f04c740a15.1511361725.git.baruch@tkos.co.il>
 <20171123152416.GR31757@n2100.armlinux.org.uk>
 <20171123163510.q34rndd4b4p4da4s@tarshish>
Message-ID: <20171127192136.GA3835@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 23, 2017 at 06:35:10PM +0200, Baruch Siach wrote:
> Hi Russell,
> 
> On Thu, Nov 23, 2017 at 03:24:17PM +0000, Russell King - ARM Linux wrote:
> > On Wed, Nov 22, 2017 at 04:42:04PM +0200, Baruch Siach wrote:
> > > The AP806 component is integrated in the Armada 8k and 7k lines of processors.

<cut>

> > > +	mdelay(10);
> > 
> > Do you really need to make the CPU busy-wait for 10ms here?  This
> > looks like it's called from a schedulable context, so won't msleep()
> > do?

Yes, that is schedulable context.

> 
> msleep() should be fine as well. I just mindlessly copied this code from the 
> vendor kernel. I'll change that in the next iteration.
> 

Yes please, send next version without CPU spinning delays.


> Thanks for reviewing,
> baruch
> 
> -- 
>      http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
