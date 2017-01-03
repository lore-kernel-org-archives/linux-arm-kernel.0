From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 3 Jan 2017 10:59:42 +0800
Subject: [PATCH v3] ARM: dts: imx6: Disable "weim" node in the dtsi files
In-Reply-To: <1483092543-14233-1-git-send-email-festevam@gmail.com>
References: <1483092543-14233-1-git-send-email-festevam@gmail.com>
Message-ID: <20170103025940.GN20956@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2016 at 08:09:03AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Commit 1be81ea5860744520 ("ARM: dts: imx6: Add imx-weim parameters to
> dtsi's") causes the following probe error when the weim node is not
> present on the board dts (such as imx6q-sabresd):
> 
> imx-weim 21b8000.weim: Invalid 'ranges' configuration
> imx-weim: probe of 21b8000.weim failed with error -22
> 
> There is no need to always enable the "weim" node on mx6. Do the same
> as in the other i.MX dtsi files where "weim" is disabled and only gets
> enabled on a per dts basis.
> 
> All the imx6 weim dts users explicitily provide 'status = "okay"', so
> this change has no impact on current imx6 weim users.
> 
> If a board does not use the weim driver it will not describe its 'ranges'
> property, so simply disable the 'weim' node in the imx6 dtsi files to
> avoid such probe error message.
> 
> Fixes: 1be81ea5860744520 ("ARM: dts: imx6: Add imx-weim parameters to dtsi's")
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
