From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 3 Aug 2014 23:55:39 +0800
Subject: [PATCH 7/9] ARM: sunxi: dt: Add PLL2 support
In-Reply-To: <20140803125041.GX3952@lukather>
References: <1406842092-25207-1-git-send-email-emilio@elopez.com.ar>
 <1406842092-25207-8-git-send-email-emilio@elopez.com.ar>
 <CAKON4OycHvkAkndNvH3vkaE0d7P5d4ZsGrYw8eM_Py6HUo06sg@mail.gmail.com>
 <20140803125041.GX3952@lukather>
Message-ID: <CAGb2v66PEQvv7DWR_uyLqMSdZu6NQpwexF-mo29BOVFVak+XVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 3, 2014 at 8:50 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Thu, Jul 31, 2014 at 05:46:09PM -0400, jonsmirl at gmail.com wrote:
>> Would it be better to name this "allwinner,sun4i-a10-pll2-clk" instead
>> of "allwinner,sun4i-a10-b-pll2-clk"? By encoding the b in it everyone
>> is going to wonder what to do on the 'c' revision which is the most
>> common revision.
>
> Not really, the way we works usually is that the compatible is the one
> from the first SoC that implemented that IP. If the rev C has the same
> IP than rev B, then we're using the rev B compatible.
>
>>
>> The revision based rename would then be from
>> "allwinner,sun4i-a10-pll2-clk" to "allwinner,sun4i-a10-a-pll2-clk".
>
> Though, I'd agree with you. We should have a single compatible in the
> DT, a generic one, that would trigger the auto-detection, and might
> change it to the rev A one, but the rev B doesn't make much sense.

I agree. The rev B would make people reading the DT wonder what happened
to rev A.
