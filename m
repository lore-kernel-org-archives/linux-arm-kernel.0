From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 14 Jan 2014 19:21:34 +0000
Subject: [PATCH] ARM: OMAP4: sleep: byteswap data for big-endian
In-Reply-To: <CAGo_u6oKpRFnPAWaqr9NTNAJB+m56jiDgBUgvsiZpaQ-3SF2kw@mail.gmail.com>
References: <1389625399-24087-1-git-send-email-taras.kondratiuk@linaro.org>
 <52D404DE.2020806@ti.com>
 <CAArO44samX_uMeC93w4DBbC+yskEmrvVt_i-5VV_seatM56ypw@mail.gmail.com>
 <52D55CE5.1060902@ti.com>
 <CAA3XUr2cnF_rxMYvZfjBx22Sa8YE45o_qUU8GNoerQwhWqxhNQ@mail.gmail.com>
 <CAGo_u6oKpRFnPAWaqr9NTNAJB+m56jiDgBUgvsiZpaQ-3SF2kw@mail.gmail.com>
Message-ID: <52D58E3E.2010408@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/01/14 17:56, Nishanth Menon wrote:
> On Tue, Jan 14, 2014 at 11:35 AM, Victor Kamensky
> <victor.kamensky@linaro.org> wrote:
>>
>> When BE kernel is built Makefile does take of compiling code in BE
>> mode. I.e all proper flags like -mbig-endian and -Wl,--be8 will be set.
>
> Agreed, and I assume you cannot instead switch to LE mode when
> entering assembly assuming LE?

You could make it so that individual pieces of code could swap
back to big-endian, however that would introduce the possibility
of bugs if the code used a pointer to memory passed in, or refers
to a piece of data in another part of the code which is built in
big endian.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
