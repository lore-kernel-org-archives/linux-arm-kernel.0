From: benoit.cousson@gmail.com (Benoit Cousson)
Date: Mon, 29 Jul 2013 15:39:59 +0200
Subject: [PATCH 0/9] ARM: dts: omap5-uevm: fixup wrong regulator
 configuration
In-Reply-To: <51F66B65.4030702@ti.com>
References: <1374079538-19548-1-git-send-email-nm@ti.com>
 <51F63C74.6070503@ti.com> <51F66B65.4030702@ti.com>
Message-ID: <51F670AF.9080808@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nishanth,

On 29/07/2013 15:17, Nishanth Menon wrote:
> On 07/29/2013 04:57 AM, Keerthy wrote:
>> Hi Nishanth,
>>
>> On Wednesday 17 July 2013 10:15 PM, Nishanth Menon wrote:
>>> Due to wrong older revision of documentation used as reference, we
>>> seem to have a bunch of LDOs wrongly configured on OMAP5 uEVM. This
>>> series is based power tree on production board 750-2628-XXX platform.
>>> Unfortunately, the wrong voltages may be detrimental to OMAP5 as they
>>> supply hardware blocks at voltages that are out of specification.
>>
>> This series looks good to me.
>>
>> Acked-by:  J Keerthy <j-keerthy@ti.com>
>
> Tony, Benoit - this series could prevent OMAP5 from being damaged on
> uEVMs with current 3.11 rc - could you suggest what we need to do to
> get it in?

I'm still on vacation with no way to pull any patch... but I can still
comment on the series quickly.

It seems to me that this series contains some real fixes that might
damage the board due to hihest voltage than expected and some which are
just improvement like for the SMPS9 or LDO[28]. In theory they should no
go necesseraly to -rc, but, I guess that's fine for that one.

All the "fixes" are sharing more than 50% of the changelog content with
only 2 changes in the code, so you'd better squash them into one patch
to avoid repeating the same thing again and again.

Beside that, I will ack the updated one to allow Tony to push them ASAP.

Regards,
Benoit
