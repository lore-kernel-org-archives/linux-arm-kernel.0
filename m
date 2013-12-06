From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 5 Dec 2013 16:02:53 -0800
Subject: [PATCH] serial: rewrite pxa2xx-uart to use 8250_core
In-Reply-To: <1386286149-2855-1-git-send-email-ynvich@gmail.com>
References: <20131205043544.GA28580@kroah.com>
 <1386286149-2855-1-git-send-email-ynvich@gmail.com>
Message-ID: <20131206000253.GC21358@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 06, 2013 at 03:28:37AM +0400, Sergei Ianovich wrote:
> pxa2xx-uart was a separate uart platform driver. It was declaring
> the same device names and numbers as 8250 driver. As a result,
> it was impossible to use 8250 driver on PXA SoCs.
> 
> Upon closer examination pxa2xx-uart turned out to be a clone of
> 8250_core driver.
> 
> Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
> CC: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Wonderful!

Can someone else test this to verify it works for them on their platform
as well?

thanks,

greg k-h
