From: briannorris@chromium.org (Brian Norris)
Date: Thu, 27 Sep 2018 14:48:51 -0700
Subject: [PATCH 2/3] dt-bindings: firmware: coreboot: document board
 variant properties
In-Reply-To: <20180925163927.GA23163@bogus>
References: <20180822120214.11848-1-heiko@sntech.de>
 <20180822120214.11848-2-heiko@sntech.de>
 <20180831121836.GA23441@bogus> <1660300.IG1gbB27SJ@phil>
 <20180925163927.GA23163@bogus>
Message-ID: <CA+ASDXMMyz+uva9++kih+t9k2W+hFtA5E-Fmd8b_TwrY2N0LFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2018 at 9:39 AM Rob Herring <robh@kernel.org> wrote:
> Reading strapping values and putting into DT seems like a perfectly
> reasonable thing to do (I'm assuming the pins get initialized to their
> function and reading them later is not possible), but that has nothing
> to do coreboot really. We don't put things u-boot touches under a u-boot
> node. These should go at the top-level IMO.

Where, exactly? Do you have a suggested property name?

Regarding compatible-based approach (from prior email): we do heavily
use the top-level 'compatible' property too for a similar purpose, but
sometimes there's a useful difference between "I booted with DTB
<foo>, which is compatible with revision X, Y, Z, ..." and "the exact
revision I booted is N". So the properties are definitely useful.

> And maybe it is compelling to just take them having been in use for some
> time on widely deploying devices, but that's not really good precedence.

Well, we ain't changing the old firmware. Coming up with a new name
can work, and we can modify new firmware to start doing both. But it'd
still probably be wise to note what's actively in-use, especially if
it's not substantively different than what we settle on.

Brian
