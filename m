From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Aug 2012 19:31:19 +0100
Subject: [PATCH 4/5] DRM: add i.MX IPUv3 base driver
In-Reply-To: <CAKGA1bkjJXK8bUxLxRYz_4Rj9YW0mJxBMyg7ir+Hfo+s6Lza0w@mail.gmail.com>
References: <1596192785.2810155.1345817566620.JavaMail.root@advansee.com>
 <806769921.2812305.1345819977325.JavaMail.root@advansee.com>
 <CAKGA1bkjJXK8bUxLxRYz_4Rj9YW0mJxBMyg7ir+Hfo+s6Lza0w@mail.gmail.com>
Message-ID: <20120824183119.GD18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2012 at 01:00:13PM -0500, Matt Sealey wrote:
> Nobody wants to write
> the same driver 5 times, and while the Silicon Image controllers are
> wonderfully generic with a common API ("TPI") and there could be a
> generic MFD solution with shim drivers on top for DRM, nobody else's
> are quite as nice.

I got here and immediately thought "oh god not more layers to DRM".
DRM does _not_ need any more bloody layers on top of the existing
layers.  It needs a library of helper functions to provide common
functionality so that folk don't have to write the same bloody stuff
time and time again.

A library of helpers, not a shim layer to convert it to something else.
