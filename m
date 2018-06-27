From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 26 Jun 2018 22:20:48 -0300
Subject: [PATCH] ARM: dts: make pfuze switch always-on for imx platforms
In-Reply-To: <1529993283-32396-1-git-send-email-Anson.Huang@nxp.com>
References: <1529993283-32396-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5C--fpkRLfwmySFJeO2hwPdz3paxW1WMiqcqraqmbL9Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2018 at 3:08 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> commit (5fe156f regulator: pfuze100: add enable/disable
> for switch) will cause those unreferenced switches being

Nit: The proper way to reference a commit is:

commit 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for switch")

12 char for the commit ID and the commit name inside (" ").

> turned off if "regulator-always-on" is NOT present, as
> pfuze switches are normally used by critical modules which
> must be always ON or shared by many peripherals which
> do NOT implement power domain control, so just make sure
> all switches always ON to avoid any system issue caused
> by unexpectedly turning off switches.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
