From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 26 Feb 2014 23:06:06 -0500 (EST)
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <CAFEAcA9nq_V4VGG=j6FWFatJBnTuYrU9-9U9eGXcQz0zimrasQ@mail.gmail.com>
References: <20140226183454.GA14639@cbox> <5553754.0b4gMg5OS7@wuerfel>
 <CAL_Jsq+3jBdca9zVnxHG+7pxy2_316emsP=PB3WkTMQP0JYBYQ@mail.gmail.com>
 <CAFEAcA8u6u8Hh=qn8XE2Evc93_-pkZPSDSShm-eiSn-vcsYgKA@mail.gmail.com>
 <CAL_JsqJ+mXadxLHqFw6uXvM9=juC-emKT7G-d-_PLYbXNSX7Ew@mail.gmail.com>
 <CAFEAcA9nq_V4VGG=j6FWFatJBnTuYrU9-9U9eGXcQz0zimrasQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1402262259290.17677@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Feb 2014, Peter Maydell wrote:

> On 26 February 2014 23:08, Rob Herring <robherring2@gmail.com> wrote:
> > On Wed, Feb 26, 2014 at 4:54 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> >> What does the 8250 have to recommend it over just providing
> >> the PL011?
> >
> > As I mentioned, it will just work for anything that expects the serial
> > port to be ttyS0 as on x86 rather than ttyAMA0.
> 
> This doesn't seem very compelling to me. Either userspace
> should just be fixed or the kernel should implement a namespace
> for serial ports which doesn't randomly change just because the
> particular h/w driver doing the implementation is different.
> We shouldn't be papering over other peoples' problems in the VM
> spec IMHO.

Indeed.

This is already causing us trouble in other contexts.  Please have a 
look at this patch for a solution:

http://article.gmane.org/gmane.linux.kernel.samsung-soc/27222


Nicolas
