From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 12 Feb 2015 17:08:34 -0200
Subject: [PATCH V2 RESEND] clk: mxs: Fix invalid 32-bit access to frac
 registers
In-Reply-To: <1378197784.470306.1423767540298.JavaMail.open-xchange@oxbaltgw01.schlund.de>
References: <1422645610-3052-1-git-send-email-stefan.wahren@i2se.com>
 <CAOMZO5DOgdUYsRUU3TXgJY+JhjF8xC_XY8EJFcrM7NHiPmSMOQ@mail.gmail.com>
 <54DA020C.6030703@i2se.com>
 <CAOMZO5DGCP1p1vetwWHpSbe2qywA8DhWRRq22egMDFSw11uq4w@mail.gmail.com>
 <54DA0DE7.5050708@i2se.com>
 <CAOMZO5AtFOThRjcAgMVbrbkcrJbehouSxoH03VUGJrRdWXnS_Q@mail.gmail.com>
 <462270270.419156.1423603473431.JavaMail.open-xchange@oxbaltgw02.schlund.de>
 <CAOMZO5B4mxP6RBkbsbj=wC6bZJgtreoo5S_NhYuki6kW=Y=QFw@mail.gmail.com>
 <1705379122.406018.1423686677196.JavaMail.open-xchange@oxbaltgw01.schlund.de>
 <CAOMZO5ChJiHiUBhrRf_qqi7gTLvPp08fsfRBK+GVzvrqimKinw@mail.gmail.com>
 <1378197784.470306.1423767540298.JavaMail.open-xchange@oxbaltgw01.schlund.de>
Message-ID: <CAOMZO5DJ82Yyq4Ch_kKR01-yYhjn53As7ZBt91Dd5sna9Z+wXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Thu, Feb 12, 2015 at 4:59 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Hi Fabio,
>
>> Fabio Estevam <festevam@gmail.com> hat am 11. Februar 2015 um 22:10
>> geschrieben:
>>
>>
>> On Wed, Feb 11, 2015 at 6:31 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>>
>> >> I always get 0x5e5b5513 with or without your patch.
>> >
>> > very strange. Do you have any idea why IO1_STABLE is permanent low?
>>
>> On my case it is always 1.
>
> i expected the same behavior on my hardware.
>
> Do you use u-boot as bootloader?

Yes, I do.

>>
>> > Can you confirm the behavior according to your flash issue?
>>
>> In my tests IO1_STABLE stays the same.
>
> This wasn't the intension of my second question. I wanted to know about the
> state of the SPI NOR flash detection process.
>
> Does it sucessed if you apply the patch, but revert the changes in
> clk_ref_set_rate() from clk-ref.c?

I don't have my mx28evk setup available at the moment, but when I
applied your patch and reverted all the changes in clk-ref.c, then the
SPI flash detection works.

I haven't tested to only reverting the changes inside
clk_ref_set_rate(), but I can do it tomorrow.

Regards,

Fabio Estevam
