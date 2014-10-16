From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 16 Oct 2014 00:21:17 -0700
Subject: [PATCH] tty: serial: 8250_core: restore the LCR register in
 set_sleep
In-Reply-To: <1413355395-5871-1-git-send-email-ssreedharan@mvista.com> (Sudhir
 Sreedharan's message of "Wed, 15 Oct 2014 12:13:15 +0530")
References: <54369F77.5000906@hurleysoftware.com>
 <1413355395-5871-1-git-send-email-ssreedharan@mvista.com>
Message-ID: <7hwq80h442.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sudhir Sreedharan <ssreedharan@mvista.com> writes:

> In ST16650V2 based serial uarts, while initalizing the PM state,
> LCR registers are being initialized to 0 in serial8250_set_sleep().
> If console port is already initialized and being used, this will
> throws garbage in the console.
>
> Signed-off-by: Sudhir Sreedharan <ssreedharan@mvista.com>

Since this caused regressions in -next last time, could you describe how
this was tested, and on what platforms?

Thanks,

Kevin
