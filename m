From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 15 May 2015 15:39:43 +0800
Subject: [PATCH v2] clk: sirf: add CSR atlas7 clk and reset support
In-Reply-To: <20150514234131.GB31753@codeaurora.org>
References: <1428848090-14638-1-git-send-email-21cnbao@gmail.com>
 <20150514234131.GB31753@codeaurora.org>
Message-ID: <CAGsJ_4xJrCX5Bk=Ry1QhDvQO6jM8VhDvCmFG73HqxM6ZiXq0RA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-15 7:41 GMT+08:00 Stephen Boyd <sboyd@codeaurora.org>:
>
> On 04/12, Barry Song wrote:
> > From: Zhiwu Song <Zhiwu.Song@csr.com>
> >
> > the hardware node includes both clock and reset support, so it
> > is named as "car".
> > this patch implements Flexible clocks(mux, divider, gate), Selectable
> > clock(mux, divider, gate), root clock(gate),leaf clock(gate), others.
> > it also implements the reset controller functionality.
> >
> > Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
> > Signed-off-by: Barry Song <Baohua.Song@csr.com>
> > ---
>
> Sorry for late review. I wasn't Cc'ed on the patch.
>

Stephen, thanks for very careful and high-quality review. i realized i
missed you after i sent this one. sorry.

> > +static struct atlas7_reset_desc atlas7_reset_unit[] = {
> > +     {"PWM", 0x0244, 0, 0x0320, 0, &leaf0_gate_lock}, /*0-5*/
>
> Style nitpick: Please put some space around the braces here.
>
> > +     {"THCGUM", 0x0244, 3, 0x0320, 1, &leaf0_gate_lock},
> > +     {"CVD", 0x04A0, 0, 0x032C, 0, &leaf1_gate_lock},
> > +     {"TIMER", 0x04A0, 1, 0x032C, 1, &leaf1_gate_lock},
> > +     {"PULSEC", 0x04A0, 2, 0x032C, 2, &leaf1_gate_lock},
> [...]
> > +


all other issues have been cleared in v3 i sent minutes ago. for this
one, where do you want the spaces added?

-barry
