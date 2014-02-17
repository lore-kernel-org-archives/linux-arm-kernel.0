From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 17 Feb 2014 17:02:27 +0900
Subject: [PATCH 2/5] ARM: shmobile: r8a7791: add i2c master nodes to dtsi
In-Reply-To: <20140217075410.GA2633@katana>
References: <1392543658-5030-1-git-send-email-wsa@the-dreams.de>
 <1392543658-5030-3-git-send-email-wsa@the-dreams.de>
 <20140217075410.GA2633@katana>
Message-ID: <CANqRtoSDxQfSw5PJB6-UcL-UuMySBkoCqfC+1H=o-EBA18ouLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Mon, Feb 17, 2014 at 4:54 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Sun, Feb 16, 2014 at 10:40:55AM +0100, Wolfram Sang wrote:
>> From: Wolfram Sang <wsa@sang-engineering.com>
>>
>> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
>
> From your other mail:
>
> "[2/5] needs to be reworked to exclude the r8a7790 compatible string."
>
>> +             compatible = "renesas,i2c-r8a7791", "renesas,i2c-r8a7790";
>
> Why is that? From my knowledge, you start with the exact compatible
> property and hardware compatible entries may follow.

I think this boils down to if they really are compatible or not. If
for instance a 16550 port would be compatible with 8250 on a hardware
level then using them in the order of "16550", "8250" makes sense. In
this case the r8a7791 i2c is not really strictly based on r8a7790 i2c,
it is just that r8a7790 has support in the driver. So it's a short cut
instead of actual hardware compatibility.

So far we've dealt with this by updating the driver and only relying
on the actual SoC name as suffix.

I'm sure there are tons of opinions. =)

Cheers,

/ magnus
