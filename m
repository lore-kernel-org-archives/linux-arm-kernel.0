From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 1 Dec 2014 11:30:54 +0800
Subject: [PATCH] clk: sunxi: Fix factor clocks usage for sun9i core clocks
In-Reply-To: <20141130212920.GA25249@lukather>
References: <1417080570-5099-1-git-send-email-wens@csie.org>
 <20141130212920.GA25249@lukather>
Message-ID: <CAGb2v67jri1ahFtf4yRviQ80zpyjStJfe+SNJm3JOysfRv=R_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 1, 2014 at 5:29 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Thu, Nov 27, 2014 at 05:29:30PM +0800, Chen-Yu Tsai wrote:
>> The sunxi factor clocks usage was changed in
>>
>>     clk: sunxi: Give sunxi_factors_register a registers parameter
>>
>> However the sun9i core clocks were not fixed up in that patch,
>> resulting in breakage. This patch fixes that.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>
> Applied, thanks!

Thanks. Note that I'm tracking patches you've merged for 3.20
in my own sunxi-next branch on github.

>> This patch is for 3.20.
>>
>> A bit of boiler plate code for each clock provider.
>> Maybe we should add a local helper or something?
>
> Well, isn't that expected since we actually just moved it out?

I'll look into making a nice macro for this.

ChenYu
