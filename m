From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 24 Nov 2011 08:55:16 +0800
Subject: [GIT PULL] imx6q: fix for v3.2-rc
In-Reply-To: <201111232115.42689.arnd@arndb.de>
References: <20111117131901.GL14656@S2100-06.ap.freescale.net>
 <201111232115.42689.arnd@arndb.de>
Message-ID: <CAH8gqwUnfnhYe8AZuceQygb_rybEmeFzfRk0ZGTNQM-ZXCT2pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 November 2011 05:15, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 17 November 2011, Shawn Guo wrote:
>> Please pull the imx6q fix below for v3.2-rc.
>>
>> Regards,
>> Shawn
>>
>> The following changes since commit cfcfc9eca2bcbd26a8e206baeb005b055dbf8e37:
>>
>> ? Linux 3.2-rc2 (2011-11-15 15:02:59 -0200)
>>
>> are available in the git repository at:
>> ? git://git.linaro.org/people/shawnguo/linux-2.6.git imx6q/fixes
>>
>> Richard Zhao (1):
>> ? ? ? ARM: imx6q: move clock register map to machine_desc.map_io
>>
>
> Hi Shawn and Richard,
>
> I've applied the patch to the 'fixes' branch since it seems correct,
> but please explain to me what bug this actually fixes. The changelog
> does not actually mention why this is broken or why the fix is needed
> in 3.2.
The patch fixes bug: clock register map corrupt after system boot up.
It's because the map was done in machine_desc.timer.init. It's too late to
call iotable_init. memblock_alloc can not be used.

You can also find the discuss mail thread in
http://comments.gmane.org/gmane.linux.ports.arm.kernel/140544

Sorry for insufficient commit log.

Thanks
Richard
>
> ? ? ? ?Arnd
>
