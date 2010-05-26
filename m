From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 May 2010 20:14:25 +0100
Subject: [PATCH] sa1111: Prevent deadlock in resume path
In-Reply-To: <1274901104-22133-1-git-send-email-marek.vasut@gmail.com>
References: <1274901104-22133-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <20100526191425.GD6232@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 26, 2010 at 09:11:44PM +0200, Marek Vasut wrote:
> This patch reorganises the sa1111_resume() function in a manner the spinlock
> happens after calling the sa1111_wake(). This fixes two bugs:
> 
> 1) This function called sa1111_wake() which tried to claim the same spinlock
>    the sa1111_resume() already claimed. This would result in certain deadlock.
> 
>    Original idea for this part: Russell King <linux@arm.linux.org.uk>
> 
> 2) The function didn't unlock the spinlock in case the chip didn't report
>    correct ID.
> 
>    Original idea for this part: Julia Lawall <julia@diku.dk>
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Yea, good enough.
