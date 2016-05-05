From: dianders@chromium.org (Doug Anderson)
Date: Thu, 5 May 2016 15:57:39 -0700
Subject: [PATCH v7 5/9] i2c: rk3x: Change SoC data to not use array
In-Reply-To: <1462372418-6349-1-git-send-email-david.wu@rock-chips.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
 <1462372418-6349-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <CAD=FV=UsLmiASrso1SM5aGQPmJKNSXS260E7fiiYgmFQ4t1jpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 4, 2016 at 7:33 AM, David Wu <david.wu@rock-chips.com> wrote:
> Signed-off-by: David Wu <david.wu@rock-chips.com>

nit: $SUBJECT should probably mention that this also constifies the SoC data.


Again, needs description, like maybe:

Specifying the i2c SoC data in an array provides very little benefit and
gets unwieldly / confusing as the array grows since the next bit of code
needs to refer to elements in the array by their raw integral index.

Let's just create a single 'static const' structure for each SoC so that
we can refer to these structures by ID.


IMHO this can be applied any time independent of any earlier patches.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
