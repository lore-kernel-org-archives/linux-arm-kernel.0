From: r.sricharan@ti.com (R, Sricharan)
Date: Thu, 10 May 2012 16:52:00 +0530
Subject: [PATCH 01/13] ARM: OMAP5: id: Add cpu id for ES versions
In-Reply-To: <4FABA406.1080608@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-2-git-send-email-r.sricharan@ti.com>
 <4FABA406.1080608@ti.com>
Message-ID: <CAJ7qFSf-r2aXJsh+gP4X9+4kYqnwGu9-jMXOkJNTaEgF6Ug=OA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,

>> +void __init omap5xxx_check_revision(void)
>> +{
>> + ? ? u32 idcode;
>> + ? ? u16 hawkeye;
>> + ? ? u8 rev;
>> +
>> + ? ? idcode = read_tap_reg(OMAP_TAP_IDCODE);
>> + ? ? hawkeye = (idcode >> 12) & 0xffff;
>> + ? ? rev = (idcode >> 28) & 0xff;
>> + ? ? switch (hawkeye) {
>> + ? ? case 0xb942:
>> + ? ? ? ? ? ? switch (rev) {
>> + ? ? ? ? ? ? case 0:
>> + ? ? ? ? ? ? ? ? ? ? omap_revision = OMAP5430_REV_ES1_0;
>> + ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? ? ? ? ? case 1:
>> + ? ? ? ? ? ? ? ? ? ? omap_revision = OMAP5430_REV_ES2_0;
>> + ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? ? ? ? ? default:
>> + ? ? ? ? ? ? ? ? ? ? omap_revision = OMAP5430_REV_ES1_0;
>
> Default should always be the latest version supported. i.e. in this case
> it should be OMAP5430_REV_ES2_0
>
 ok thanks, will correct it.

Thanks,
 Sricharan
