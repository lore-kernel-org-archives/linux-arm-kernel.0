From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Apr 2012 12:01:30 -0600
Subject: [PATCH 1/3] pinctrl: pinctrl-imx: add imx pinctrl core driver
In-Reply-To: <20120416014720.GH24997@S2101-09.ap.freescale.net>
References: <1334333915-1174-1-git-send-email-b29396@freescale.com>
 <20120414134814.GA3852@pengutronix.de>
 <CAA+hA=T0FAfuGKcW0vAKO+OWyFdM-6vQqVo53xKf8y28m7gPOQ@mail.gmail.com>
 <20120415141736.GG24997@S2101-09.ap.freescale.net>
 <20120415172958.GG20478@pengutronix.de>
 <20120416014720.GH24997@S2101-09.ap.freescale.net>
Message-ID: <4F8C5E7A.9090705@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2012 07:47 PM, Shawn Guo wrote:
> On Sun, Apr 15, 2012 at 07:29:58PM +0200, Sascha Hauer wrote:
> ...
>> How far are we away from getting macro support? Do we already agree that we
>> want to have such a feature? I remember I saw someone mentioning it,
>> maybe even by piping the devicetree though CPP, but I didn't follow the
>> further discussion.
>>
> My understanding is we agree that we want to have this feature, and
> are approaching it slowly, but I do not have the exact status.
> Stephen may want to give an update, please?

The status is:

* I proposed a "/define/ var 5" syntax to dtc.

* It was at least temporarily rejected because it wasn't clear whether
that syntax would fit into whatever future expression/language/...
support dtc might acquire in the future.

* However, there has been a long-standing impasse on defining what the
future expression/language/... support in dtc will look like.

* In an attempt to move that forward, I took one of David Gibson's old
integer expressions patches (that allows math within cells in
properties), updated that to ToT, and now it's checked in. This only
allows match with literals, not variables/symbols/..., but is hopefully
a step in the right direction.

* The next step is to revisit my /define/ patch on top of the integer
expressions patch. Perhaps the presence of integer expressions is enough
to know whether /define/ is a reasonable syntax, perhaps not. We'll have
to see when I update and repost it.

In summary: There is some progress, but it's slow. I wouldn't rely on
seeing /define/ or similar support in dtc in any particular near-term
timescale.
