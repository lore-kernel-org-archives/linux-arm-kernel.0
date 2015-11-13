From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 13 Nov 2015 09:17:18 -0700
Subject: [PATCH V3 02/26] coresight: etm3x: moving sysFS entries to
 dedicated file
In-Reply-To: <4446604.iDni9pkfpc@wuerfel>
References: <1447280296-19147-1-git-send-email-mathieu.poirier@linaro.org>
 <1447280296-19147-3-git-send-email-mathieu.poirier@linaro.org>
 <4446604.iDni9pkfpc@wuerfel>
Message-ID: <CANLsYkyEHEUu6TAgL4Av=Ucvs3U-K3+3J9mHN8=k4LXGLMGGcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 November 2015 at 15:30, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 11 November 2015 15:17:52 Mathieu Poirier wrote:
>> SysFS entries are big enough to justify their own file.
>> As such moving all sysFS related declarations to a dedicated
>> location.
>>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> ---
>>  drivers/hwtracing/coresight/Makefile               |    3 +-
>>  drivers/hwtracing/coresight/coresight-etm.h        |    4 +
>>  .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 1218 +++++++++++++++++++
>>  drivers/hwtracing/coresight/coresight-etm3x.c      | 1234 +-------------------
>>
>
> You are adding a lot of interfaces here, make sure that each one is documented
> in Documentation/ABI/.

Everything is documented in
Documentation/ABI/testing/sysfs-bus-coresight-devices-etm3x.

>
> Your patch series doesn't add anything here, are you just using an existing
> ABI?

That is correct.

>
>         Arnd
