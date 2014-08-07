From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 7 Aug 2014 15:14:44 +0200
Subject: [PATCH v4 2/2] pwm: rockchip: Added to support for RK3288 SoC
In-Reply-To: <53E3795E.4080607@rock-chips.com>
References: <1406197295-10604-1-git-send-email-caesar.wang@rock-chips.com>
 <1406197295-10604-3-git-send-email-caesar.wang@rock-chips.com>
 <20140807061842.GB17340@ulmo> <53E3795E.4080607@rock-chips.com>
Message-ID: <20140807131443.GA1540@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 07, 2014 at 09:04:30PM +0800, caesar wrote:
[...]
> As you say, I will rewrite the about if it's really need  do so it.
> For example:
> 
> static const struct rockchip_pwm_data pwm_data_v1 = {
>     .regs = {
>                 .duty = 0x04,
>                 .period = 0x08,
>                 .cntr = 0x00,
>                 .ctrl = 0x0c,
>     },
>     .prescaler = 2,
>     .set_enable = rockchip_pwm_set_enable_v1,
> };
> 
> static const struct rockchip_pwm_data pwm_data_v2 = {
>     .regs = {
>                 .duty = 0x08,
>                 .period = 0x04,
>                 .cntr = 0x00,
>                 .ctrl = 0x0c,
>     },
>     .prescaler = 1,
>     .set_enable = rockchip_pwm_set_enable_v2,
> };
> 
> static const struct rockchip_pwm_data pwm_data_vop = {
>     .regs = {
>                 .duty = 0x08,
>                 .period = 0x04,
>                 .cntr = 0x0c,
>                 .ctrl = 0x00,
>     },
>     .prescaler = 1,
>     .set_enable = rockchip_pwm_set_enable_v2,
> };
> 
> Is that right?

Yes.

> >>+	.set_enable = rockchip_pwm_set_enable_v2,
> >>+};
> >No need for the double indirection.
> 
> Sorry, I think is need if you mean a double indirection for ".set_enable".

The "double indirection" was regarding the symbolic names for registers,
not the .set_enable(). Sorry.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140807/d1950544/attachment.sig>
