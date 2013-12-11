From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 11 Dec 2013 11:48:26 +0800
Subject: [PATCH 3/6] mmc: sdhci: add platform set_timeout hook
In-Reply-To: <CAA+hA=STB-M5H9VsFjx4bqgbdPAAzgbChVY4JrsGdBKqYnmGkA@mail.gmail.com>
References: <1386680168-5227-1-git-send-email-b29396@freescale.com>
 <1386680168-5227-4-git-send-email-b29396@freescale.com>
 <20131211021646.GC18380@S2101-09.ap.freescale.net>
 <CAA+hA=T6WN93=RgNUKkjJjMj6WpGbk0pnTpZvYLEUtOgMGv7Kg@mail.gmail.com>
 <20131211031853.GG18380@S2101-09.ap.freescale.net>
 <CAA+hA=STB-M5H9VsFjx4bqgbdPAAzgbChVY4JrsGdBKqYnmGkA@mail.gmail.com>
Message-ID: <20131211034824.GH18380@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 11:35:17AM +0800, Dong Aisheng wrote:
> This actually is the register value, not the max timeout counter value.
> Then you may want define the API as:
> unsigned int    (*get_max_timeout_val)(struct sdhci_host *host);

Yes, something like that.

> But i don't think it's necessary to do the max timeout setting in two steps.
> First, deinfe a API to get the max timeout counter val,
> Second, write this val into register.
> Why not simply implement .set_timeout and handle the details in
> platform specific
> host driver respectively?

Well, that's how sdhci host driver is structured.  Doing so leaves the
least details to platform driver, and calling sdhci_writeb() to access
SDHCI_TIMEOUT_CONTROL in sdhci-esdhc-imx seems a layer violation to me.

> 
> Furthermore, this API does not  help for the patch#1 issue.

Oh, they two different issues, and should be addressed by different
hooks.

Shawn
