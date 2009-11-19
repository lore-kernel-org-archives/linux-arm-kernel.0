From: greg@kroah.com (Greg KH)
Date: Thu, 19 Nov 2009 14:56:02 -0800
Subject: [PATCH 2/3] staging/dream: add missing include files
In-Reply-To: <20091101222717.GB20740@elf.ucw.cz>
References: <20091101222717.GB20740@elf.ucw.cz>
Message-ID: <20091119225602.GC18710@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 01, 2009 at 11:27:17PM +0100, Pavel Machek wrote:
> Add missing files/includes neccessary for Dream compilation.
>     
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

This patch includes a file that is not in the drivers/staging/
directory, and it does this Kconfig mess:

> +config GENERIC_GPIO
> +	bool
> +	default y

Which breaks the i386 build.  Don't force on a general config option
like this, that's not nice at all :(

So I'll not apply this one, and the 3/3 patch.

thanks,

greg k-h
