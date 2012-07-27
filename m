From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 27 Jul 2012 11:12:08 -0700
Subject: [2/3][PATCH][v2] TDM Framework
In-Reply-To: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
Message-ID: <20120727181208.GC23105@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2012 at 07:35:38PM +0530, sandeep at freescale.com wrote:
> +static struct kobj_type tdm_type = {
> +	.sysfs_ops = &tdm_ops,
> +	.default_attrs = tdm_attr,
> +};

Ah, also, as per the documentation in the kernel (go look, it's there),
I now get to publicly mock you for ignoring the error messages that
the kernel is giving you when you try to shut down your code path.

Well, to be fair, you are leaking memory like a sieve, so I doubt you
ever saw those error messages because you never cleaned up after
yourself, so perhaps I can forgive you, but your users can't, sorry.
They like to rely on the fact that Linux is a reliable operating system,
don't cause them to doubt that.

Please fix this code, it's horribly broken.  Read
Documentation/kobject.txt for why.  That file was written for a reason,
and not just because we like writing documentation (hint, we hate to...)

Ugh,

greg k-h
