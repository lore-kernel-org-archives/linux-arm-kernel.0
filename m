From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 17 Feb 2012 21:43:44 -0800
Subject: [PATCH] mtd: fix the wrong check condition
In-Reply-To: <4F3E14BD.10705@freebox.fr>
References: <1329302008-10228-1-git-send-email-b32955@freescale.com>
 <4F3C712A.5060406@gmail.com> <4F3C7433.5030306@freescale.com>
 <4F3CE2D4.4070506@freebox.fr>
 <CAMiH66GRD97y4mK-9TCRqsQkTOoqqwVp4gREv3=0qiX_vrueGA@mail.gmail.com>
 <4F3E14BD.10705@freebox.fr>
Message-ID: <CAN8TOE9q3OgKFTwQ4=mSyCJ7WsCHz2yC0hOYq_sGBrx4joB7Cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2012 at 12:50 AM, Florian Fainelli <ffainelli@freebox.fr> wrote:
> Le 02/17/12 04:07, Huang Shijie a ?crit :
>> Sorry. I did not check the log carefully.
>>
>> the Hynix nand does _not_ pass the CRC check, but it passed the "ONFI"
>> string check.
>
> This is exactly what I saw too with a different Hynix chip, it replied ONFI,
> but the CRC check failed.

So your root detection issue is actually that this Hynix chip is
neither ONFI-compliant nor does it have a good ID decoding scheme,
hence the need for the ID table patch (separate; I'll review it soon).

>>
>> The log "ONFI flash detected" made me misunderstood.
>
> Yes I agree, the log is there too soon, thanks for your patch.

I agree as well. I'll ACK the other patch.

Thanks,
Brian
