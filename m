From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Wed, 03 Sep 2014 14:57:40 +0300
Subject: [PATCH] mmc: sdhci-msm: Make tuning block table endian agnostic
In-Reply-To: <1409702308-3023-1-git-send-email-sboyd@codeaurora.org>
References: <1409702308-3023-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <54070234.30201@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/2014 02:58 AM, Stephen Boyd wrote:
> If we're tuning on a big-endian CPU we'll never determine we properly
> tuned the device because we compare the data we received from the
> controller with a table that assumes the CPU is little-endian.
> Change the table to be an array of bytes instead of 32-bit words
> so we can use memcmp() without needing to byte-swap every word
> depending on the endianess of the CPU.
> 
> Cc: Asutosh Das <asutoshd@codeaurora.org>
> Cc: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Cc: Georgi Djakov <gdjakov@mm-sol.com>
> Fixes: 415b5a75da43 "mmc: sdhci-msm: Add platform_execute_tuning implementation"
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Looks nice. Thanks!

Reviewed-by: Georgi Djakov <gdjakov@mm-sol.com>
