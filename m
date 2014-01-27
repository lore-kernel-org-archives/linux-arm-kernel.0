From: jsarha@ti.com (Jyri Sarha)
Date: Mon, 27 Jan 2014 11:48:55 +0200
Subject: [PATCH 1/3] mmc: add support for power-on sequencing through
 DT
In-Reply-To: <CAGb2v64RbXZS_5nvXf9_t=Q=+zrBa=eF-f-xcZTxaMLYSQkNrw@mail.gmail.com>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <1390190215-22700-2-git-send-email-olof@lixom.net>
 <20140120164859.GF15937@n2100.arm.linux.org.uk>
 <CAOMZO5DdTP0gimwdsBUZK3wXrnUd2FN3w-FszLQkvCwM8gvPpg@mail.gmail.com>
 <52E61C28.1020207@ti.com>
 <CAGb2v64RbXZS_5nvXf9_t=Q=+zrBa=eF-f-xcZTxaMLYSQkNrw@mail.gmail.com>
Message-ID: <52E62B87.8010103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2014 10:54 AM, Chen-Yu Tsai wrote:
> Hi,
>
> On Mon, Jan 27, 2014 at 4:43 PM, Jyri Sarha <jsarha@ti.com> wrote:
>> On 01/24/2014 07:35 PM, Fabio Estevam wrote:
...
>> I have not received too much feedback to my patch yet. CCF is a bit new
>> territory to me, but I think having a separate stackable clk-gpio would be
>> more flexible than having the gpio property implemented in clk-fixed-rate.
>
> Not sure where stacking external clocks would be used, but sounds like a
> fixed factor clock? Maybe you should add DT support to that if that's what
> you need or have.
>

Ah, but then there is also the problem of having to change 
clk_register_fixed_rate() in the CCF api, which is called from all over 
the place.

Of course I could add a new clk_register_fixed_rate_gpio(), but still it 
does not look to me like the way to go.

Cheers,
Jyri
