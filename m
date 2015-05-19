From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 19 May 2015 11:01:17 +0800
Subject: [PATCH V2] ARM: imx53: Set DDR pins to high impedance when in
 suspend to RAM.
In-Reply-To: <20150512124032.7328.18562.stgit@localhost>
References: <20150512124032.7328.18562.stgit@localhost>
Message-ID: <20150519030117.GL1071@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 03:31:03PM +0200, Martin Fuzzey wrote:
> In order to save power the DDR pins should be put into high
> impedance when in suspend to RAM.
> 
> This requires manually requesting self refresh (rather than using the
> automatic mode implemented by the CCM / ESDCTL), followed by
> reconfiguring the IOMUXC.
> 
> Of course the code to do this cannot itself run from DDR so the
> code is copied to and executed from internal memory.
> 
> In my tests using a custom i.MX53 board with LPDDR2 RAM
> this reduced the suspend power consumption from 200mW to 60mW.
> 
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>

Applied, thanks.
