From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 15 Oct 2012 17:02:44 +0200
Subject: [PATCH v3 2/2] i2c: change id to let i2c-at91 work
In-Reply-To: <1350293428-24551-3-git-send-email-voice.shen@atmel.com>
References: <1350293428-24551-1-git-send-email-voice.shen@atmel.com>
 <1350293428-24551-3-git-send-email-voice.shen@atmel.com>
Message-ID: <20121015150244.GZ12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:30 Mon 15 Oct     , Bo Shen wrote:
> The i2c core driver will turn the platform device ID to busnum
> When using platfrom device ID as -1, it means dynamically assigned
> the busnum. When writing code, we need to make sure the busnum,
> and call i2c_register_board_info(int busnum, ...) to register device
> if using -1, we do not know the value of busnum
> 	
> In order to solve this issue, set the platform device ID as a fix number
> Here using 0 to match the busnum used in i2c_regsiter_board_info()
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> ---

can you check when this append for the first time to schedule a patch for stable too

Best Regards,
J.
