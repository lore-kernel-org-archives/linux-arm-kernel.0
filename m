From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 3 Jan 2018 00:43:35 -0200
Subject: [PATCH V3] ARM: imx: use outer_disable/resume for low power
In-Reply-To: <DB6PR04MB3221B5BFB31D39309EF5C7EB881E0@DB6PR04MB3221.eurprd04.prod.outlook.com>
References: <1514452141-14948-1-git-send-email-peng.fan@nxp.com>
 <DB6PR04MB3221B5BFB31D39309EF5C7EB881E0@DB6PR04MB3221.eurprd04.prod.outlook.com>
Message-ID: <CAOMZO5An8ASQf74mUP07XucJQWsPRjZSB21VzCeHBqcbWJtRBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peng,

On Tue, Jan 2, 2018 at 10:53 PM, Peng Fan <peng.fan@nxp.com> wrote:

>
> A better solution maybe
>
> if (outer_cache.write_sec)
>         outer_disable();
>
> .....
>
> if (outer_cache.write_sec)
>         outer_resume();
>
> Then, nothing changed for secure linux. The outer_disable/outer_resume only effects
> When linunx running in non-secure world.
>
> Any comments?

Looks like a better solution, indeed.
