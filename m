From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Wed, 11 May 2011 14:58:23 +0530
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver.
In-Reply-To: <201105102344.58598.arnd@arndb.de>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<201105051612.18522.arnd@arndb.de>
	<FBFC0000E34D487086421780A0F5252A@subhasishg>
	<201105102344.58598.arnd@arndb.de>
Message-ID: <82D549BB195345A1A189D569952B387C@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Please look into implementing one of the three I suggested before
> you go off in another direction. In case of the third one, the idea
> was to configure the name of the device for each pru using sysfs,
> which then gets bound to the driver, which loads its own firmware
> as you do today. Only in the first two suggestions, the mfd driver
> would be responsible for loading the firmware.

Ok, thanks for the clarification.
Instead of passing the device name, will it be ok to pass the mfd_id.
The benefit will be that I can use the ID directly as an array
index for the mfd_cell entries.

Just to verify my understanding, all that's needs to be done is add
a sysfs entry at 
/sys/devices/platform/pruss_mfd/mfd_id

Writing to this entry would create the respective device.
Rewriting would unload the old (mfd_remove_device)
and reload the new device.
Reading may return the various devices and their name
aliases.
 
