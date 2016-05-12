From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Wed, 11 May 2016 19:09:02 -0700
Subject: [PATCH 6/6] pinctrl: mt8173: set GPIO16 to usb iddig mode
In-Reply-To: <1463017282.11651.82.camel@mhfsdcap03>
References: <1462868614-20602-1-git-send-email-chunfeng.yun@mediatek.com>
 <1462868614-20602-7-git-send-email-chunfeng.yun@mediatek.com>
 <CACRpkdaeD5mk7LXEWnE0=Xute8-JA-fa4tVt4fYhujEXeq2+9w@mail.gmail.com>
 <1462991546.11623.3.camel@mussux00> <1463017282.11651.82.camel@mhfsdcap03>
Message-ID: <1463018942.1608.5.camel@mussux00>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-05-12 at 09:41 +0800, chunfeng yun wrote:
> Hi,
> 
> On Wed, 2016-05-11 at 11:32 -0700, Hongzhou Yang wrote:
> > On Wed, 2016-05-11 at 13:56 +0200, Linus Walleij wrote:
> > > On Tue, May 10, 2016 at 10:23 AM, Chunfeng Yun
> > > <chunfeng.yun@mediatek.com> wrote:
> > > 
> > > > the default mode of GPIO16 pin is gpio, when set EINT16 to
> > > > IRQ_TYPE_LEVEL_HIGH, no interrupt is triggered, it can be
> > > > fixed when set its default mode as usb iddig.
> > > >
> > > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > 
> > 
> > Chunfeng, GPIO16 can be used as EINT16 mode, but the pinmux should be 0.
> > If you want to set its default mode to iddig, you should set it in dts.
> > 
> I set it in DTS, but it didn't work, because when usb driver requested
> IRQ, pinmux was switched back to default mode set by
> MTK_EINT_FUNCTION().
> 

After confirmed, there are something wrong with data sheet and pinmux
table, and GPIO16 can only receive interrupt by mode 1. So

Acked-by: Hongzhou Yang <hongzhou.yang@mediatek.com>

Yours,
Hongzhou
