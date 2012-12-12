From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 12 Dec 2012 17:41:16 +0900
Subject: [PATCH v4] backlight: corgi_lcd: Use gpio_set_value_cansleep() to
 avoid WARN_ON
In-Reply-To: <000801cdd6ae$da095270$8e1bf750$%han@samsung.com>
References: <000201cdd283$baf50160$30df0420$%han@samsung.com>
 <20121205093027.GK14363@n2100.arm.linux.org.uk>
 <CAHod+Gdb_LEnhx5cz9j=q9PyS4L=Yjxs303dHon9i-tgjJRtDA@mail.gmail.com>
 <20121205192141.GQ14363@n2100.arm.linux.org.uk>
 <000801cdd6ae$da095270$8e1bf750$%han@samsung.com>
Message-ID: <000001cdd844$7326c9b0$59745d10$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, December 10, 2012 5:18 PM, Jingoo Han wrote
> On Thursday, December 06, 2012 4:22 AM, Russell King - ARM Linux wrote
> > On Wed, Dec 05, 2012 at 07:20:00PM +0100, Marko Kati? wrote:
> > > On Wed, Dec 5, 2012 at 10:30 AM, Russell King - ARM Linux
> > > <linux@arm.linux.org.uk> wrote:
> > > > On Wed, Dec 05, 2012 at 09:59:07AM +0900, Jingoo Han wrote:
...
> > Eric shares my opinion of the _cansleep() mess, but unfortunately it's
> > what we have and no one's come up with any better solutions to it.  (I
> > argued from the outset that the gpio_xxx_cansleep() should've been
> > gpio_xxx() and the non-cansleep() version should be called
> > gpio_xxx_atomic() so that by default people use the version which _can_
> > sleep, but have to think about it when they want to manipulate GPIOs in
> > non-task contexts.)
> 
> Hi Russell,
> 
> Thank you for your explanation. It is very helpful for getting hold of.
> I have been confused by the current function name such as gpio_xxx_cansleep().
> As you mentioned, gpio_xxx_cansleep()and gpio_xxx_atomic() would be better.

Oh, sorry. There is a mistake.

It should be as below:
'gpio_xxx()and gpio_xxx_atomic() would be better'.


Best regards,
Jingoo Han
