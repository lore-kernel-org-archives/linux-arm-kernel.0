From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 5 Dec 2011 10:52:02 +0000
Subject: [PATCH] backlight: add regulator support for platform_lcd driver
In-Reply-To: <CAJuYYwTT2jbbquZM=ZwK=Gh39ss=iG0WDCc3TYjzHLEgfeC1gA@mail.gmail.com>
References: <1323074921-29291-1-git-send-email-thomas.abraham@linaro.org>
 <CAH9JG2XJ4TCEaN1rMRjMZNRn5Wx6jcTRC_DmyN4Qyf2zztWSsg@mail.gmail.com>
 <CAJuYYwTT2jbbquZM=ZwK=Gh39ss=iG0WDCc3TYjzHLEgfeC1gA@mail.gmail.com>
Message-ID: <20111205105201.GD11150@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2011 at 04:06:17PM +0530, Thomas Abraham wrote:
> On 5 December 2011 15:40, Kyungmin Park <kmpark@infradead.org> wrote:

> > Recent regulator discussion. it should be failed instead fall through
> > gracefully.

> Ok. But in this case, there could be boards that do not use a
> regulator for the lcd/display interface. Is it mandatory for fail if
> regulator is not found. Sorry, I have not read through the regulator
> discussion.

The boards should supply a fixed voltage regulator representing the
supply (or use CONFIG_REGULATOR_DUMMY to substitute in a dummy regulator
when not needed).  Sascha Hauer had some patches to add a flag that
could be set to enable this mode on init rather than through Kconfig but
they needed a bit of cleanup, not sure what the status is there.

> The constraint 'apply_uV' cannot be expressed with a device tree. So
> there has be a mechanism to set the required output voltage for a
> regulator.

It's not an option to not have it with device tree - if there's a single
voltage specified apply_uV is assumed.
