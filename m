From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 29 Feb 2016 09:29:14 +0100
Subject: [PATCH for-4.5] arm/kvm: fix ioctl error handling
In-Reply-To: <1456673397-23625-1-git-send-email-mst@redhat.com>
References: <1456673397-23625-1-git-send-email-mst@redhat.com>
Message-ID: <20160229082914.GA3471@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 28, 2016 at 05:32:07PM +0200, Michael S. Tsirkin wrote:
> Calling return copy_to_user(...) in an ioctl will not
> do the right thing if there's a pagefault:
> copy_to_user returns the number of bytes not copied
> in this case.
> 
> Fix up kvm to do
> 	return copy_to_user(...)) ?  -EFAULT : 0;
> 
> everywhere.
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
