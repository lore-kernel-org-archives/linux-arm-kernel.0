From: shiraz.hashim@st.com (Shiraz Hashim)
Date: Wed, 18 Jul 2012 09:52:11 +0530
Subject: [GIT PULL] SPEAr platform fixes over 3.5-rc7
In-Reply-To: <CAOesGMgHFrydxO-eJiuTL2yLKmVZXMcqiPhnBZQgbd=YcXD-Mg@mail.gmail.com>
References: <20120717130150.GM1994@localhost.localdomain>
 <CAOesGMgHFrydxO-eJiuTL2yLKmVZXMcqiPhnBZQgbd=YcXD-Mg@mail.gmail.com>
Message-ID: <20120718042211.GP1994@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Tue, Jul 17, 2012 at 08:43:34PM -0700, Olof Johansson wrote:
> Hi Shiraz,
> 
> I see that every commit in that branch is done by you, but not a
> single one has a Signed-off-by by you. Please fix that, it's important
> to track the history of how code is introduced to the kernel.

Sorry, I would take care for this and all future pull requests.

> Also, we are _very_ late in the 3.5 release cycle now. Only truly
> critical fixes can go in (3.5 is likely to come out by the weekend). I
> have some comments about the patches below.
> 
> In general, to make our life easier, please make sure the commit
> message for the patch describes why the fix is needed when it's not
> obvious.

Sure.

> I'll wait with pulling until you have a chance to fix up your branch
> based on the below comments. Please make sure you do it with extreme
> expediency though, or chances are it'll miss 3.5.

OK.

> On Tue, Jul 17, 2012 at 6:01 AM, Shiraz Hashim <shiraz.hashim@st.com> wrote:
> 
> >       clk: SPEAr13xx: Add localtimer (twd) clock support
> 
> This doesn't look like a critical regression fix, does it?

Yes, twd would rely on its calibration if we don't pass it.
Although it would break other stuff like cpu-freq, but they are not
yet upstreamed.

I would remove it from fixes branch and schedule it later.

> >       Clk: SPEAr1340: Update sys clock parent array
> 
> Please help us out here by describing what is broken by the way it was
> before the patch.

Out of several possibilities (h/w wise) to select same clock parent,
Linux was considering just one value. When bootloader programmed
different (valid) value to select a clock parent then Linux breaks.

Here, we just try to list all possibilities which can lead to same
clock selection thus making Linux independent of bootloader selection
values.

This was discussed in following thread
http://www.spinics.net/lists/arm-kernel/msg183554.html

> >       ARM: dts: SPEAr320: Fix compatible string
> 
> This one seems straightforward.
> 
> >       ARM: dts: SPEAr320: Boot the board in EXTENDED_MODE
> 
> Same here, please elaborate on why / how it is broken today.

spear320-evb board is designed for EXTENDED_MODE only, hence it would
not boot correctly in current form (pinctrl part for some devices would
fail). I would update the commit message.

Thanks for review. I would update the branch as soon as possible and
send a fresh pull request.

--
regards
Shiraz
