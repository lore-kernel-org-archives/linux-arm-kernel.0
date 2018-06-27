From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 26 Jun 2018 22:19:56 -0300
Subject: [PATCH V2] ARM: dts: imx6sll-evk: make pfuze100 sw4 always on
In-Reply-To: <1529974900-28865-1-git-send-email-Anson.Huang@nxp.com>
References: <1529974900-28865-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5CfmYvE0hLfeni6wQfE6j7C2qa9teQbo3zOWCnq33zhBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Mon, Jun 25, 2018 at 10:01 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> On i.MX6SLL EVK board, PFuze100's SW4 is supplying
> LPDDR3, it needs to be always on. This patch fixes
> Linux kernel boot up hang caused by commit
> (5fe156f regulator: pfuze100: add enable/disable for switch),
> because SW4 is turned off unexpectedly:

Nit: The proper way to reference a commit is:

commit 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for switch")

12 char for the commit ID and the commit name inside (" ").

> [    1.693613] cfg80211: failed to load regulatory.db
> [    1.700063] SW4: disabling
> [    1.703973] SWBST: disabling

Probably worth adding the Fixes tag so that it can fix the boot
regression in 4.18-rc:

Fixes: 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for switch")

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
