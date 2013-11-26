From: angus.clark@st.com (Angus Clark)
Date: Tue, 26 Nov 2013 14:48:35 +0000
Subject: [PATCH 1/4] mtd: spi-nor: move the SPI NOR commands to a new
 header file
In-Reply-To: <52946197.5050104@freescale.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <1385447575-23773-2-git-send-email-b32955@freescale.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA4EC81@DBDE04.ent.ti.com>
 <52946197.5050104@freescale.com>
Message-ID: <5294B4C3.9080201@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2013 08:53 AM, Huang Shijie wrote:
> Hi Pekon:
>> (1)
>> It's better to take all Flash vendor specific opcodes from DT..
> firstly, some arch may does not support the DT, such as x86.

Indeed, although the 'flash_platform_data' structure could be extended to
provide similar functionality, if that were deemed the right way to go.  However...

> 
> second, it makes people crazy if we put the opcodes in the DT :)

I would agree.  Where possible, I think it's preferable for the driver to probe
device properties at runtime.  One benefit, often overlooked, is that it allows
board manufacturers to second-source parts without having to rebuild, and
possibly re-certify, binaries.

>> With new framework we should do away with macros for each vendor,
>> instead let each board file provide this information based on flash
>> device
>> which is mounted on it.
>>
>> (2)
>> And also, I suggest not to touch m25p80 in anyway, bcoz it stable driver
>> used by many. So unless spi-nor framework is accepted and is stable we
>> m25p80 should continue working as it is.
>> Thus your patches should be independent of any existing driver or other
>> frameworks. This way it might get accepted fast. Then later you can
>> provide
>> a way to attach m25p80 to spi-nor framework.
>> Thoughts ?
> the merge window is closed not long ago, and we have rc1 now.
> 
> Isn't it the BEST time to change the m25p80?
> 

The spi-nor framework has great potential, but I think you should allow some
time for other driver developers to comment, and the framework to mature.
Without greater support, it risks becoming another single-use framework.

Cheers,

Angus

> thanks
> Huang Shijie
> 
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 

-- 
-------------------------------------
Angus Clark
ST Microelectronics (R&D) Ltd.
1000 Aztec West, Bristol, BS32 4SQ
email: angus.clark at st.com
tel: +44 (0) 1454 462389
st-tina: 065 2389
-------------------------------------
