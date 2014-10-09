From: ankit.jindal@linaro.org (Ankit Jindal)
Date: Thu, 9 Oct 2014 17:47:36 +0530
Subject: [PATCH v2 0/6] UIO driver for APM X-Gene QMTM
In-Reply-To: <2114579.IN6EpqPdMv@wuerfel>
References: <1412051169-9142-1-git-send-email-ankit.jindal@linaro.org>
 <CAPTm99V-xyXa7WQG2jzDz19gotJ0aQRPk_rb5ukvUpdFyFabfw@mail.gmail.com>
 <2114579.IN6EpqPdMv@wuerfel>
Message-ID: <CAPTm99WBE7RnGYNZsCfsenYcR3wNSVYOg--90_s1Ji_=Vj5myA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 October 2014 17:36, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 09 October 2014 14:14:33 Ankit Jindal wrote:
>> On 30 September 2014 09:56, Ankit Jindal <ankit.jindal@linaro.org> wrote:
>> > This patchset enables user space access to APM X-Gene QMTM
>> > using UIO framework.
>> >
>> > The patchset also introduces new type UIO_MEM_PHYS_CACHE
>> > for mem regions because APM X-Gene QMTM device supports
>> > cache coherency with CPU caches.
>>
>
> I haven't been able to review the patch in detail yet, but I have
> a very high-level question: how do you decide which driver to use?
>
> I understand that the normal use case is for the QMTM to be used by
> the kernel directly rather than being exported to user space, and
> that the network driver will just use it if it is there.

This UIO driver will be disabled by default. When this driver is
enabled, the other dependent drivers need to be removed from the
config.

>
>         Arnd

Thanks,
Ankit
