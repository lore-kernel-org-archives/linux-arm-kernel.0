From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Sep 2017 12:52:55 +0100
Subject: [PATCH 0/2] ARM: earlycon: Fix <CR><LF><CR> end-of-line
In-Reply-To: <20170927114929.9259-1-alexander.sverdlin@nokia.com>
References: <20170927114929.9259-1-alexander.sverdlin@nokia.com>
Message-ID: <20170927115255.GT20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 27, 2017 at 01:49:27PM +0200, Alexander Sverdlin wrote:
> Since very beginning the early serial console on ARM produces <CR><LF><CR>
> line terminator. There are couple of problems connected:
> 1. C function early_write() adds <CR> to each <LF> even though underlying
>    Assembler printch() does this already
> 2. printch() adds <CR> *after* <LF>, not before, as it is usually being done

You omit to say why you want this change...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
