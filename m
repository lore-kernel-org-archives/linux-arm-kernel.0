From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 2 Jun 2011 10:56:57 +0100
Subject: [PATCH 4/5] ARM: S3C6410: Support 800MHz operation in cpufreq
In-Reply-To: <BANLkTikpO9VR9tqJT_bROA_KfdxOBS7U0Q@mail.gmail.com>
References: <20110601094313.GA23122@opensource.wolfsonmicro.com>
	<1306921493-30911-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1306921493-30911-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<037201cc2046$f5cc53b0$e164fb10$@com>
	<20110601104042.GA15387@opensource.wolfsonmicro.com>
	<038c01cc20b9$a55a5120$f00ef360$@com>
	<20110602082830.GA3085@opensource.wolfsonmicro.com>
	<039601cc2109$319c9770$94d5c650$@com>
	<BANLkTimC=MrmjinzufrnOMSAgiQvVKdWhA@mail.gmail.com>
	<BANLkTikpO9VR9tqJT_bROA_KfdxOBS7U0Q@mail.gmail.com>
Message-ID: <20110602095656.GC3085@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2011 at 03:20:56PM +0530, Jassi Brar wrote:
> On Thu, Jun 2, 2011 at 3:14 PM, Kyungmin Park <kmpark@infradead.org> wrote:

> > Then how about to introduce the software flags. and set it at each
> > board. It can support the 800MHz.
> > Also this flags are handled at cpufreq drivers properly.

> > How do you think?

> Two SMDKs may have different versions of s3c6410.
> Which file do we want to set the flags in ?

In this case the board can effectively eliminate 800MHz operation
through the regulation constraints as it requires 1.3V rather than 1.2V.

IIRC the device always comes up at full speed so the boot state also
constrains things with the current system - there's no code to reclock
the PLLs so if we boot up at 667MHz then 800MHz is inaccessible.
