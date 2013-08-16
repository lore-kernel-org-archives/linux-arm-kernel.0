From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 16 Aug 2013 11:52:56 -0700
Subject: [PATCH RFC 2/3] spmi: Add MSM PMIC Arbiter SPMI controller
In-Reply-To: <2b97e8deb412ae0087bffe227690a26ea9dd9bba.1376596224.git.joshc@codeaurora.org>
References: <cover.1376596224.git.joshc@codeaurora.org>
 <2b97e8deb412ae0087bffe227690a26ea9dd9bba.1376596224.git.joshc@codeaurora.org>
Message-ID: <20130816185256.GC31510@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 01:37:07PM -0700, Josh Cartwright wrote:
> +struct spmi_pmic_arb_dev {
> +	struct spmi_controller	controller;
> +	struct device		*dev;
> +	struct device		*slave;

This is problematic.

Why do you have the driver "own" the controller?  What is dev for,
there's already a struct device within the controller.  Same for slave,
what is it?

You have 3 struct devices here, which one controls the lifecycle of the
object (hint, I know the answer, but I think it's wrong...)

thanks,

greg k-h
