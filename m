From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Nov 2015 16:19:30 +0100
Subject: [PATCH v4 2/5] mfd: syscon: add a DT property to set value width
In-Reply-To: <1448291861-28543-3-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1448291861-28543-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1448291861-28543-3-git-send-email-damien.riegel@savoirfairelinux.com>
Message-ID: <4954077.yFyHuebvEs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 November 2015 10:17:38 Damien Riegel wrote:
> Currently syscon has a fixed configuration of 32 bits for register and
> values widths. In some cases, it would be desirable to be able to
> customize the value width.
> 
> For example, certain boards (like the ones manufactured by Technologic
> Systems) have a FPGA that is memory-mapped, but its registers are only
> 16-bit wide.
> 
> This patch adds an optional "bus-width" DT binding for syscon that
> allows to change the width for the data bus (i.e. val_bits). If this
> property is provided, it will also adjust the register stride to
> bus-width / 8. If not provided, the default configuration is used.
> 
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
