From: tj@kernel.org (Tejun Heo)
Date: Mon, 24 Feb 2014 20:40:48 -0500
Subject: [PATCH v13 2/3] ata: Add APM X-Gene SoC AHCI SATA host
 controller driver
In-Reply-To: <CAPw-ZT=VHj+fO-7+G6Zdx+T+osJhXaR9AYHbx_TbWFWHBiDKYg@mail.gmail.com>
References: <1393221265-13057-1-git-send-email-lho@apm.com>
 <1393221265-13057-2-git-send-email-lho@apm.com>
 <1393221265-13057-3-git-send-email-lho@apm.com>
 <20140224183129.GA2522@htj.dyndns.org>
 <CAPw-ZT=VHj+fO-7+G6Zdx+T+osJhXaR9AYHbx_TbWFWHBiDKYg@mail.gmail.com>
Message-ID: <20140225014048.GA3450@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey,

On Mon, Feb 24, 2014 at 05:02:52PM -0800, Loc Ho wrote:
> The completion of the RAM removal from shutdown is quite fast. As per
> spec, the max time is 1ms but from the run-time code, it only take one
> (1us) or two (2us) read for this to completed. An 1 ms hard delay is more
> than 100 time slower. The code isn't that complex. If you strongly advise
> that I should remove the while loop and use 1 ms, then okay. Otherwise, I
> would prefer to keep the original code.

The code is rather silly because as it's written the delay may be upto
100ms.  If it's sitting in the hot path, using things like
usleep_range() makes sense.  In probe / shutdown paths, it's just an
unnecessary distraction.  If the timeout is as short as 1ms, it
doesn't really matter whether the hardware can do it faster or not.
It's just irrelevant.  Please just write simple code.

Thanks.

-- 
tejun
