From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 May 2018 16:20:35 +0200
Subject: [PATCH 1/5] dt-bindings: pinctrl: document the STMFX pinctrl
 bindings
In-Reply-To: <55392fe7-20d2-9447-60f9-4bd226b60195@st.com>
References: <1523440025-18077-1-git-send-email-amelie.delaunay@st.com>
 <1523440025-18077-2-git-send-email-amelie.delaunay@st.com>
 <20180416181940.4b5z4svbde3ompij@rob-hp-laptop>
 <CACRpkdYOMjjYyWQz7PK34jqUK7z5-CmH1HY6un4k8nBn7Cq8ag@mail.gmail.com>
 <55392fe7-20d2-9447-60f9-4bd226b60195@st.com>
Message-ID: <CACRpkda2VGo0FOdR09tKiTpg66NgoWjubaHp_J3372y=a772Zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 9, 2018 at 9:56 AM, Amelie DELAUNAY <amelie.delaunay@st.com> wrote:

> Indeed, stmfx has other functions than GPIO. But, after comments done
> here: [1] and there: [2], it has been decided to move MFD parent/GPIO
> child drivers into a single PINCTRL/GPIO driver because of the following
> reasons:
> - Other stmfx functions (IDD measurement and TouchScreen controller) are
> not used on any of the boards using an stmfx and supported by Linux, so
> no way to test these functions, and no need to maintain them while they
> are not being used.
> - But, in the case a new board will use more than GPIO function on
> stmfx, the actual implementation allow to easily extract common init
> part of stmfx and put it in an MFD driver.
>
> So I could remove gpio sub-node and put its contents in stmfx node and
> keep single PINCTRL/GPIO driver for the time being.
> Please advise,

I would normally advice to use the right modeling from the start, create
the MFD driver and spawn the devices from there. It is confusing
if the layout of the driver(s) doesn't really match the layout of the
hardware.

I understand that it is a pain to write new MFD drivers to get your
things going and it would be "nice to get this working really quick
now" but in my experience it is better to do it right from the start.

Yours,
Linus Walleij
