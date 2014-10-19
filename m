From: olof@lixom.net (Olof Johansson)
Date: Sun, 19 Oct 2014 14:24:41 -0700
Subject: [PATCH] ARM: sunxi_defconfig: enable CONFIG_REGULATOR
In-Reply-To: <20141016114624.GI19438@lukather>
References: <1413354549-9012-1-git-send-email-olof@lixom.net>
 <20141016080448.GF19438@lukather>
 <20141016104716.GA15929@gmail.com>
 <20141016114624.GI19438@lukather>
Message-ID: <CAOesGMheX6jbx1qxtnqiFZ+oSWZ8NkEpZxBKX5PxZ3C2SREk6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 16, 2014 at 4:46 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Thu, Oct 16, 2014 at 12:47:17PM +0200, Beniamino Galvani wrote:
>> On Thu, Oct 16, 2014 at 10:04:48AM +0200, Maxime Ripard wrote:
>> > Hi Olof,
>> >
>> > On Tue, Oct 14, 2014 at 11:29:09PM -0700, Olof Johansson wrote:
>> > > Commit 97a13e5289ba ('net: phy: mdio-sun4i: don't select REGULATOR') removed
>> > > the select of REGULATOR, which means that it now has to be explicitly
>> > > enabled in the defconfig or things won't work very well.
>> > >
>> > > In particular, this fixes a problem with SD/MMC not probing on my A31-based
>> > > board.
>> > >
>> > > Cc: Beniamino Galvani <b.galvani@gmail.com>
>> > > Signed-off-by: Olof Johansson <olof@lixom.net>
>> > > ---
>> > >
>> > > Maxime, I'll apply this on our fixes branch directly.
>> >
>> > I've been chasing the same bug, but didn't make a patch yet. Thanks
>> > for taking the time to do it!
>> >
>> > If it's not applied yet, you have my
>> > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>
>> Sorry for the breakage, I didn't realize that some configurations
>> could rely on the implicit selection of the symbol.
>
> Don't worry, it's fine, it's why we have a bugfix period and boots
> testing for :)

Yep, no worries.

However, it doesn't seem to have been enough and I don't know how I
made the test pass the first time when I checked the fix.  Looks like
it needs REGULATOR_FIXED_VOLTAGE too, and I didn't catch it before I
sent out the pull request. D'oh.

I'll fix it for -rc2.


-Olof
