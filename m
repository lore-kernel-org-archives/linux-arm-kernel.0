From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 13 Apr 2016 07:12:54 -0700
Subject: [PATCH v7 1/2] drivers: base: add support for registering
 notifier about deferred probe
In-Reply-To: <1460540160-18762-2-git-send-email-m.szyprowski@samsung.com>
References: <1460540160-18762-1-git-send-email-m.szyprowski@samsung.com>
 <1460540160-18762-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20160413141254.GB12749@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2016 at 11:35:59AM +0200, Marek Szyprowski wrote:
> This patch adds code which allow other subsystems get a notification
> when deferred probe has been triggered. This way one can retry some
> actions, which earlier failed with -EPROBE_DEFER error code.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Why would some other subsystem want/care about this?  You aren't telling
them what device was deferred, and you don't need to as the bus itself
already knows this information as it did the deferring!

confused,

greg k-h
