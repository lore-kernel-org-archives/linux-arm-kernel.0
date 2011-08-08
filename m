From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 9 Aug 2011 00:02:37 +0530
Subject: [PATCH 13/15] spi/s3c64xx: Merge dma control code
In-Reply-To: <1311744697-10264-14-git-send-email-boojin.kim@samsung.com>
References: <1311744697-10264-1-git-send-email-boojin.kim@samsung.com>
	<1311744697-10264-14-git-send-email-boojin.kim@samsung.com>
Message-ID: <CABb+yY0ZRNnkrTNWhYShBRpLFr8RB=eL6NqQHuv1aW=o2KfoSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27, 2011 at 11:01 AM, Boojin Kim <boojin.kim@samsung.com> wrote:
> This patch modifies to merge the dma control code.
> Original s3c64xx spi driver has each dma control code for rx and tx channel.
> This patch merges these dma control codes into one.
> With this patch, a dma setup function and callback function handle
> for both rx and tx channel.

This is nothing really to do with underlying DMAENGINE API.
And, apparently it actually bloats the driver ?   76 insertions(+), 64
deletions(-)
Yet, I am not very against the idea.

If you must do it, maybe It would have been better to move it early in
the patchset,
which would have resulted in a smaller and cleaner  "spi/s3c64xx: Add
support DMA engine API"
