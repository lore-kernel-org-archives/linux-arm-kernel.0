From: greg@kroah.com (Greg KH)
Date: Sat, 4 Jun 2011 07:32:03 +0900
Subject: [stable] [PATCH v2] MAX1111: Fix Race condition causing NULL
	pointer exception
In-Reply-To: <1307131203-10845-1-git-send-email-morpheus.ibis@gmail.com>
References: <1307131203-10845-1-git-send-email-morpheus.ibis@gmail.com>
Message-ID: <20110603223203.GA9161@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2011 at 10:00:03PM +0200, Pavel Herrmann wrote:
> spi_sync call uses its spi_message parameter to keep completion information,
> having this structure static is not thread-safe, potentially causing one
> thread having pointers to memory on or above other threads stack. use mutex
> to prevent multiple access
> 
> Signed-off-by: Pavel Herrmann <morpheus.ibis@gmail.com>
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Marek Vasut <marek.vasut@gmail.com>
> Acked-by: Cyril Hrubis <metan@ucw.cz>
> 
> ---
>  drivers/hwmon/max1111.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
>


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
