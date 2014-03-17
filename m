From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Mar 2014 13:15:35 +0100
Subject: [PATCH 2/2] arm64: dts: exynos: added mailbox node
In-Reply-To: <1395057839-23871-3-git-send-email-ks.giri@samsung.com>
References: <1395057839-23871-1-git-send-email-ks.giri@samsung.com>
 <1395057839-23871-3-git-send-email-ks.giri@samsung.com>
Message-ID: <5346848.pBsh8NcQja@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 March 2014 17:33:59 Girish K S wrote:
> +Samsung Mailbox Driver
> +
> +Required properties:
> +- compatible:          Should be one of the following,
> +                           "samsung,gh7-mailbox" for
> +                               Samsung GH7 SoC series
> +                           "samsung,exynos-mailbox" for
> +                               exynosx SoC series
> +- reg:                 Contains the mailbox register address range (base address
> +                       and length)
> +- interrupts:          Contains the interrupt information for the mailbox
> +                       device.
> +- samsung,mbox-names:  Array of the names of the mailboxes
> 

I think we should not allow new mailbox drivers that don't conform to
the framework that is currently under discussion. In particular, this
means don't do a "samsung,mbox-names" property. The current consensus
seems to be to have a #mbox-cells" property that allows to pass extra
parameters from the client driver, and uses an "mboxes" property
to reference the mailbox provided.

It would be good if you follow up for the subsystem discussion and
ensure it gets merged in time, and supports all the use cases you are
interested in. The interface is not entirely nailed down yet, so
it's a good time to contribute. However, I can already promise that
it won't use matching by strings.

	Arnd
