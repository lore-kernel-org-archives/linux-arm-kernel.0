From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 09 Apr 2015 23:17:48 +0200
Subject: [RFC PATCH 4/5] arm64: smp: move the pen to a header file
In-Reply-To: <1428601031-5366-5-git-send-email-galak@codeaurora.org>
References: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
 <1428601031-5366-5-git-send-email-galak@codeaurora.org>
Message-ID: <6018110.XP6YK3PMra@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 April 2015 12:37:10 Kumar Gala wrote:
> From: Abhimanyu Kapur <abhimany@codeaurora.org>
> 
> Move the secondary_pen_release variable and the secondary_holding_pen
> entry function to asm/smp_plat.h so that the other cpu ops implementations
> can share them.
> 
> Signed-off-by: Abhimanyu Kapur <abhimany@codeaurora.org>
> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> 

I don't believe your SMP implementation can be so broken to require this.
Please fix the code instead to not use a holding pen.

	Arnd
