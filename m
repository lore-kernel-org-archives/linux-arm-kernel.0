From: tj@kernel.org (Tejun Heo)
Date: Fri, 8 Jan 2016 11:50:43 -0500
Subject: [PATCH 4/4] libata: skip debounce delay on link resume
In-Reply-To: <1452211413-1350-5-git-send-email-f.fainelli@gmail.com>
References: <1452211413-1350-1-git-send-email-f.fainelli@gmail.com>
 <1452211413-1350-5-git-send-email-f.fainelli@gmail.com>
Message-ID: <20160108165043.GT1898@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 07, 2016 at 04:03:33PM -0800, Florian Fainelli wrote:
> From: Danesh Petigara <dpetigara@broadcom.com>
> 
> The link resume logic uses a 200msec delay while debouncing
> the SControl register. The rationale behind that delay is
> to accommodate some PHYs that behave badly if their SStatus/
> SControl registers are pounded immediately on resume.
> The Broadcom STB SATA PHY does not seem to have this issue.
> This patch introduces a new link flag that allows platforms
> to skip the debounce delay if it isn't needed.
> 
> Signed-off-by: Danesh Petigara <dpetigara@broadcom.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to libata/for-4.5.

Thanks.

-- 
tejun
