From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Tue, 17 Apr 2012 11:42:11 +0800
Subject: [PATCH 1/1] pinctrl: handle dummy state in core
In-Reply-To: <4F8C42D6.2000607@wwwdotorg.org>
References: <1334586289-13078-1-git-send-email-b29396@freescale.com>
 <4F8C42D6.2000607@wwwdotorg.org>
Message-ID: <20120417034210.GD17173@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 12:03:34AM +0800, Stephen Warren wrote:
> On 04/16/2012 08:24 AM, Dong Aisheng wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> > 
> > Remove dummy state user interface and handle it totally in core.
> > This can make it more easy to use by platforms which has neither pinctrl
> > driver support nor dt support.
> > 
> > Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> 
> I think this is the wrong direction.
> 
> I specifically want people to think about which drivers require what
> pinctrl states to be defined, and what their content should be, and
> hence explicitly define dummy states when it's appropriate. This patch
> prevents that.
> 
It's correct if all platforms have switched to pinctrl subsystem.

I think the main issue is for one platform neither supports dt nor using pinctrl
subsystem, do you think it still makes too much sense to force that platform
to define a _PINCTRL_ dummy state in their machine code?

But the driver is commonly shared between these different platforms(using pinctrl
or not).

That's why i proposed to handle dummy state in core in this patch rather than require
user to do it.

You must can assume there're so many platforms still have not switched to use pinctrl
subsystem. If we require user to do it, we need change many code.

Regards
Dong Aisheng
