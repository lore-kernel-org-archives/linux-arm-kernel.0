From: davidb@codeaurora.org (David Brown)
Date: Tue, 15 Feb 2011 15:49:04 -0800
Subject: [RFC] MMC: error handling improvements
In-Reply-To: <20110215230311.GT4152@n2100.arm.linux.org.uk> (Russell King's
	message of "Tue, 15 Feb 2011 23:03:11 +0000")
References: <20110215230311.GT4152@n2100.arm.linux.org.uk>
Message-ID: <8yaoc6c7tan.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15 2011, Russell King - ARM Linux wrote:

> This patch is for RFC only; it needs splitting up somewhat.  However, I
> wanted to get it out there for some comment.

Just for kicks, I applied this and ran it on an MSM target (8x50).  It
seems to cause lots of:

  mmc0: Data timeout
  mmc0: Controller has been re-initialized
  ...
  mmc0: Data CRC error

and I can post more if you would find them interesting.  Eventually the
MSM mmc driver derefernces a null pointer in the interrupt code.

It's also possible this is finding problems in our SDCC driver.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
