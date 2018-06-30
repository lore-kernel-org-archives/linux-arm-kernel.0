From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 30 Jun 2018 09:09:57 +0800
Subject: [linux-sunxi] [PATCH v3 06/24] drm/sun4i: Fix releasing node when
 enumerating enpoints
In-Reply-To: <3837144.KdEe8HRubn@jernej-laptop>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180625120304.7543-7-jernej.skrabec@siol.net>
 <CAGb2v65dNvqcWa7MUMesrEeDGfEmd0xPpKQmbqJ60_FHe=Y_JA@mail.gmail.com>
 <3837144.KdEe8HRubn@jernej-laptop>
Message-ID: <CAGb2v65xZe8VM+dOd1fchXgekpgzvj1s75zdjz-6Met4K-5nBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 30, 2018 at 3:15 AM, Jernej ?krabec <jernej.skrabec@siol.net> wrote:
> Dne ?etrtek, 28. junij 2018 ob 03:53:36 CEST je Chen-Yu Tsai napisal(a):
>> On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net>
> wrote:
>> > sun4i_drv_add_endpoints() has a memory leak since it uses of_node_put()
>> > when remote is equal to NULL and does nothing when remote has a valid
>> > pointer.
>> >
>> > Invert the logic to fix memory leak.
>> >
>> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>>
>> Given this is a fix, it should have Fixes and stable tags.
>
> How should be this handled given that the patch is already merged and cannot
> be dropped?

We can't. We'll have to manually submit it for stable once this lands
in Linus' tree.

ChenYu
