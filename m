From: morpheus.ibis@gmail.com (Pavel Herrmann)
Date: Wed, 29 Jun 2011 22:11:20 +0200
Subject: [PATCH v2] MAX1111: Fix Race condition causing NULL pointer
	exception
In-Reply-To: <1307131203-10845-1-git-send-email-morpheus.ibis@gmail.com>
References: <1307131203-10845-1-git-send-email-morpheus.ibis@gmail.com>
Message-ID: <6718666.udIax3Cf1F@bloomfield>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

anyone picked this yet?

On Friday 03 of June 2011 22:00:03 Pavel Herrmann wrote:
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
