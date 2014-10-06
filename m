From: ssreedharan@mvista.com (Sudhir Sreedharan)
Date: Mon, 6 Oct 2014 14:57:37 +0530
Subject: [PATCH] serial/core: Initialize the console pm state
In-Reply-To: <CAMAWPa9R5HtGKkV=Ya-ekynY5maespZ0Q6BjwJcX3LN3857ZjQ@mail.gmail.com>
References: <1411367422-2095-1-git-send-email-ssreedharan@mvista.com>
 <CAMAWPa9R5HtGKkV=Ya-ekynY5maespZ0Q6BjwJcX3LN3857ZjQ@mail.gmail.com>
Message-ID: <CAJJ77WvDaM2MmC_r9Wop68++L0FfaRmq6oiXTp+GdqcaKKwSBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Wed, Oct 1, 2014 at 10:57 PM, Kevin Hilman <khilman@kernel.org> wrote:
> On Sun, Sep 21, 2014 at 11:30 PM, Sudhir Sreedharan
> <ssreedharan@mvista.com> wrote:
>> For console devices having UART_CAP_SLEEP capability, the uart_pm_state has
>> to be initialized to UART_PM_STATE_ON. Otherwise the LCR regiser values
>> are reinitialized when uart_change_pm is called from uart_configure_port.
>>
>> Signed-off-by: Sudhir Sreedharan <ssreedharan@mvista.com>
>
> Multiple boot failures on ARM[1] were bisected down to this patch.
>
> How was this patch tested, and on which platforms?



This patch was tested on x86-64(haswell) board, which uses ST16650V2
uart(which has UART_CAP_SLEEP).
While serial driver gets initialized, console port LCR register is
getting reinitalized to 0.
Then boot logs will be seen as garbage characters.

I will re-check why this failed on the boards/archs you mentioned.

Thanks,
Sudhir
