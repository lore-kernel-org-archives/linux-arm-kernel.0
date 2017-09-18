From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 18 Sep 2017 16:02:14 +0200
Subject: [PATCH] binder: fix "cast to pointer from integer of different
 size" warning
In-Reply-To: <20170904051740.2636-1-jszhang@marvell.com>
References: <20170904051740.2636-1-jszhang@marvell.com>
Message-ID: <20170918140214.GA21714@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 04, 2017 at 01:17:40PM +0800, Jisheng Zhang wrote:
> The binder driver now could cause warnings as below on 32bit platforms
> if ANDROID_BINDER_IPC_32BIT is unselected:
> 
> drivers/android/binder.c:1550:15: warning: cast to pointer from integer
> of different size [-Wint-to-pointer-cast]
> 
> This patch fix all of them.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/android/binder.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Arnd sent in a patch for this issue right after you did, that was
smaller, so I'll take his version.

thanks,

greg k-h
