From: dianders@chromium.org (Doug Anderson)
Date: Mon, 11 Feb 2013 15:53:59 -0800
Subject: [RFC] i2c: Providing hooks for i2c multimaster bus arbitration.
In-Reply-To: <20130210181710.GB12760@nekote.pengutronix.de>
References: <1359968595-21291-1-git-send-email-yuvaraj.cd@samsung.com>
 <20130210181710.GB12760@nekote.pengutronix.de>
Message-ID: <CAD=FV=XzfseMEHK4KutgYYoU4kEFPq7qoFoJtaBrh6QJUa1Y_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram,

On Sun, Feb 10, 2013 at 10:17 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Mon, Feb 04, 2013 at 02:33:15PM +0530, Yuvaraj Kumar C D wrote:
>> This RFC patch is w.r.t multimaster bus arbitration which is already
>> being discussing in the mainline.
>> This patch provides hooks for the i2c multimaster bus arbitration
>> and to have the arbitration parameters.
>
> I still haven't understood why the arbitration specified in the I2C
> standard is not enough for you. Or what you would need to make use of
> it.

At the moment perhaps the strongest argument for why this particular
arbitration scheme is needed is that's what the EC (embedded
controller) on the ARM Chromebook uses.  There have been several
arguments in-house about whether this was the most ideal way to
structure things, but that's what we shipped with.  Thus, if we want
to be able to talk to i2c devices on this bus (contains the keyboard,
battery, and a bunch of power switches) we need something in the
system that implements this arbitration scheme.

As a side note: I'm trying to code up a quick arbitrator now using the
muxing framework as Grant suggested.  I will play with this and post
it if I can get it to work.  It's quite short so far.

-Doug
