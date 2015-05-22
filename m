From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 22 May 2015 14:03:10 +0800
Subject: [PATCH 4/5] clk: mediatek: Add subsystem clocks of MT8173
In-Reply-To: <CAGS+omBgbj=Hx57GhxsQiuTR8Cx=hu0j4ptUh3GkScA81r42=A@mail.gmail.com>
References: <1432192376-6712-1-git-send-email-jamesjj.liao@mediatek.com>
 <1432192376-6712-5-git-send-email-jamesjj.liao@mediatek.com>
 <CAGS+omBgbj=Hx57GhxsQiuTR8Cx=hu0j4ptUh3GkScA81r42=A@mail.gmail.com>
Message-ID: <1432274590.14396.40.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Fri, 2015-05-22 at 12:22 +0800, Daniel Kurtz wrote:
> On Thu, May 21, 2015 at 3:12 PM, James Liao <jamesjj.liao@mediatek.com> wrote:
> > Most multimedia subsystem clocks will be accessed by multiple
> > drivers, so it's a better way to manage these clocks in CCF.
> > This patch adds clock support for MM, IMG, VDEC, VENC and VENC_LT
> > subsystems.
> 
> Is there a reason why this patch (or patch set) does not also include
> definitions for the SCP_SYS, AUDIO and MFG_SYS clocks?

Clocks of SCP_SYS is a workaround in our previous internal
implementation. It should be replaced with new mtk-scpsys driver which
implemented in pm_domain framework because they are used to power on/off
subsystem domains.

I had discussed with Sascha, and he said it not worth the overhead of
CCF for clocks that are not shared by different units. As I know AUDIO
and MFG clocks are only used by their own drivers. So I don't include
them in this patch.


Best regards,

James
