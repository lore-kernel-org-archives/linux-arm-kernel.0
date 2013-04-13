From: olof@lixom.net (Olof Johansson)
Date: Sat, 13 Apr 2013 00:09:05 -0700
Subject: [GIT PULL] [for 3.10] pull request from armsoc/dt branch in pxa
 git tree
In-Reply-To: <CAN1soZxcmHMABTGi6FBtXysmY0TwWx7cdEvf1_ycHv2RtCLcpw@mail.gmail.com>
References: <CAN1soZxcmHMABTGi6FBtXysmY0TwWx7cdEvf1_ycHv2RtCLcpw@mail.gmail.com>
Message-ID: <20130413070905.GA28595@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Apr 13, 2013 at 12:13:14PM +0800, Haojian Zhuang wrote:
> Hi Arnd & Olof,
> 
> Please help to pull armsoc/dt branch from pxa git tree. These patches
> are used to enable hi3xxx SoC
> and they're depend on Rob's clock source patches.
> 
> Regards
> Haojian
> 
> The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:
> 
>   Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/hzhuang1/linux.git armsoc/dt

First of all, please try to move your repo somewhere else than github. We
really prefer to see signed tags when repos come from github or gitorious
or other similar sites. Maybe you can get a linaro git repo instead?

That's not a showstopper in this case though, since there's only a few
patches here and easy for us to review.

A couple of more important comments below.

> Haojian Zhuang (6):
>       devtree: add binding documentation for sp804
>       ARM: debug: support debug ll on hisilicon soc
>       clk: hi3xxx: add clock support

I didn't see an Acked-by from Mike Turquette on this one. Since this driver is
an addition to his subsystem, I would like to see one. It could even go through
his tree since this is all new platform code.

Not only that, but when I went searching for email to find reviews of this
patch, I see that Arnd had a round of comments including a request to move
hs_init_clocks() that, according to the email, was addressed but this patch
does not seem to have moved.

>       ARM: hi3xxx: add board support with device tree
>       ARM: hi3xxx: enable hi4511 with device tree
>       ARM: config: append arch hi3xxx into multi defconfig

Given the comments above, and the currently late time for 3.10, I think this
will be better held off for more review and a merge for 3.11. Please get the
above taken care of and resubmit to us as soon as 3.10-rc1 is out and we'll
stage it for 3.11. The code does look nice and clean and looks to be in good
shape, so there should be no problem to get it in for 3.10.


-Olof
