From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Wed, 30 Nov 2016 16:43:50 -0800
Subject: [PATCH 6/6] pinctrl: mt8173: set GPIO16 to usb iddig mode
In-Reply-To: <42f5df18-2edd-08f2-a833-9c92ac85e87c@gmail.com>
References: <1462868614-20602-1-git-send-email-chunfeng.yun@mediatek.com>
 <1462868614-20602-7-git-send-email-chunfeng.yun@mediatek.com>
 <CACRpkdaeD5mk7LXEWnE0=Xute8-JA-fa4tVt4fYhujEXeq2+9w@mail.gmail.com>
 <1462991546.11623.3.camel@mussux00> <1463017282.11651.82.camel@mhfsdcap03>
 <1463018942.1608.5.camel@mussux00> <1463021701.25171.5.camel@mussux00>
 <42f5df18-2edd-08f2-a833-9c92ac85e87c@gmail.com>
Message-ID: <1480553030.29122.7.camel@mussux00>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-11-23 at 19:32 +0100, Matthias Brugger wrote:
> Hi Hongzhou,
> 
> On 12/05/16 04:55, Hongzhou Yang wrote:
> > On Wed, 2016-05-11 at 19:09 -0700, Hongzhou Yang wrote:
> >> On Thu, 2016-05-12 at 09:41 +0800, chunfeng yun wrote:
> >>> Hi,
> >>>
> >>> On Wed, 2016-05-11 at 11:32 -0700, Hongzhou Yang wrote:
> >>>> On Wed, 2016-05-11 at 13:56 +0200, Linus Walleij wrote:
> >>>>> On Tue, May 10, 2016 at 10:23 AM, Chunfeng Yun
> >>>>> <chunfeng.yun@mediatek.com> wrote:
> >>>>>
> >>>>>> the default mode of GPIO16 pin is gpio, when set EINT16 to
> >>>>>> IRQ_TYPE_LEVEL_HIGH, no interrupt is triggered, it can be
> >>>>>> fixed when set its default mode as usb iddig.
> >>>>>>
> >>>>>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> >>>>>
> >>>>
> >>>> Chunfeng, GPIO16 can be used as EINT16 mode, but the pinmux should be 0.
> >>>> If you want to set its default mode to iddig, you should set it in dts.
> >>>>
> >>> I set it in DTS, but it didn't work, because when usb driver requested
> >>> IRQ, pinmux was switched back to default mode set by
> >>> MTK_EINT_FUNCTION().
> >>>
> >>
> >> After confirmed, there are something wrong with data sheet and pinmux
> >> table, and GPIO16 can only receive interrupt by mode 1. So
> >>
> >> Acked-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
> >>
> >
> > Linus,
> >
> > We find there are some other pins still have the same problem, so please
> > hold on it. Sorry for so much noise.
> >
> 
> Did you made any progress on this? I didn't see any patch on the mailing 
> list.
> 
> Regards,
> Matthias

Hi Matthias,

Sorry for the late reply.

I have double confirmed with HW designer, other special EINTs are
built-in and they are using internal signal, they are not triggered 
by GPIO, only GPIO16 should set to mode 1.

And, Chunfeng already re-sent this patch.

Thank you very much.

Yours,
Hongzhou
