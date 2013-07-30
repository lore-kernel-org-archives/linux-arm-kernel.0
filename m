From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 30 Jul 2013 09:17:25 -0400
Subject: [RFC PATCH 0/2] impedance-matcher generic improvements
In-Reply-To: <51F76FE3.1080302@gmail.com>
References: <51F2A014.7000209@gmail.com>
 <cover.1375131816.git.jason@lakedaemon.net>
 <51F76FE3.1080302@gmail.com>
Message-ID: <20130730131725.GC5882@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 09:48:51AM +0200, Daniel Mack wrote:
> Hi Jason,
> 
> On 29.07.2013 23:23, Jason Cooper wrote:
> > Basic idea is to replace a device's stock kernel with this impedance-matcher.
> > Load the kernel and/or the devicetree blob to desired addresses.  Add
> > 'loadaddrs=0xXXXXXXXX,0xYYYYYYYY' to the kernel's command line.  Or, if you are
> > appending, 'loadaddrs=appended,0xYYYYYYYY'.  First address is the location of
> > the kernel, second is the location of the dtb.
> 
> Nice to see that idea implemented! For me though, changing any of the
> U-Boot variables is out of the question, and I need the matcher just the
> way I implemented it, including the LED blink pattern to let the user
> know if things go wrong.

Understandable.  After thinking about it a bit, I think I'm going to
rework this patch to allow appending both kernels and dtbs (as you had),
and abstract out the led blink so that your code would become a compile
time option.

> Hence, I won't change to your generic version on my boards, and so I
> think it might be best if you maintain your own tree for your approach.

hrmmm, I don't like forking on general principle.  Let me do the above
rework and see if that works for you, while adding the capabilities I
need.

When I'm done, you should just be able to do:

  $ make APPEND_KERNEL=input/zImage APPEND_DTBS=input/*.dtb uImage

And get the same result.

In the meantime, would you mind adding a license to your code?  If you
have no preference, I like GPLv2-only, but it's your code, so whatever
you like.

thx,

Jason.
