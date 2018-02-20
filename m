From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 20 Feb 2018 13:39:25 +0100
Subject: [PATCH 9/9] serial: xuartps: Fix out-of-bounds access through DT
 alias
In-Reply-To: <CAMuHMdWe9XkoDKkyfu1pOG0oS0_Tdx1w=OOk05EvTr_dK=tp7Q@mail.gmail.com>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
 <1519119624-1268-10-git-send-email-geert+renesas@glider.be>
 <c16b025a-a302-8515-2697-f7eca478e939@xilinx.com>
 <CAMuHMdUOKMM5mSrnnrxCi0gX_TbjYkj7vwn11b2D5p7XigM+Ag@mail.gmail.com>
 <6cabf7c6-302e-efa9-8f4d-25fd35ecddad@xilinx.com>
 <CAMuHMdWe9XkoDKkyfu1pOG0oS0_Tdx1w=OOk05EvTr_dK=tp7Q@mail.gmail.com>
Message-ID: <aa9792b6-14c2-0bf9-712d-f537050ea9df@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.2.2018 13:27, Geert Uytterhoeven wrote:
> Hi Michal,
> 
> On Tue, Feb 20, 2018 at 12:27 PM, Michal Simek <michal.simek@xilinx.com> wrote:
>> On 20.2.2018 11:38, Geert Uytterhoeven wrote:
>>> On Tue, Feb 20, 2018 at 11:22 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>>>> On 20.2.2018 10:40, Geert Uytterhoeven wrote:
>>>>> The cdns_uart_port[] array is indexed using a value derived from the
>>>>> "serialN" alias in DT, which may lead to an out-of-bounds access.
>>>>>
>>>>> Fix this by adding a range check.
> 
>> I have checked 4 patches I have sent in past which didn't reach mainline
>> (probably because of RFC)
>> Take a look at
>> https://www.spinics.net/lists/linux-serial/msg27106.html
>>
>> I have removed cdns_uart_port array completely there.
> 
> Nice! I'd love to get rid of fixed arrays in serial...
> 
> However, IMHO it's still worthwhile to fix the out-of-bounds access first,
> as that fix can be backported to stable kernels easily.

I agree with you. Not a problem with your patch and for me it won't be
problem to rebase.

I would love to get rid of CDNS_UART_NR_PORTS but unfortunately this is
passed to core via .nr.

Thanks,
Michal
