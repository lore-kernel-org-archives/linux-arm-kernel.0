From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Jul 2016 17:11:42 +0100
Subject: [PATCH] ARM: dma-mapping: Use %zu for printing a size_t variable
In-Reply-To: <7fe0460e-3455-cb37-c961-ca44841abdcb@gmail.com>
References: <1468714210-1407-1-git-send-email-festevam@gmail.com>
 <7fe0460e-3455-cb37-c961-ca44841abdcb@gmail.com>
Message-ID: <20160718161142.GI1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 18, 2016 at 06:03:05PM +0200, Matthias Brugger wrote:
> 
> 
> On 07/17/2016 02:10 AM, Fabio Estevam wrote:
> >-	pr_err("DMA: failed to allocate %zx KiB pool for atomic coherent allocation\n",
> >+	pr_err("DMA: failed to allocate %zu KiB pool for atomic coherent allocation\n",
> 
> size_t should be formated as %zu or %zx so %zx is fine here.

However, when it prints:

DMA: failed to allocate 100 KiB pool for atomic coherent allocation

how are you going to interpret it if you don't know the format string?

This change is exactly the right thing to do here.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
