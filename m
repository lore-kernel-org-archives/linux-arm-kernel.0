From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Jan 2011 23:28:41 +0000
Subject: [PATCH] ARM: Change misleading warning when
	CONFIG_CMDLINE_FORCE is used
In-Reply-To: <1294766953-6889-1-git-send-email-holler@ahsoftware.de>
References: <1294766953-6889-1-git-send-email-holler@ahsoftware.de>
Message-ID: <20110111232841.GQ11039@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 06:29:13PM +0100, Alexander Holler wrote:
> +#else
> +	printk(KERN_WARNING
> +		"Ignoring tag cmdline"
> +		" (using the default kernel command line)\n");

In addition to Jamey's comment, we do have a set of pr_xxx helpers:

	pr_warning("Ignoring tag cmdline (using the default kernel command line)\n");

which I think is neater.
