From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Sep 2014 11:02:58 -0700
Subject: [PATCH] bus: arm-ccn: Fix spurious warning message
In-Reply-To: <1410791628-30038-1-git-send-email-pawel.moll@arm.com>
References: <1410791628-30038-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20140924180258.GD19284@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 03:33:48PM +0100, Pawel Moll wrote:
> Because CCN's cycle counter always runs, it will generate
> an interrupt on overflow even if the relevant perf event
> was not requested, causing a spurious warning message.
> 
> Fixed now by warning on only normal counter unwanted
> overflows. Also cleaning the overflow mask at init now,
> not to warn on event previously requested by firmware.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Thanks, applied to fixes-non-critical.


-Olof
