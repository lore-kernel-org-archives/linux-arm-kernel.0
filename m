From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 15 Dec 2017 13:30:24 +0100
Subject: [PATCH 0/4 v5] Support bridge timings
In-Reply-To: <20171215121047.3650-1-linus.walleij@linaro.org>
References: <20171215121047.3650-1-linus.walleij@linaro.org>
Message-ID: <CACRpkdYjSy5t_73g1UejxcL1JXcFUVntA_oDHV2G4ro4zaHNVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 1:10 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> - The connector is apparently not the right abstraction to carry
>   the detailed timings specification between DRI drivers and bridge
>   drivers.
>
> - Instead put detailed timing data into the bridge itself as an
>   optional information pointer.

Notice that this is just my fumbling attempts to deal with the situation.

Laurent made me understand what the actual technical problem was,
how come my pixels were flickering.

Both Laurent and DVetter mentioned that we may need to convey
information between the bridge and the display engine in some
way.

Alternatively I could go and hack on adding this to e.g. drm_display_info
which was used in the previous patch sets by setting the negede flag
in bus_formats.

I don't know. struct drm_display_info is getting a bit heavy as
container of misc settings related to "some kind of display".
The bridge isn't even a display itself, that is on the other side
of it. So using the connector and treating a bridge as "some kind
of display" seems wrong too.

Is there a third way?

I'm just a bit lost.

Suggestions welcome!

Yours,
Linus Walleij
