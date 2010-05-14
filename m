From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 May 2010 15:25:19 +0100
Subject: Should we pass amba device peripheral id with device structure
	or not?
In-Reply-To: <4BECF57A.4050802@st.com>
References: <4BECF57A.4050802@st.com>
Message-ID: <1273847119.28312.30.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-05-14 at 08:02 +0100, Viresh KUMAR wrote:
> amba_device_register function reads and updates peripheral id from hardware
> registers, whenever we register any amba device. If clock to device is disabled,
> then amba_device_register will not be able to read and update this value.
> 
> Thus device registration will fail. Now we can also pass peripheral
> id with the device structure, which will let it pass.
> But i remember in SPEAr patches review, i got this comment to remove
> peripheral id from device structure as it will be populated
> automatically.

The peripheral id is usually only present in PrimeCell devices and it's
not a feature of the AMBA bus. So if your device doesn't have such id
(or it isn't readable) I think it makes sense to pass one in the
amba_device structure.

-- 
Catalin
