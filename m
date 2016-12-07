From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 7 Dec 2016 10:02:19 +0100
Subject: [PATCH 08/16] drivers/fsi: Add crc4 helpers
In-Reply-To: <1481076574-54711-2-git-send-email-christopher.lee.bostic@gmail.com>
References: <1481076574-54711-1-git-send-email-christopher.lee.bostic@gmail.com>
 <1481076574-54711-2-git-send-email-christopher.lee.bostic@gmail.com>
Message-ID: <20161207090219.GA14742@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 08:09:31PM -0600, Chris Bostic wrote:
> From: Jeremy Kerr <jk@ozlabs.org>
> 
> Add some helpers for the crc checks for the slave configuration table.
> This works 4-bits-at-a-time, using a simple table approach.
> 
> We will need this in the FSI core code, as well as any master
> implementations that need to calculate CRCs in software.
> 
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> Signed-off-by: Chris Bostic <cbostic@us.ibm.com>
> ---
>  drivers/fsi/fsi-core.c   | 21 +++++++++++++++++++++
>  drivers/fsi/fsi-master.h | 21 +++++++++++++++++++++
>  2 files changed, 42 insertions(+)

Why not just create lib/crc4.c with these functions, like the other crc
functions in the kernel?  Don't bury these in some random driver
subsystem please.

thanks,

greg k-h
