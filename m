From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 15 Mar 2015 22:48:18 +0000
Subject: [PATCH 02/10] ARM: zx: add low level debug support
In-Reply-To: <1426333785-3952-3-git-send-email-jun.nie@linaro.org>
References: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
 <1426333785-3952-3-git-send-email-jun.nie@linaro.org>
Message-ID: <20150315224817.GC8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 14, 2015 at 07:49:37PM +0800, Jun Nie wrote:
> Use the UART0 peripheral for low level debug. Only the UART port 0 is
> currently supported.

None of this code is necessary - in fact, you don't have to add one line
of assembly code what so ever.

We have generic PL011 debug support.  Please use that, you only need to
ensure that the phys and virtual addresses are properly configured in
arch/arm/Kconfig.debug and that the appropriate symbol is selected.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
