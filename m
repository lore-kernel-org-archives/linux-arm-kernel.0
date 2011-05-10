From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Tue, 10 May 2011 15:23:18 +0530
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver.
In-Reply-To: <201105051612.18522.arnd@arndb.de>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024CD0B8CC@dbde02.ent.ti.com>
	<613E2AF627DE4ABE92AD42D5D9E1BFE5@subhasishg>
	<201105051612.18522.arnd@arndb.de>
Message-ID: <FBFC0000E34D487086421780A0F5252A@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Instead of passing a configuration file into the MFD driver and
> calling it a firmware, I can see three other options that I believe
> would be nicer:
> 
> 1. have a single firmware blob that describes the child devices
> and the code that is to be loaded into both units. If they are
> acting as one device, either make sure you only create one
> child node, or create one with a name that no driver binds to.
> 
> 2. Call request_firmware separately for the two child devices,
> and configure them separately based on the information in the
> firmware files. In the case where they should act as a single
> device, call the children e.g. "pruss-uart-a" and "pruss-uart-b",
> then bind to both names in the pruss-uart drivers and only
> start using the device when you have both nodes for the same
> parent.
> 
> 3. Do the configuration through sysfs files in the MFD device node,
> which then cause the creation of the child devices. This means you
> need extra user space scripts to write the addititonal files, but
> is also the most flexible way.
> 

Are you suggesting something like:

/sys..../pruss/pru0/id
/sys..../pruss/pru0/fw_name
/sys..../pruss/pru0/load

/sys..../pruss/pru1/id
/sys..../pruss/pru1/fw_name
/sys..../pruss/pru1/load

I can program these configs and store them in the pru private.
Then write something into load.
This can load the PRU based upon the configs.
But, I am not sure how to do this effectively using sysfs,
I mean I don't want to end up writing six write and six read
handlers. 
