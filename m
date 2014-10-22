From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 22 Oct 2014 13:42:27 +0400
Subject: [PATCH V2 1/2] ARM: pxa: spitz: register spitz-audio device
In-Reply-To: <1935279.fumFSz5CfW@wuerfel>
References: <1413926133-3566-1-git-send-email-dbaryshkov@gmail.com>
 <1935279.fumFSz5CfW@wuerfel>
Message-ID: <CALT56yOM--1-M4-we8WLVEC2tiSU+_48b1X=tWB2vQ7fepKCgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-10-22 12:46 GMT+04:00 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 22 October 2014 01:15:32 Dmitry Eremin-Solenikov wrote:
>> Register spitz-audio device to be used by ASoC driver.
>>
>> [V2: Removed ifdefs around spitz_audio_init].
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> ---
>>
>
> A more general note about your patch description above: when you
> write about the changes between versions, put that below the ---
> line under your Signed-off-by. Aside from that, your changelog
> entry would actually benefit from more verbosity: explain what the
> purpose of this is, not just what it does.

Thanks. I understood your point regarding the changelog.
The commit message seemed pretty much obvious - due to
the second patch. I can redo it - I think those two patches should
go through different trees, so the connection will be lost.

>
>>  /**************************************************************************
>>  ****>
>> + * Audio devices
>> +
>> ***************************************************************************
>> ***/ +static struct platform_device spitz_audio_device = {
>> +       .name   = "spitz-audio",
>> +       .id     = -1,
>> +};
>> +
>> +static inline void spitz_audio_init(void)
>> +{
>> +       platform_device_register(&spitz_audio_device);
>> +}+
>
> I realize that the file has more of these, but it would be better
> for a number of reasons to use 'platform_device_register_simple'
> instead of platform_device_register. statically defining platform
> devices (or any other device) is not recommended.

Ack. I did not want to use approach different from the rest of
spitz.c, but it looks it is time to change. Will send V3 later today,
after (hopefully)  receiving feedback from ASoC team.

-- 
With best wishes
Dmitry
