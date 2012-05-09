From: olof@lixom.net (Olof Johansson)
Date: Tue, 8 May 2012 23:48:06 -0700
Subject: [GIT PULL] omap fixes for v3.4-rc6
In-Reply-To: <20120507223632.GP5088@atomide.com>
References: <20120507223632.GP5088@atomide.com>
Message-ID: <CAOesGMjHEy0Rz+ow7J3BuUtt3h3SjU+6gG=PPGTu3tMNZXy6nQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 7, 2012 at 3:36 PM, Tony Lindgren <tony@atomide.com> wrote:
> The following changes since commit 69964ea4c7b68c9399f7977aa5b9aa6539a6a98a:
[..]
> Enrico Butera (1):
> ? ? ?ARM: OMAP: igep0020: fix smsc911x dummy regulator id

Hmm. Picking 40 without any kind of comment in the code isn't doing
any favors for future readers. Seems like 1 would be free on this
board, from the rest of the board file to judge (one other
reg-fixed-regulator platform device)?

Please either comment why you picked 40 (i.e. it's a random number),
or change it to something a little less random like 1. :)

> Laurent Pinchart (1):
> ? ? ?ARM: OMAP: igep0020: Specify the VPLL2 regulator unconditionally

Is this a regression? I don't see any recent changes regarding this,
so it's hard to tell. If not then I'd rather hold off for the merge
window given that we're at -rc6.


-Olof
