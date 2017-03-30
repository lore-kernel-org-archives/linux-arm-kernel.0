From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 30 Mar 2017 19:53:59 +0530
Subject: [PATCH] ARM: dts: am57xx-idk: Add DCAN support
In-Reply-To: <20170306184113.GN20572@atomide.com>
References: <8981d49e7011a7246ff7dc6a9a9da0a56dfe5621.1487670384.git.nsekhar@ti.com>
 <f8862417-e9e0-e2ac-865a-9684f96a5128@ti.com>
 <20170306184113.GN20572@atomide.com>
Message-ID: <042d52f4-3148-0564-a41a-5212ede042d5@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Tuesday 07 March 2017 12:11 AM, Tony Lindgren wrote:
> * Sekhar Nori <nsekhar@ti.com> [170221 02:13]:
>> On Tuesday 21 February 2017 03:30 PM, Sekhar Nori wrote:
>>> From: Schuyler Patton <spatton@ti.com>
>>>
>>> AM571x IDK and the AM572x IDK use CAN1 interface.
>>> This patch enables it for both boards.
>>>
>>> Tested on AM572x IDK using cansequence.
>>>
>>> Signed-off-by: Schuyler Patton <spatton@ti.com>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>>> [nsekhar at ti.com: move to use DRA7XX_CORE_IOPAD())
>>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>>
>> I should have noted that although CAN does function on the IDK with this
>> patch, there are "omap_hwmod: dcan1: _wait_target_disable failed"
>> messages that come up due to lack of workaround for errata i893[1]
>>
>> Roger does have some patches to workaround that errata. If you want to
>> wait for those patches to be submitted and accepted first, it should be
>> fine as well.
> 
> OK let's wait a bit on this then to avoid introducing extra warnings.

Now that Roger's hwmod patches for the DCAN errata are in linux-next,
this patch can be applied safely. Let me know if you need me to resend it.

Thanks,
Sekhar
