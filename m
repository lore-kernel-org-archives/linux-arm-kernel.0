From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 10 Nov 2016 14:35:59 +0100
Subject: [PATCH 0/2] mmc: allow mmc_alloc_host() and tmio_mmc_host_alloc()
In-Reply-To: <1478784263-18777-1-git-send-email-yamada.masahiro@socionext.com>
References: <1478784263-18777-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20161110133559.GA10191@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 10:24:21PM +0900, Masahiro Yamada wrote:
> 
> sdhci_alloc_host() returns an error pointer when it fails.
> but mmc_alloc_host() cannot.
> 
> This series allow to propagate a proper error code
> when host-allocation fails.

Why?  What can we really do about the error except give up?  Why does
having a explicit error value make any difference to the caller, they
can't do anything different, right?

I suggest just leaving it as-is, it's simple, and you don't have to mess
with PTR_ERR() anywhere.

thanks,

greg k-h
