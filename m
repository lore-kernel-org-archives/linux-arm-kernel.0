From: glee-list@swspec.com (Greg Lee)
Date: Mon, 21 Sep 2009 20:40:05 -0400
Subject: Follow-up on "WARNING: at arch/arm/mm/consistent.c:368
	dma_free_coherent"
In-Reply-To: <f7cd29ea0909211700l4e79476bi9f09fe058804a17f@mail.gmail.com>
References: <f7cd29ea0909211700l4e79476bi9f09fe058804a17f@mail.gmail.com>
Message-ID: <f7cd29ea0909211740m288fb963pe0767a7e5bab8f50@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2009 at 8:00 PM, Greg Lee <glee-list@swspec.com> wrote:
> I then found a recently updated patch from Mikael that appears to
> address this problem here
> (http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-arm-ixp4xx-disable-dmabounce-2.6.31).
>
> This updated patch does not appear to account for the 4K region at the
> end of the 64MB PCI window that I mentioned above. ?Does this region
> in fact need to be accounted for? ?Or has this now been handled
> differently?

Ahh!  I just found this discussion here
(http://lists.arm.linux.org.uk/lurker/message/20081214.222544.ea9b3653.en.html)
where Krzysztof Halasa discovers that BAR4 can be mapped after the
64MB PCI window to prevent hangs.  So, this 4K region issue is not a
problem if Kryzsztof's BAR4 patch is in place which it is in 2.6.31
where we are testing.

Now I need to figure out why our USB devices are not working when we
use Mikael's no dmabounce patch.

Greg
