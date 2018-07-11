From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 11 Jul 2018 12:09:15 -0300
Subject: next/master boot: 184 boots: 13 failed, 171 passed (next-20180711)
In-Reply-To: <20180711145253.GA9651@sirena.org.uk>
References: <5b45f6df.1c69fb81.86409.6375@mx.google.com>
 <20180711145253.GA9651@sirena.org.uk>
Message-ID: <CAOMZO5B+LBwAEewEoCn=TojQuZ=qMt+4a8n+tiG9cfnzAta_9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, Jul 11, 2018 at 11:52 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Jul 11, 2018 at 05:23:59AM -0700, kernelci.org bot wrote:
>
> Today's -next fails to boot on the Wandboards but only the i.MX
> defconfg:
>
>>     imx_v6_v7_defconfig:
>>         imx6dl-wandboard_dual:
>>             lab-baylibre-seattle: new failure (last pass: next-20180710)
>>         imx6dl-wandboard_solo:
>>             lab-baylibre-seattle: new failure (last pass: next-20180710)
>>         imx6q-wandboard:
>>             lab-baylibre-seattle: new failure (last pass: next-20180710)
>
> multi_v7_defconfig is fine, there are some failures on other platforms
> but not i.MX.  The failures happen at a very similar point but the
> precise oops varies (one was an illegal instruction):
>
> | [    2.208738] caam 2100000.caam: job rings = 2, qi = 0
> | [    2.227429] caam algorithms registered in /proc/crypto
> | [    2.235409] Bad mode in data abort handler detected
> | [    2.235433] caam_jr 2101000.jr0: job ring error: irqstate: 00000103
> | [    2.240321] Internal error: Oops - bad mode: 0 [#1] SMP ARM
> | [    2.252163] Modules linked in:
>
> Full log and more details for the base wandboard at:
>
>     https://kernelci.org/boot/id/5b45cf3b59b514f35b96ba95/

This is caused by the following commit in linux-next:

commit f9b6e485fa ("crypto: caam: cleanup CONFIG_64BIT ifdefs when
using io{read|write}64")

I have already reported this issue on a linux-next tree from last week
and Stephen said he was going to drop such commit:
https://patchwork.kernel.org/patch/10507333/

but it reappeared today's linux-next.

Stephen, Andrew

Could you please drop it?

Thanks
