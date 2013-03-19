From: AChew@nvidia.com (Andrew Chew)
Date: Tue, 19 Mar 2013 14:31:34 -0700
Subject: [PATCH V4 6/9] ARM: mxs: Provide regulator to pwm-backlight
In-Reply-To: <201303192227.21717.marex@denx.de>
References: <1363719573-20926-1-git-send-email-achew@nvidia.com>
 <1363719573-20926-7-git-send-email-achew@nvidia.com>
 <201303192227.21717.marex@denx.de>
Message-ID: <643E69AA4436674C8F39DCC2C05F7638629CD2FDF4@HQMAIL03.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Dear Andrew Chew,
> 
> > The pwm-backlight driver now takes a mandatory regulator that is
> > gotten during driver probe.  Initialize a dummy regulator to satisfy
> > this requirement.
> >
> > Signed-off-by: Andrew Chew <achew@nvidia.com>
> 
> Do we really need a mandatory regulator? Why can't it be optional?
> 
> Best regards,
> Marek Vasut

Because for those using board setup code (and not devicetree), it was
not possible to distinguish between opting out of the regulator, and
deferred probe, without adding something to the platform data that
board setup code needed to fill in anyway.
