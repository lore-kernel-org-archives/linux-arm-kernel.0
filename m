From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Oct 2012 08:51:31 +0200
Subject: [PATCH] [RFC] pinctrl: mvebu: reset pins to an UNKNOWN state on
 startup
In-Reply-To: <20121024222139.40fb2ad5@skate>
References: <1351106281-31288-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121024201545.GA21046@lunn.ch> <20121024222139.40fb2ad5@skate>
Message-ID: <CACRpkdbth4zGp5ZpwPUDUMag1xNCLbA6L=R9nimGX57Osyb53w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 10:21 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> On Wed, 24 Oct 2012 22:15:45 +0200, Andrew Lunn wrote:

>> If you compare the two, you can see that pin 6 has probably been set by
>> uboot, but not by DT.
>
> Indeed, by correlating the two files, you can get a good view of which
> pins are configured even though no driver has claimed them.

If it is useful, please consider introducing new debugfs files, that thing
is supposed to be helpful.

For example: if a <debugfs>/pinctrl/pinctrl-foo/pins-probe-state
caching and providing the power-on-state of all pins is useful,
then just add that mechanism to the pinctrl core I'd say.

Yours,
Linus Walleij
