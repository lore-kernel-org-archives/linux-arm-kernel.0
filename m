From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 7 Sep 2018 09:42:51 +0200
Subject: [PATCH v2] usb: xhci: fix interrupt transfer error happened on
 MTK platforms
In-Reply-To: <e8698cc5710a9d1f25e33e2201e2177bfbfec75c.1536305256.git.chunfeng.yun@mediatek.com>
References: <e8698cc5710a9d1f25e33e2201e2177bfbfec75c.1536305256.git.chunfeng.yun@mediatek.com>
Message-ID: <20180907074251.GA2079@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2018 at 03:29:12PM +0800, Chunfeng Yun wrote:
> The MTK xHCI controller use some reserved bytes in endpoint context for
> bandwidth scheduling, so need keep them in xhci_endpoint_copy();

If they are "reserved" shouldn't they be properly named?  And by using
reserved bytes, isn't that a spec violation?

thanks,

greg k-h
