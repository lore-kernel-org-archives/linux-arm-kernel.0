From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 10 Dec 2013 10:30:06 +0100
Subject: [TRIVIAL PATCH 1/2] regulator: s5m8767: Define symbol for buck
 control mask
In-Reply-To: <CAK9yfHwz0Swi=vBu_Wynsr5ZDMDfwnFxS1p2Sc6ofabiotEa1w@mail.gmail.com>
References: <1386666583-3280-1-git-send-email-k.kozlowski@samsung.com>
 <CAK9yfHwz0Swi=vBu_Wynsr5ZDMDfwnFxS1p2Sc6ofabiotEa1w@mail.gmail.com>
Message-ID: <1386667806.4008.2.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-12-10 at 14:48 +0530, Sachin Kamat wrote:
> Hi Krzysztof,
> 
> On 10 December 2013 14:39, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> 
> >  static int s5m8767_reg_disable(struct regulator_dev *rdev)
> >  {
> >         struct s5m8767_info *s5m8767 = rdev_get_drvdata(rdev);
> >         int ret, reg;
> > -       int  mask = 0xc0, enable_ctrl;
> > +       int mask = S5M8767_ENCTRL_MASK, enable_ctrl;
> 
> Couldn't we get rid of this mask variable here too?
> 
> Otherwise the patch looks good to me.

Not in this patch because it leads to warning:

drivers/regulator/s5m8767.c: In function ?s5m8767_reg_disable?:
drivers/regulator/s5m8767.c:259:2: warning: large integer implicitly truncated to unsigned type [-Woverflow]
drivers/regulator/s5m8767.c:253:6: warning: unused variable ?mask? [-Wunused-variable]

I plan to remove the sec_reg_*() helpers because they are confusing
and error-prone (mixing u8 and unsigned int). After using standard regmap
API this "mask" variable could be removed.

Best regards,
Krzysztof
