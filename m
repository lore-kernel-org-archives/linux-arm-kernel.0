From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 5 Sep 2013 07:36:14 -0400
Subject: [PATCH] net: mvneta: properly disable HW PHY polling and
 ensure adjust_link() works
In-Reply-To: <20130905092808.617da416@skate>
References: <1378304478-21237-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130904163245.GI20552@1wt.eu>
 <CACzLR4uDQK2bkcEJQXLe805EfSA8=eF+YH-FTYovHA0q+8Y9NA@mail.gmail.com>
 <20130905051223.GB26000@1wt.eu> <20130905092808.617da416@skate>
Message-ID: <20130905113614.GQ19598@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 05, 2013 at 09:28:08AM +0200, Thomas Petazzoni wrote:
>  (2) Use the "impedance matcher" code written by Daniel Mack and
>      extended by Jason Cooper, available at
>      https://github.com/zonque/pxa-impedance-matcher. Essentially, it
>      inserts a small binary between the installed bootloader and the
>      kernel, that for example allows to choose a particular DTB amongst
>      several, depending on the board that is detected. I believe it
>      could probably be extended to cover other use cases such as
>      modifying the DTB to add the MAC addresses where appropriate. I've
>      added Jason Cooper in the Cc list if he wants to comment on that.

Yes, I'm hoping to add the dtb editing support sometime over the next
few weeks.  That way, we can use Willy's atags patch in there, and the
kernel never knows the difference.

It isn't high on my priority list atm, so if someone else is motivated,
I've been borrowing code from barebox to flesh out impedance-matcher.
Patches are welcomed ;-)

thx,

Jason.
