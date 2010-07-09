From: bosko.radivojevic@gmail.com (Bosko Radivojevic)
Date: Fri, 9 Jul 2010 16:33:23 +0200
Subject: Kernel crashing in tcp_sendmsg()
In-Reply-To: <20100709095329.GA22845@n2100.arm.linux.org.uk>
References: <AANLkTilD3M7d6VFiM9Z-iv7rVyjl7wrjdy9ECh00dfbI@mail.gmail.com>
	<20100709095329.GA22845@n2100.arm.linux.org.uk>
Message-ID: <AANLkTik2SG1kiGX_eYCGCLPYeGG8lJYCb1yGHBCGTsp4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 9, 2010 at 11:53 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> This only works if the code is using frame pointers. ?This should fix it.
> Please test and provide a Tested-by: line.

It works! Thanks. My colleague noticed a funny thing - non-stripped
thttpd/lighttpd binary is not crashing the kernel (without your patch,
of course). How is it related?

> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> ?arch/arm/lib/csumpartialcopyuser.S | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)

Tested-by: Bosko Radivojevic <bosko.radivojevic@gmail.com>
