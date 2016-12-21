From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Wed, 21 Dec 2016 21:20:41 +0100
Subject: [PATCH 2/2] mfd: mc13xxx: Pass the IRQF_TRIGGER_HIGH flag.
In-Reply-To: <CAOMZO5CmEL_gW6pXM3XDY+VR9q2MmqV5Q905PJjf0-W4jUBFbg@mail.gmail.com>
References: <1482182934-18559-1-git-send-email-lilja.magnus@gmail.com>
 <1482182934-18559-3-git-send-email-lilja.magnus@gmail.com>
 <CAOMZO5CmEL_gW6pXM3XDY+VR9q2MmqV5Q905PJjf0-W4jUBFbg@mail.gmail.com>
Message-ID: <CAM=E1R45xKm3y889S1ck=A=zYBkvB+QVdpPB9-szBTRM87RzyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 21 December 2016 at 21:10, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Magnus,
>
> On Mon, Dec 19, 2016 at 7:28 PM, Magnus Lilja <lilja.magnus@gmail.com> wrote:
>> All supported mc13xxx devices have active high interrupt outputs. Make sure
>> to configure the interrupt as active high by passing the IRQF_TRIGGER_HIGH
>> flag. This is required at least on the i.MX31 PDK board.
>>
>> Signed-off-by: Magnus Lilja <lilja.magnus@gmail.com>
>
> What is the commit that caused the breakage in the driver? Please
> specify in the commit log, add a Fixes tag and Cc: stable like
> mentioned on patch 1/2.

Will add that info and cc: stable.

And while investigating which commit that caused this I noticed that
the prior to that commit IRQF_TRIGGER_HIGH was always passed without
possibility to change so I wonder if it really is necessary to support
any inverters in the IRQ line..

Thanks, Magnus
