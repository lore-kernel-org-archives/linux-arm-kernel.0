From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Tue, 30 Oct 2012 22:33:53 +0100
Subject: [PATCH 1/4] net: davinci_mdio: Fix typo mistake in calling
 runtime-pm api
In-Reply-To: <1351498881-32482-3-git-send-email-hvaibhav@ti.com> (Vaibhav
 Hiremath's message of "Mon, 29 Oct 2012 13:51:18 +0530")
References: <1351498881-32482-1-git-send-email-hvaibhav@ti.com>
 <1351498881-32482-3-git-send-email-hvaibhav@ti.com>
Message-ID: <877gq7hcfy.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Vaibhav" == Vaibhav Hiremath <hvaibhav@ti.com> writes:

 Vaibhav> By mistake (most likely a copy-paste), instead of pm_runtime_get_sync()
 Vaibhav> api, driver is calling pm_runtime_put_sync() api in resume callback
 Vaibhav> function. The bug was introduced by commit id (ae2c07aaf74:
 Vaibhav> davinci_mdio: runtime PM support).

 Vaibhav> Now, the reason why it didn't impact functionality is, the patch has
 Vaibhav> been tested on AM335x-EVM and BeagleBone platform while submitting;
 Vaibhav> and in case of AM335x the MDIO driver doesn't control the module
 Vaibhav> enable/disable part, which is handled by CPSW driver.

 Vaibhav> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
 Vaibhav> Cc: Mugunthan V N <mugunthanvnm@ti.com>
 Vaibhav> Cc: Richard Cochran <richardcochran@gmail.com>

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
