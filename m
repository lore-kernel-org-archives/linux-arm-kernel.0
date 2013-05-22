From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 22 May 2013 23:17:46 +0200
Subject: [PATCH v4 11/12] ARM: kirkwood: remove redundant DT board files
In-Reply-To: <20130522210257.GM31290@titan.lakedaemon.net>
References: <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369154510-4927-12-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130522203633.GA28394@schnuecks.de> <519D30CF.9040904@gmail.com>
 <20130522210257.GM31290@titan.lakedaemon.net>
Message-ID: <519D35FA.2060002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2013 11:02 PM, Jason Cooper wrote:
> On Wed, May 22, 2013 at 10:55:43PM +0200, Sebastian Hesselbarth wrote:
>> On 05/22/2013 10:36 PM, Simon Baatz wrote:
>>> Hi Sebastian,
>>>
>>> On Tue, May 21, 2013 at 06:41:49PM +0200, Sebastian Hesselbarth wrote:
>>>> With DT support for mv643xx_eth, board specific init for some boards now
>>>> is unneccessary. Remove those board files, Kconfig entries, and
>>>> corresponding entries in kirkwood_defconfig.
>>>>
>>>> Signed-off-by: Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>
>>>> ---
>>>> Note: board-km_kirkwood.c is also removed, as Valentin Longchamp confirmed
>>>> the lock-up is not caused by accessing clock gating registers but rather
>>>> non-existent device registers. This will be addressed by dtsi separation
>>>> for kirkwood and bobcat SoC variants.
>>>>
>>>> Changelog:
>>>> v3->v4:
>>>> - remove more boards that don't require board specific setup
>>>>
>> ...
>>
>> I would stick with "marvell,kirkwood" only. This is SoC init code and
>> we do not distinguish variants here at all.
>
> Agreed, nice catch Simon.

I just confirmed all kirkwood dts/dtsi properly set "marvell,kirkwood"
in their compatible strings. Will remove all other comapatible strings
from mach-kirkwood/board-dt.c as Simon suggested for v5.

Sebastian
