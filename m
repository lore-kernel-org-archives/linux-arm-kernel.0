From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 23 Oct 2012 19:20:26 +0200
Subject: [PATCH v3 1/4] net/macb: fix truncate warnings
In-Reply-To: <20614.34540.248020.471598@ipc1.ka-ro>
References: <1350931534-8416-1-git-send-email-manabian@gmail.com>
 <1350931534-8416-2-git-send-email-manabian@gmail.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B705B@saturn3.aculab.com>
 <20121023.044829.1915412359769438159.davem@davemloft.net>
 <20614.34540.248020.471598@ipc1.ka-ro>
Message-ID: <CAGhQ9VxTUSdctawaXFdaRCKq_+q2H8mhPTwwMka0nLpS7TAY9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 2:00 PM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
> Hi,
>
> David Miller writes:
>> From: "David Laight" <David.Laight@ACULAB.COM>
>> Date: Tue, 23 Oct 2012 09:21:11 +0100
>>
>> >> When building macb on x86_64 the following warnings show up:
>> >>   drivers/net/ethernet/cadence/macb.c: In function macb_interrupt:
>> >>   drivers/net/ethernet/cadence/macb.c:556:4: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>> > ...
>> >> -                  macb_writel(bp, IDR, ~0UL);
>> >> +                  macb_writel(bp, IDR, -1);
>> >
>> > Seems wrong to fix an error with an unsigned value
>> > by using -1.
>>
>> -1 is equally an unsigned value of all 1's and completely legitimate.
>> The correction being made here is one of size not signedness.
>>
> You could use '~0' (without the 'UL').

The reason for choosing '-1', as noted in patch description, is that
it already appears in a couple of other places in the driver. So I
though it would nice to be consistent.

regards
Joachim Eastwood
