From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 25 Mar 2013 20:50:46 +0100
Subject: [PATCH] ARM: dove: add more hardware description in the DT
In-Reply-To: <20130325192935.1a2bd19c@armhf>
References: <20130325103159.0c1b4f17@armhf>
 <CABJ1b_RrFpKdH3w=v4gvRQ-8UniKOz9o9VVJ8Q=AQz5WaN0NRQ@mail.gmail.com>
 <20130325192935.1a2bd19c@armhf>
Message-ID: <5150AA96.6090507@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2013 07:29 PM, Jean-Francois Moine wrote:
> On Mon, 25 Mar 2013 11:21:13 +0100
> Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>  wrote:
>
>> please choose a more informative node names like
>>
>> lcd0: lcd-controller at 820000 and
>
> I tried that, but it seems that the name is too long: I cannot get the
> external clock from the si5351 clkout0.
>

Jean-Francois,

you need to use of_clk_get and clocks property set to phandle of the
external clock instead of clk_get.

I will push a branch with my current driver soon, there you can see
how DT and drm will play together.

For now, please respin this patch with the comments I made or I can
also do this and add your Signed-off-by.

Sebastian
