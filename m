From: martinwguy@gmail.com (Martin Guy)
Date: Sat, 20 Mar 2010 19:48:21 +0000
Subject: [PATCH v2 2/3] ep93xx: added chip revision reading function
In-Reply-To: <0D753D10438DA54287A00B02708426976368B755D3@AUSP01VMBX24.collaborationhost.net>
References: <cover.1268930557.git.mika.westerberg@iki.fi>
	<9de3769ae253830fb0eebc98d299137c59c69b8c.1268930557.git.mika.westerberg@iki.fi>
	<c222c3df9c94d9ec919817f640a953e4f45ae99b.1268930557.git.mika.westerberg@iki.fi>
	<56d259a01003201107s758b420bmafa154714a8a8fee@mail.gmail.com>
	<20100320182500.GF30801@buzzloop.caiaq.de>
	<56d259a01003201140o8852165w7d1b3384927e70f7@mail.gmail.com>
	<0D753D10438DA54287A00B02708426976368B755D3@AUSP01VMBX24.collaborationhost.net>
Message-ID: <56d259a01003201248r37c238fck9499bab795fda7dd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/20/10, H Hartley Sweeten <hartleys@visionengravers.com> wrote:
>  The ep93xx unique serial number, also called the MaverickCrunch ID, can
>  be found in the Sercurity registers.  There are actually two of them.
>  One is a 32-bit unique ID the other is a 128-bit random ID.  Random
>  meaning random per chip not per boot since it is created by means of
>  fuseable links on the chip that are set during manufacture.  These
>  also are not currently exposed to the user in any fashion.
>
>  I had submitted a patch previously that adds an architecture specific
>  extension to /proc/cpuinfo that would allow exposing this information
>  on the ep93xx.  The same extension could be used on platforms like the
>  TS-7200 to show the jumper settings on the board.
>
>  If there is any interest I will re-post that patch series.

Thanks.

Yes, being able to see the unique ID is certainly useful. I use this
in userspace to set a different MAC address on each board for DHCP
purposes in a classroom of otherwise identical diskless X terminals
based on this chip.

    M
