From: olof@lixom.net (Olof Johansson)
Date: Tue, 17 Jul 2012 20:43:34 -0700
Subject: [GIT PULL] SPEAr platform fixes over 3.5-rc7
In-Reply-To: <20120717130150.GM1994@localhost.localdomain>
References: <20120717130150.GM1994@localhost.localdomain>
Message-ID: <CAOesGMgHFrydxO-eJiuTL2yLKmVZXMcqiPhnBZQgbd=YcXD-Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shiraz,

I see that every commit in that branch is done by you, but not a
single one has a Signed-off-by by you. Please fix that, it's important
to track the history of how code is introduced to the kernel.

Also, we are _very_ late in the 3.5 release cycle now. Only truly
critical fixes can go in (3.5 is likely to come out by the weekend). I
have some comments about the patches below.

In general, to make our life easier, please make sure the commit
message for the patch describes why the fix is needed when it's not
obvious.

I'll wait with pulling until you have a chance to fix up your branch
based on the below comments. Please make sure you do it with extreme
expediency though, or chances are it'll miss 3.5.


Thanks,

-Olof

On Tue, Jul 17, 2012 at 6:01 AM, Shiraz Hashim <shiraz.hashim@st.com> wrote:

> Vipul Kumar Samar (10):
>       clk:spear1340:Fix: Rename clk ids within predefined limit
>       clk:spear1310:Fix: Rename clk ids within predefined limit
>       Clk:spear3xx:Fix: Rename clk ids within predefined limit
>       Clk:spear6xx:Fix: Rename clk ids within predefined limit

Ok, those 4 are quite obvious why they're needed.

>       ARM: SPEAr13xx: Fix Interrupt bindings
>       clk: SPEAr1340: Fix clk enable register for uart1 and i2c1.

Those two as well.

>       clk: SPEAr13xx: Add localtimer (twd) clock support

This doesn't look like a critical regression fix, does it?

>       Clk: SPEAr1340: Update sys clock parent array

Please help us out here by describing what is broken by the way it was
before the patch.

>       ARM: dts: SPEAr320: Fix compatible string

This one seems straightforward.

>       ARM: dts: SPEAr320: Boot the board in EXTENDED_MODE

Same here, please elaborate on why / how it is broken today.


Thanks,

-Olof
