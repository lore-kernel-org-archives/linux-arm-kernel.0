From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 1 Jun 2015 16:53:28 -0700
Subject: [PATCH v2 05/12] ARM: imx: setup tctl register in device specific
 function
In-Reply-To: <1432308599-28643-6-git-send-email-shawn.guo@linaro.org>
References: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
 <1432308599-28643-6-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAMAWPa-1MPgzT1GJQx4SjmfQpj9zdwsAw-qvLWZjVhoM66nHsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Fri, May 22, 2015 at 8:29 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> It creates a gpt device speicific data structure and adds function hook
> gpt_setup_tctl in there to set up gpt TCTL register.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Starting with next-20150529, imx6dl-wandboard (both dual and solo)
started having boot failures[1].  Today I bisected it down to this
commit.  It didn't revert cleanly, so I didn't verify that this patch
alone is the root cause, but reproducing the boot failure should be
pretty easy on wandboard with recent linux-next.

Kevin

[1]  http://kernelci.org/boot/all/job/next/kernel/next-20150529/
