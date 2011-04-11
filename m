From: greg@kroah.com (Greg KH)
Date: Mon, 11 Apr 2011 14:06:31 -0700
Subject: [RFC][PATCH V3] axi: add AXI bus driver
In-Reply-To: <1302557114-7880-1-git-send-email-zajec5@gmail.com>
References: <1302557114-7880-1-git-send-email-zajec5@gmail.com>
Message-ID: <20110411210631.GA28559@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2011 at 11:25:14PM +0200, Rafa? Mi?ecki wrote:
> +static void axi_release_core_dev(struct device *dev)
> +{
> +	/* Silent lack-of-release warning */
> +}

Ok, WTF!!!!

As per the documentation in the kernel I now get to publically mock you
for trying to be smarter than the kernel.  Why did you think that if you
just magically gave an empty function to the kernel it would solve the
problem that THE KERNEL WAS TRYING TO TELL YOU TO FIX IN THE FIRST
PLACE?

{sigh}

It's as if no one reads the documentation, or even pays attention to the
message that the kernel spits out and they think they know better.

Totally and completely unacceptable.

Fix this now.

greg k-h
