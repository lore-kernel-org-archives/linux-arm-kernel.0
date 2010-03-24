From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 24 Mar 2010 08:10:38 +0100
Subject: Device probe order (i2c regulator vs. platform device)
Message-ID: <E4D3F24EA6C9E54F817833EAE0D912AC09C80E05C7@bssrvexch01.BS.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I've encountered a problem with regulator framework and the device probe order. In my system there is a pmic chip connected thought i2c bus and a platform device (let's call it A) that depends on the regulator device (for proper probing pmic chip must enable voltage to the device A). In the current configuration the i2c driver is also a platform device. However during the system initialization the device A is probed before the i2c driver would register pmic chip and its regulators.

How I can delay probing the device A to the moment when the regulator device will be available in the system? Is there any generic was of changing the device probe order? 

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
