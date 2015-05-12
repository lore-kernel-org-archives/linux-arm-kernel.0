From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 12 May 2015 15:42:16 -0700
Subject: [PATCH v3] dma-buf: add ref counting for module as exporter
In-Reply-To: <1431092563-19799-1-git-send-email-sumit.semwal@linaro.org>
References: <1431092563-19799-1-git-send-email-sumit.semwal@linaro.org>
Message-ID: <20150512224216.GA16712@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 07:12:43PM +0530, Sumit Semwal wrote:
> Add reference counting on a kernel module that exports dma-buf and
> implements its operations. This prevents the module from being unloaded
> while DMABUF file is in use.
> 
> The original patch [1] was submitted by Tomasz Stanislawski, but this
> is a simpler way to do it.
> 
> v3: call module_put() as late as possible, per gregkh's comment.
> v2: move owner to struct dma_buf, and use DEFINE_DMA_BUF_EXPORT_INFO
>     macro to simplify the change.
> 
> Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> 
> [1]: https://lkml.org/lkml/2012/8/8/163
> ---
>  drivers/dma-buf/dma-buf.c | 10 +++++++++-
>  include/linux/dma-buf.h   | 10 ++++++++--
>  2 files changed, 17 insertions(+), 3 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
