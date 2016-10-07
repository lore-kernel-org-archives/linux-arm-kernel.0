From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Fri, 7 Oct 2016 11:42:23 -0700
Subject: [PATCH 1/3] fpga manager: Add cyclonespi driver for Altera fpgas
In-Reply-To: <alpine.DEB.2.02.1610071248320.32627@linuxheads99>
References: <cover.1475783742.git.stillcompiling@gmail.com>
 <4b4432c04b4ea92a2af814e3d7866c33f2eb12ea.1475783742.git.stillcompiling@gmail.com>
 <CAAtXAHcWLpn3DFP6YLWqBxsMQ0O=HNNCmB+kHbHhyAHFHQUbwA@mail.gmail.com>
 <alpine.DEB.2.02.1610071248320.32627@linuxheads99>
Message-ID: <CAAtXAHfax5qve7bpxNoObZOZGZk1CoJkusMecMXyMc_w1JBbvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

On Fri, Oct 7, 2016 at 11:21 AM, atull <atull@opensource.altera.com> wrote:

> Moritz, Can you remind me what that issue was there (or point me to
> that email, I can't find it)?  I don't think I had a problem with that
> in your case.  In general I think if these drivers can take the
> bitstream that comes from the manufacturer's tools and stuff it into
> the FPGA, then we are accomplishing what we want.  So I am OK with
> this here.  The intent of the driver is to load a standard rbf, same
> as the other Altera FPGA drivers.

My first version of the zynq fpga manager had byte swapping in there
and detection of which format was used. Greg even (accidentially)
merged my initial code
which I then cleaned up in 4d10eaff5bfc69997a769f9c83b749f0a8c542fa
("fpga: zynq-fpga: Change fw format to handle bin instead of bit.") to
address the review
comments.

I do see your point about useability, and if this is something that
keeps coming up
we could pull that into the framework with a flag to SWAP or as part
of the image_information
struct.

Thoughts?

Cheers,

Moritz

[1] https://mail-archive.com/linux-kernel at vger.kernel.org/msg995245.html
