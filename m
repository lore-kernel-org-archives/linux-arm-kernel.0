From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Mon, 1 Jun 2015 19:34:00 -0700
Subject: [PATH] Fix ies/smt and register irq fail bug.
In-Reply-To: <1432719835-18939-1-git-send-email-hongzhou.yang@mediatek.com>
References: <1432719835-18939-1-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <1433212440.11936.3.camel@mussux00.eus.mediatek.inc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-05-27 at 02:43 -0700, Hongzhou Yang wrote:
> Hi Linus,
> After integration test, we found some bugs in the code you just merged.
> The first is that I missed ies/smt configuration for MSDC3.
> The seconed is the if judgement for "interrupt-controller" I added last
> time should on the contrary. So adding these two patches to fix them.
> Sorry about this. And please help to merge them, many thanks.
> 
> These patches include below changes:
> - Adding MSDC3 ies/smt support for mt8173.
> - Since mt6397 is no need to support interrupt controller,
> I judged "interrupt-controller" property to skip it last time,
> but the if judgement should on the contrary, this is a bug.
> so adding this patch to fix it. 
>  
> Hongzhou Yang (2):
>   pinctrl: mediatek: Fix bug of ies/smt setting for mt8173.
>   pinctrl: mediatek: Fix pinctrl register irq fail bug.
> 
>  drivers/pinctrl/mediatek/pinctrl-mt8173.c     |   10 +++++++++-
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    4 ++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> --
> 1.7.9.5
> 

Hi Linus,

Do you have any suggestion about these two patches?
Since we can't boot up device without these two patches, could
you please help to merge them?
Thank you very much.

Yours,
Hongzhou
