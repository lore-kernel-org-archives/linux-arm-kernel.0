From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 4 Apr 2016 21:21:57 -0300
Subject: [PATCH v4 3/3] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <1459354720.2505.98.camel@pengutronix.de>
References: <1456476714-11351-1-git-send-email-p.zabel@pengutronix.de>
 <1456476714-11351-4-git-send-email-p.zabel@pengutronix.de>
 <56D60C90.7080703@timesys.com>
 <CACrMeVAtLMdx6FhhmvxOq=_q=HztU_2nqVwzbL3dYBHd-PWKUg@mail.gmail.com>
 <CAOMZO5DJ=2xo3ciDDoC1KVwHpxagEjNHq5hEkS7StBzaXrk-pQ@mail.gmail.com>
 <56F9855B.9060009@timesys.com>
 <CAOMZO5CsCfprq_br-omNyeE_T7XC7Do+Z0qOT68msZSu9QedqA@mail.gmail.com>
 <1459354720.2505.98.camel@pengutronix.de>
Message-ID: <CAOMZO5C3eu6W2hHF40giuTgRaP8y9KAZOihr+7kPn627vCkVhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Wed, Mar 30, 2016 at 1:18 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:

>> > 1. NXP 3.10 kernel switches clock source as follows:
>> > current_parent -> 7 -> 4 -> new_parent
>>
>> Yes, we need to follow this requirement.
>
> Thanks. Does anybody know why?

The SoC folks say this needs to be done to make sure the glitch is not
propagated.

> (Does this work for current_parent == 4 and new_parent != 0)?

They say it works for all combinations.

> Is this also true for starting values other than 3?

Yes.
