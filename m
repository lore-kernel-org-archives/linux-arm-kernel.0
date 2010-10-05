From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 05 Oct 2010 10:56:23 +0200
Subject: [PATCH 0/7] ARM: S5PC210: I2C devices support and Universal board
	updates
In-Reply-To: <001401cb6468$ed8d06d0$c8a71470$%kim@samsung.com>
References: <20100930044814.GA16892@july>
	<AANLkTiknkbts6AtiBpqceSDqEXsE9E+qpMKJx2fzygB6@mail.gmail.com>
	<001401cb6468$ed8d06d0$c8a71470$%kim@samsung.com>
Message-ID: <013501cb646b$3205cbb0$96116310$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, October 05, 2010 10:40 AM Kukjin Kim wrote:

> > I think we made some conclusion. first apply the current style and
> > improve it later for consistency.
> >
> Yeah, we should decide for this.
> 
> However, it's expected following problem with current I2C style.
> 
> Suppose A board want to use only I2C0, 1, 2, 3, 4, 7 as I2C and B board want
> to use all of I2C channels as I2C. If use one kernel image for A and B,
> maybe selected all I2C channels. It can be happened the some problem about
> I2C5 and I2C6 on A board when it used for other purpose.

Could you explain it in more detailed way? I really don't see any problem here.
Please distinguish the registration of s3c-i2cX device to platform bus and the
fact the structure has been compiled into the kernel.

In your case all dev-i2cX entries will be compiled into the kernel, but board
A will REGISTER to platform bus only the entries that are in use. No runtime
problem can ever happen. That's the main basis of the kernel device framework.

> Of course can happen regardless of number of I2C channel, but if more I2C
> channels, the probability can be increased.

Again, I really don't understand your concerns.

> Anyway I know Mr. Han is preparing I2C patches for it and almost done.
> How about continuing discussion for this after submitting it?
> 
> I think we have some time that talk about this issue.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
