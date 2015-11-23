From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 23 Nov 2015 15:18:05 +0800
Subject: [PATCH 1/3] rtc: sunxi: fix signedness issues
In-Reply-To: <1447930210-27008-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1447930210-27008-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <CAGb2v66odj__GMWy8sgc0b5df5FR1V3p-EhL2f-QMM8krA3Oqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 6:50 PM, LABBE Corentin
<clabbe.montjoie@gmail.com> wrote:
> The variable year must be set as unsigned since it is used with
> sunxi_rtc_data_year{.min|.max} and as parameter of is_leap_year() which
> wait for unsigned int.
> Only tm_year is not unsigned, but it is long.
> This patch fix also the format of printing of min/max. (must use %u since
> they are unsigned)
>
> The parameter to of sunxi_rtc_setaie() must be set to uint since callers
> give always uint data.
>
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

Would've preferred you not changing the whitespace on the dev_err line though.
