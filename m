From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri, 14 May 2010 12:32:18 +0530
Subject: Should we pass amba device peripheral id with device structure or not?
Message-ID: <4BECF57A.4050802@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

amba_device_register function reads and updates peripheral id from hardware
registers, whenever we register any amba device. If clock to device is disabled,
then amba_device_register will not be able to read and update this value.

Thus device registration will fail. Now we can also pass peripheral
id with the device structure, which will let it pass.
But i remember in SPEAr patches review, i got this comment to remove
peripheral id from device structure as it will be populated
automatically.

This is happening in our platform as we don't have separate control of
enabling/disabling interface and functional clocks of peripherals.

What should we do now? Enabling clocks from uboot doesn't looks a good idea.
Should we pass peripheral id with device structure only?

regards,
viresh kumar.
