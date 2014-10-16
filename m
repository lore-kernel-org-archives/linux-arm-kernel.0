From: ssreedharan@mvista.com (Sudhir Sreedharan)
Date: Thu, 16 Oct 2014 15:45:20 +0530
Subject: [PATCH] tty: serial: 8250_core: restore the LCR register in
 set_sleep
In-Reply-To: <7hwq80h442.fsf@deeprootsystems.com>
References: <54369F77.5000906@hurleysoftware.com>
 <1413355395-5871-1-git-send-email-ssreedharan@mvista.com>
 <7hwq80h442.fsf@deeprootsystems.com>
Message-ID: <CAJJ77Wuqu1NWjQQSS+BhPB74YA+4N5zjWot_KZFWtGLUu7+RYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Thu, Oct 16, 2014 at 12:51 PM, Kevin Hilman <khilman@kernel.org> wrote:
> Sudhir Sreedharan <ssreedharan@mvista.com> writes:
>
>> In ST16650V2 based serial uarts, while initalizing the PM state,
>> LCR registers are being initialized to 0 in serial8250_set_sleep().
>> If console port is already initialized and being used, this will
>> throws garbage in the console.
>>
>> Signed-off-by: Sudhir Sreedharan <ssreedharan@mvista.com>
>
> Since this caused regressions in -next last time, could you describe how
> this was tested, and on what platforms?

I have tested this on arm64 board((U6_16550A)),PowerPC P5040
board(16550A)), x86-64 (haswell(ST16650V2),  Rangeley(16550A)) board.
This patch will modify only for the 8250 based serial devices.

Test Case : Booting Multiple times, suspend-resume.

Thanks,
Sudhir

>
> Thanks,
>
> Kevin
