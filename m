From: gregkh@linuxfoundation.org (Greg KH)
Date: Sun, 4 Oct 2015 19:33:34 +0100
Subject: [PATCH 1/4] sysfs: Support is_visible() on binary attributes
In-Reply-To: <1442842703-5309-2-git-send-email-emilio.lopez@collabora.co.uk>
References: <1442842703-5309-1-git-send-email-emilio.lopez@collabora.co.uk>
 <1442842703-5309-2-git-send-email-emilio.lopez@collabora.co.uk>
Message-ID: <20151004183334.GA23538@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2015 at 10:38:20AM -0300, Emilio L?pez wrote:
> According to the sysfs header file:
> 
>     "The returned value will replace static permissions defined in
>      struct attribute or struct bin_attribute."
> 
> but this isn't the case, as is_visible is only called on struct attribute
> only. This patch introduces a new is_bin_visible() function to implement
> the same functionality for binary attributes, and updates documentation
> accordingly.
> 
> Note that to keep functionality and code similar to that of normal
> attributes, the mode is now checked as well to ensure it contains only
> read/write permissions or SYSFS_PREALLOC.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Emilio L?pez <emilio.lopez@collabora.co.uk>

As this should probably go through the "platform drivers" maintainer,
I'll just give you this:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

So it can go through their tree and not require me to just take this
one.

thanks,

greg k-h
