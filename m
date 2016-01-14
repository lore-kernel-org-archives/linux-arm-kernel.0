From: dianders@chromium.org (Doug Anderson)
Date: Thu, 14 Jan 2016 08:12:50 -0800
Subject: [PATCH v3 3/4] i2c: rk3x: new method to caculate i2c clocks
In-Reply-To: <1452774699-57455-4-git-send-email-david.wu@rock-chips.com>
References: <1452774699-57455-1-git-send-email-david.wu@rock-chips.com>
 <1452774699-57455-4-git-send-email-david.wu@rock-chips.com>
Message-ID: <CAD=FV=UXMzEQiKcMa7VjDx+arcbRo1e-0HPHBnG8GP7k6uFt1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 14, 2016 at 4:31 AM, David Wu <david.wu@rock-chips.com> wrote:
> There was an timing issue about "repeated start" time at the I2C
> controller of version0, controller appears to drop SDA at .875x (7/8)
> programmed clk high. The rule(.875x) isn't enough to meet tSU;STA
> requirements on 100k's Standard-mode. To resolve this issue,
> data_upd_st, start_setup_cnt and stop_setup_cnt configs for I2C
> timing information are added, new rules are designed to calculate
> the timing information at new v1.

I'm curious: does new hardware behave differently and that's why you
need v1?  ...or does old and new hardware behave the same and you're
just introducing v1 so you don't mess with how old boards are working?

>From the description it sounds as if the old code had problems as 100k too...

If the new controller is different, I'd probably reword like the
following (you'd have to re-wordwrap):

There was an timing issue about "repeated start" time at the I2C
controller of version0, controller appears to drop SDA at .875x (7/8)
programmed clk high. On version 1 of the controller, the rule(.875x)
isn't enough to meet tSU;STA
requirements on 100k's Standard-mode. To resolve this issue,
data_upd_st, start_setup_cnt and stop_setup_cnt configs for I2C
timing information are added, new rules are designed to calculate
the timing information at new v1.

-Doug
