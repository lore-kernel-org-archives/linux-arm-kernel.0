From: ssreedharan@mvista.com (Sudhir Sreedharan)
Date: Tue, 21 Oct 2014 12:15:24 +0530
Subject: [PATCH v1] tty: serial: 8250_core: restore the LCR register in
 set_sleep
In-Reply-To: <7hppdmg4zc.fsf@deeprootsystems.com>
References: <CAJJ77WsAi5jmnDxY45ipu3a94D6+yoHJNHgExhFsVoirV3NoyQ@mail.gmail.com>
 <1413549558-24227-1-git-send-email-ssreedharan@mvista.com>
 <7hppdmg4zc.fsf@deeprootsystems.com>
Message-ID: <CAJJ77WthYSoA745Nbcqf_dVfN+ydO1LpCVTRDS6xaZMm0zLSmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 20, 2014 at 8:31 PM, Kevin Hilman <khilman@kernel.org> wrote:
> Sudhir Sreedharan <ssreedharan@mvista.com> writes:
>
>> In ST16650V2 based serial uarts, while initalizing the PM state,
>> LCR registers are being initialized to 0 in serial8250_set_sleep().
>> If console port is already initialized and being used, this will
>> throws garbage in the console.
>>
>> Signed-off-by: Sudhir Sreedharan <ssreedharan@mvista.com>
>
> Tested-by: Kevin Hilman <khilman@linaro.org>
>
> I boot tested this on a bunch of ARM boards and don't see any
> more failures/regressions.

Thanks Kevin
