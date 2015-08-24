From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Mon, 24 Aug 2015 22:22:20 +0800
Subject: [PATCH v2 1/5] clocksource: mediatek: do not enable GPT_CLK_EVT
 when setup
In-Reply-To: <55DACCEF.8040004@linaro.org>
References: <CAGS+omD8k_Cfxv3bYyjmjtLbiavo-WmJPn0Z-CBhN_nnv65Tag@mail.gmail.com>
 <1437552878-3684-1-git-send-email-yingjoe.chen@mediatek.com>
 <55CC56C4.8080201@linaro.org> <1439820602.3414.12.camel@mtksdaap41>
 <55D5E40A.6080904@linaro.org> <1440167950.20169.29.camel@mtksdaap41>
 <55DACCEF.8040004@linaro.org>
Message-ID: <1440426140.17418.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-08-24 at 09:51 +0200, Daniel Lezcano wrote:
> On 08/21/2015 04:39 PM, Yingjoe Chen wrote:
> 
> [ ... ]
> 
> >>    - Does the spurious interrupt occurs *every* time ? at each boot ?
> >
> > Yes. If you applied this series to enable mtk timer without this fix on
> > mt8173 or mt8135 you can reproduce it. It occurs for every boot.
> >
> > It crash before uart driver is ready, so you'll have to use earlycon to
> > see the crash log.
> 
> Can you give me the earlycon params ?

Hi Daniel,

You probably already figure this out. anyway I'm using this to enable
earlycon:

Add 'earlycon' in bootargs, and in device tree chosen part, add
"linux,stdout-path=&uart0;"

Joe.C
