From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 20 Oct 2014 08:01:27 -0700
Subject: [PATCH v1] tty: serial: 8250_core: restore the LCR register in
 set_sleep
In-Reply-To: <1413549558-24227-1-git-send-email-ssreedharan@mvista.com>
 (Sudhir Sreedharan's message of "Fri, 17 Oct 2014 18:09:18 +0530")
References: <CAJJ77WsAi5jmnDxY45ipu3a94D6+yoHJNHgExhFsVoirV3NoyQ@mail.gmail.com>
 <1413549558-24227-1-git-send-email-ssreedharan@mvista.com>
Message-ID: <7hppdmg4zc.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sudhir Sreedharan <ssreedharan@mvista.com> writes:

> In ST16650V2 based serial uarts, while initalizing the PM state,
> LCR registers are being initialized to 0 in serial8250_set_sleep().
> If console port is already initialized and being used, this will
> throws garbage in the console.
>
> Signed-off-by: Sudhir Sreedharan <ssreedharan@mvista.com>

Tested-by: Kevin Hilman <khilman@linaro.org>

I boot tested this on a bunch of ARM boards and don't see any
more failures/regressions.

Kevin
