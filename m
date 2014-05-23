From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 23 May 2014 22:43:42 +0800
Subject: [PATCH 07/22] clk: sunxi: Fix PLL6 calculation on sun6i
In-Reply-To: <537F486D.9060900@elopez.com.ar>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-8-git-send-email-wens@csie.org>
 <537F486D.9060900@elopez.com.ar>
Message-ID: <CAGb2v64+UBUZeqsy02K2x+HCh=YAAVz_wLaPVRhdD=F5zT+Ccw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 23, 2014 at 9:09 PM, Emilio L?pez <emilio@elopez.com.ar> wrote:
> Hi,
>
> El 23/05/14 04:51, Chen-Yu Tsai escribi?:
>
>> The N factor for PLL6 counts from 1 to 32, as specified in the A23
>> manual, and shown in Allwinner's original code.
>
>
> Are you sure about this? The A23 manual I'm looking at has a 5-bit field (so
> 0-31) on 12:8, and the examples count from 0 (eg Factor=0 N=1 ... Factor=31
> N=32).

>From the A23 manual:

Factor = 0, N = 1
Factor = 1, N = 2
Factor = 2, N = 3
 and so on


>From the A20 manual:

Factor = 0, N = 0
Factor = 1, N = 1
Factor = 2, N = 2

The "N factor" I referred to in my commit message is the N used in the
calculation,
not what is stored in the bit field.

Hope this makes it clear. :)

Cheers
ChenYu
