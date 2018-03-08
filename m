From: jacobchen110@gmail.com (Jacob Chen)
Date: Thu, 8 Mar 2018 18:00:45 +0800
Subject: [PATCH v5 03/16] media: rkisp1: Add user space ABI definitions
In-Reply-To: <d98ac356-a482-f26f-fd6b-6142281d99c3@xs4all.nl>
References: <1514533978-20408-1-git-send-email-zhengsq@rock-chips.com>
 <1514533978-20408-4-git-send-email-zhengsq@rock-chips.com>
 <d98ac356-a482-f26f-fd6b-6142281d99c3@xs4all.nl>
Message-ID: <CAFLEztSsg+EW97AN93gd-rx7A1bNwfHK5e9MpLnem40ATnfsrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

2018-02-07 20:00 GMT+08:00 Hans Verkuil <hverkuil@xs4all.nl>:
> On 12/29/17 08:52, Shunqian Zheng wrote:
>> From: Jeffy Chen <jeffy.chen@rock-chips.com>
>>
>> Add the header for userspace
>
> General note: I saw four cases where this documentation referred to the
> datasheet. Three comments on that:
>
> 1) You don't say which datasheet.
> 2) I assume the datasheet is under NDA?

This datasheet can't be got by customers, even under NDA.

> 3) You do need to give enough information so a reasonable default can be
>    used. I mentioned in an earlier review that creating an initial params
>    struct that can be used as a templete would be helpful (or even
>    required), and that would be a good place to put such defaults.
>

It don't need a default config
For applcation writers, they can just init it with zero data, and only
set value for the part they concerned.

As for ABI, i have checked there is no mismatches.
Those structures is 32 bit aligned both in 64bit/32bit env, since
there is no 64bit value.
"__attribute__ ((packed))" can avoid mismatches happen when we add a
64bit value to those structures.

As robin said, enums and bools are not guaranteed to be consistent
between different compiler, so it's a potential risk.
I have replace bools with unsigned char and enums with unsigned int.


> Regards,
>
>         Hans
