From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 3 Sep 2014 06:37:42 -0700
Subject: [PATCH] mmc: sdhci-msm: Make tuning block table endian agnostic
In-Reply-To: <CAPDyKFoboJGTzF3aQ=YBpWyVT6opTMgz_6gpOo5BRX30+hfCBQ@mail.gmail.com>
References: <1409702308-3023-1-git-send-email-sboyd@codeaurora.org>
 <CAPDyKFoboJGTzF3aQ=YBpWyVT6opTMgz_6gpOo5BRX30+hfCBQ@mail.gmail.com>
Message-ID: <20140903133742.GB28256@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03, Ulf Hansson wrote:
> On 3 September 2014 01:58, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > If we're tuning on a big-endian CPU we'll never determine we properly
> > tuned the device because we compare the data we received from the
> > controller with a table that assumes the CPU is little-endian.
> > Change the table to be an array of bytes instead of 32-bit words
> > so we can use memcmp() without needing to byte-swap every word
> > depending on the endianess of the CPU.
> >
> > Cc: Asutosh Das <asutoshd@codeaurora.org>
> > Cc: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> > Cc: Georgi Djakov <gdjakov@mm-sol.com>
> > Fixes: 415b5a75da43 "mmc: sdhci-msm: Add platform_execute_tuning implementation"
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> Hi Stephen,
> 
> If you want me to pick this up, please repost to linux-mmc as well.
> Otherwise you have my ack for it!
> 

Ok I'll repost it now.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
