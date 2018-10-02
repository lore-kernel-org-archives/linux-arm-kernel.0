From: greg@kroah.com (Greg KH)
Date: Tue, 2 Oct 2018 15:26:42 -0700
Subject: [PATCH] nvmem: only build nvmem_find_cell_by_index() if OF is
 enabled
In-Reply-To: <20181002110246.3175-1-brgl@bgdev.pl>
References: <20181002110246.3175-1-brgl@bgdev.pl>
Message-ID: <20181002222642.GA19204@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2018 at 01:02:46PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The following warning is produced when building nvmem core if
> CONFIG_OF is disabled:
> 
> drivers/nvmem/core.c:496:1: warning: 'nvmem_find_cell_by_index' defined but not used [-Wunused-function]
>  nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
>  ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> This is caused by the fact that the only caller of this routine is
> under an ifdef depending on this option. Fix it by adding a relevant
> ifdef to the function in question as well.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

No "reported-by:" lines on this and the other patch?

Not nice :(
