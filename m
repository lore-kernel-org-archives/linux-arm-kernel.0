From: cjb@laptop.org (Chris Ball)
Date: Tue, 21 Jun 2011 12:23:30 -0400
Subject: [PATCH 0/3] Improve MMC error handling (3rd rev)
In-Reply-To: <20110620190945.GK26089@n2100.arm.linux.org.uk> (Russell King's
	message of "Mon, 20 Jun 2011 20:09:45 +0100")
References: <20110620190945.GK26089@n2100.arm.linux.org.uk>
Message-ID: <m2y60vrw59.fsf@bob.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Jun 20 2011, Russell King - ARM Linux wrote:
> This is the third revision of my improvements to the MMC block
> device error handling, which makes error handling more robust
> and permits MMC/SD to continue working in the presence of
> not-quite-perfect setups.
>
> Without this, my Versatile Express tends to fail to mount its rootfs
> on SD.  With this, it can successfully read and write data from the
> card in the presence of FIFO overruns and underruns, and also sensibly
> recover from command channel errors.
>
> There is more to come, but this is the "safer" bits of the improvements.
>
>  drivers/mmc/card/block.c |  279 ++++++++++++++++++++++++++++++++++-----------
>  include/linux/mmc/mmc.h  |   10 ++
>  2 files changed, 221 insertions(+), 68 deletions(-)

Thanks, pushed to mmc-next for 3.1.

(I'll do some more testing myself and let you know if I find anything
unexpected.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
