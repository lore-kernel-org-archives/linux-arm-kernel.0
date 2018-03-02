From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 2 Mar 2018 15:26:56 +0300
Subject: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
In-Reply-To: <20180302121929.GY9418@n2100.armlinux.org.uk>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302111931.GX9418@n2100.armlinux.org.uk>
 <20180302114909.u6kqdszt3aew2io2@mwanda>
 <20180302121929.GY9418@n2100.armlinux.org.uk>
Message-ID: <20180302122655.uckejonjyzt4vjd3@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ok, but in that case the original code is still wrong because it returns
early with success.  I guess it could be changed to:

	if (irq <= 0)
		return -ENXIO;

regards,
dan carpenter
