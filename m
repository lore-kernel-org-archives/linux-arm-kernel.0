From: jason77.wang@gmail.com (Hui Wang)
Date: Thu, 21 Jun 2012 09:08:24 +0800
Subject: [PATCH v2] pinctrl: pinctrl-imx: fix map setting problem if
 NO_PAD_CTL is set
In-Reply-To: <CACRpkdYXuRC0d1NcUEfRZbfgis+9xVyzsEFpGmS21xYBmyrAPg@mail.gmail.com>
References: <1340187227-25343-1-git-send-email-jason77.wang@gmail.com>
 <CACRpkdYXuRC0d1NcUEfRZbfgis+9xVyzsEFpGmS21xYBmyrAPg@mail.gmail.com>
Message-ID: <4FE27408.8030703@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> On Wed, Jun 20, 2012 at 12:13 PM, Hui Wang <jason77.wang@gmail.com> wrote:
>
>   
>> new_map is allocated according to map_num instead of grp->npins,
>> if a pin or some pins of a group has NO_PAD_CTL property, the map_num
>> and the grp->npin are different definitely.
>>
>> When we set mapping information to the new_map[], we should skip those
>> pins with NO_PAD_CTL from index, otherwise it is possible the driver
>> will aceesss to a unallocated region.
>>
>> Cc: Dong Aisheng <dong.aisheng@linaro.org>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
>> ---
>> In the v2, according to dong.aisheng's suggestion, change to use j as index.
>>     
>
> OK applied this v2 version. Is this a serious bug fix that is causing
> regressions right now and needs to go into the -rc:s for v3.5 or can it wait
> for v3.6?
>   
It is a bug fix, but currently no {board}.dts can trigger this bug, so 
it  can wait for v3.6.

Regards,
Hui.
> Thanks,
> Linus Walleij
>
>   
