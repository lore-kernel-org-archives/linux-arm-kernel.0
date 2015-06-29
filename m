From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Jun 2015 20:12:36 +0800
Subject: [PATCH] ARM: dts: ventana: add UHS-I support for Ventana boards
In-Reply-To: <1433446346-7382-1-git-send-email-tharvey@gateworks.com>
References: <1433446346-7382-1-git-send-email-tharvey@gateworks.com>
Message-ID: <20150629121236.GN10332@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 04, 2015 at 12:32:26PM -0700, Tim Harvey wrote:
> UHS-I support is available on Ventana boards with micro-SD sockets depending
> on the board revision. To support this pinctl states for 100Mhz and 200MHz
> must be added as well as pinmux of the VSELECT signal. In order to support
> UHS-I the I/O rail of the 4-bit data bus must be switchable between 1.8V
> and 3.3V.
> 
> By adding the no-1-8-v property, which disables UHS-I support, we allow the
> bootloader to be in charge of selecting which boards have this capability
> by removing that property if the board model/revision implement the support.
> 
> Additionally we will remove NANDF_CS1 here from the nand pinmux group as the
> second chip-select is not used on any ventana boards and this is the pad
> that is used for SD3_VELECT.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks.
