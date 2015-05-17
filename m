From: eddie.huang@mediatek.com (Eddie Huang)
Date: Sun, 17 May 2015 18:47:59 +0800
Subject: [rtc-linux] [PATCH] rtc: mt6397: fix build on some 32bits
 platforms
In-Reply-To: <20150514215504.GF3338@piout.net>
References: <1431636678-29525-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150514215504.GF3338@piout.net>
Message-ID: <1431859679.31486.4.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-05-14 at 23:55 +0200, Alexandre Belloni wrote:
> Hi,
> 
> On 14/05/2015 at 22:51:18 +0200, Alexandre Belloni wrote :
> > On some !ARM 32bits platforms, the following compilation error happens
> > because of the division on a 64bits value in mtk_rtc_read_time():
> > 
> > drivers/built-in.o: In function `mtk_rtc_read_time':
> > rtc-mt6397.c:(.text+0x265d13f): undefined reference to `__divdi3'
> > rtc-mt6397.c:(.text+0x265d150): undefined reference to `__moddi3'
> > 
> > Use div_s64() as done in rtc_time64_to_tm() to solve that.
> > 
> > Reported-by: kbuild test robot <fengguang.wu@intel.com>
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> I've already pushed that patch to rtc-next to repair the build for i386
> and m68k but feel free to comment if you see anything wrong.

Sorry for late. I am in vacation and can't receive mail last week.
Thanks your effort to correct this.

Eddie
