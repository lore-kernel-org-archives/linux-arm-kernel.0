From: liu.y.victor@gmail.com (Liu Ying)
Date: Mon, 31 Dec 2012 14:45:15 +0800
Subject: [PATCH 1/3] Input: imx_keypad - Add device tree support
In-Reply-To: <20121231005527.GC31816@S2101-09.ap.freescale.net>
References: <1356872946-2810-1-git-send-email-Ying.Liu@freescale.com>
 <20121230232852.GB13899@core.coreip.homeip.net>
 <20121231005527.GC31816@S2101-09.ap.freescale.net>
Message-ID: <CA+8Hj81gf=Z2TGj+s1ypBcuS07MngVFb27v4=sdP4tXk40z9Aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Shawn,

I plan to remove pinctrl code in the coming next version driver patch
first. Do you think this is ok or not?

2012/12/31 Shawn Guo <shawn.guo@linaro.org>:
> Hi Liu,
>
> On Sun, Dec 30, 2012 at 03:28:52PM -0800, Dmitry Torokhov wrote:
>> > @@ -473,6 +534,10 @@ static int imx_keypad_probe(struct platform_device *pdev)
>> >             goto failed_free_priv;
>> >     }
>> >
>> > +   pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
>> > +   if (IS_ERR(pinctrl))
>> > +           dev_warn(&pdev->dev, "failed to get default pinctrl\n");
>> > +
>>
>> No, please let core do this for you. Linus has a patch doing just that.
>>
> FYI.  Dmitry is talking about the patch[1] below.  Unfortunately, you
> will not be able to base your patch on that until v3.9-rc1.
>
> Shawn
>
> [1] http://thread.gmane.org/gmane.linux.kernel/1409263
>



-- 
Liu Ying
