From: dianders@chromium.org (Doug Anderson)
Date: Thu, 28 Apr 2016 14:28:34 -0700
Subject: [PATCH v6] i2c: rk3x: add i2c support for rk3399 soc
In-Reply-To: <572212AE.5060904@rock-chips.com>
References: <1458147438-62387-3-git-send-email-david.wu@rock-chips.com>
 <1461074137-23899-1-git-send-email-david.wu@rock-chips.com>
 <CAD=FV=U7Vsnh8RZjZ=an0Sfb+soS=+v1icoH=kL1huCR_9TTgA@mail.gmail.com>
 <572212AE.5060904@rock-chips.com>
Message-ID: <CAD=FV=WxoZArMyhAPEmhG4FVHqhd-snMt59_Hk=BVsP2hZBxpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Apr 28, 2016 at 6:39 AM, David.Wu <david.wu@rock-chips.com> wrote:
> +enum rk3x_i2c_bus_speed {
> +       I2C_FS_SPD,
> +       I2C_HS_SPD
> +};
> +
> +struct rk3x_i2c;
>
> Why do you need this forward definition?  Seems like it's not
> necessary.  Remove?
>
>
> I think we need a Master_Code state to seperate from other state.

I meant remove the line above the contains just:

  struct rk3x_i2c;

...I don't believe it's needed.  You only need a forward declaration
like that if you refer to the structure before it's defined.


-Doug
