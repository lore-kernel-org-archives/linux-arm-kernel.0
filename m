From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Aug 2012 18:04:28 +0100
Subject: [PATCH 2/2] ARM i.MX5: Hard reset the IPU during startup
In-Reply-To: <CAKGA1bkA3eEHn4sM277mzcRT5OUyipW18-k-X0nK+T9rrotJNw@mail.gmail.com>
References: <1338888630-25930-1-git-send-email-s.hauer@pengutronix.de>
 <1338888630-25930-3-git-send-email-s.hauer@pengutronix.de>
 <20429.57208.228315.164637@ipc1.ka-ro>
 <20120605110834.GQ30400@pengutronix.de>
 <CAKGA1bkA3eEHn4sM277mzcRT5OUyipW18-k-X0nK+T9rrotJNw@mail.gmail.com>
Message-ID: <20120807170428.GI18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 04:31:50PM -0500, Matt Sealey wrote:
> There used to be an ATAG for finding the linear framebuffer and it's
> details but it got removed. This
> was from a long forgotten time when you could initialize a VGA
> graphics card and never care that
> it had an interrupt or not, since it never got used for your average,
> simple linear framebuffer operations.

No ATAG definitions have been removed from the kernel.  The one you
are referring to is:

#define ATAG_VIDEOLFB   0x54410008

and the associated struct tag_videolfb, which is still in the kernel
today.  What isn't there is the implementation which reads this data,
because only a few boards supported it, and they passed over some data
from this to their FB drivers.

So, when the boards were updated such that this became unnecessary,
unsurprisingly the users disappeared (because they were all in platform
code.)

We have never had a generic "framebuffer" driver which has used this
ATAG.  Or if one was created, it never came anywhere near mainline.

Either way, the situation is not as you describe above.
