From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 22 May 2013 13:47:31 +0100
Subject: [RC FIXES] Fix broken MMC devices on Snowball
Message-ID: <1369226853-16978-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly introduced ab8500 external regulator driver causes an
unexpected quirk when used with the Snowball low-cost development
board. When the 3 ab8500 external regulators are registered, the
ones which can be freed, are. Unfortunately, on Snowball one of
them is connected to the MMC power line. Once freed, this turns
off the MMC device. External regulators are not used on Snowball,
so it's pointless registering them in the first place.

These two patches ensure external regulators aren't registered 
on Snowball or any other platforms which do not require them.
