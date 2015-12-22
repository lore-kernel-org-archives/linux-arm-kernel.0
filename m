From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Dec 2015 11:44:16 -0800
Subject: [PATCH 0/2] bus: sunxi-rsb: fix primary PMIC and peripheral IC
 address mapping
In-Reply-To: <1450257286-1645-1-git-send-email-wens@csie.org>
References: <1450257286-1645-1-git-send-email-wens@csie.org>
Message-ID: <20151222194416.GA30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 05:14:44PM +0800, Chen-Yu Tsai wrote:
> Hi Arnd, Olof,
> 
> Here are 2 fixes for the sunxi-rsb driver. There were some typos in the
> hardware address mapping table, but as long as the assigned address
> matched what the bootloader used, it still worked fine. The only
> indication was "failed to set runtime address" error messages which I
> mistook for some hardware quirk.
> 
> I looked deeper when the AC100 on my A80 boards refused to respond.
> 
> Patch 1 fixes the hardware address for primary PMICs (AXP223, AXP809...).
> This is the part that still worked fine despite the error because the
> runtime address matches the one set by the bootloader.
> 
> Patch 2 fixes the assigned runtime address for the peripheral IC
> (AC100/AC200). This part does not work due to the runtime address being
> invalid.
> 
> Maxime asked me to send them directly to you. Please pick them up for 4.4.

Applied, thanks.

In the future, for fixes late in the cycle like this, please describe in a few
words in the commit message just what the error is for someone trying to use
kernel without the fix, so someone just reading the changelog can determine if
it's a high-priority fix or not.


Thanks!


-Olof
