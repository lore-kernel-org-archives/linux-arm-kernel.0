From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 21 May 2010 16:17:28 -0500
Subject: Known issues with amba-pl010.c driver?
In-Reply-To: <20100521193150.GF11042@n2100.arm.linux.org.uk>
References: <0D753D10438DA54287A00B0270842697636F1BC928@AUSP01VMBX24.collaborationhost.net>
	<20100521193150.GF11042@n2100.arm.linux.org.uk>
Message-ID: <0D753D10438DA54287A00B0270842697636F32378A@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, May 21, 2010 12:32 PM, Russell King wrote:
> On Tue, May 18, 2010 at 07:22:12PM -0500, H Hartley Sweeten wrote:
>> Are there any known issues with the amba-pl010.c driver?
>
> I'm not aware of any problems with it.  It was used on ARM's early
> Integrator platforms, but not their later ones having been superseded
> by the PL011 primecell.
>
>> I see a similar pause when using one of the other serial ports as a
>> console.  When doing something that spews a lot of data to the port
>> the delays are very noticeable.  For instance the command:
>
> How long are these delays?

Hard to tell, but it is very noticeable just doing something like 'dmesg'
on the console.

I first get some random number of characters, anywhere from none to something
less than a full line (80 characters).  Then there is a noticeable pause.  This
is followed by some random length block of data, another pause, then the
remainder of the output.

I'm not sure if it will help but the 'dmesg' output on my system is 7,472
bytes.

It might have nothing to do with the pl010 driver itself.  I just don't know
where to start digging in the driver stack to figure out where the pauses are
coming from.

Regards,
Hartley
