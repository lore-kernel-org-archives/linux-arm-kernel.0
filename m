From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Thu, 12 Aug 2010 13:47:24 +0200
Subject: [RFC 9/9] crypto: Add Samsung crypto engine driver
In-Reply-To: <AANLkTi=FKAdC9AwPR41MUBUjBZ2Zf1qv1DSQ+EnMHu7d@mail.gmail.com>
References: <cover.1276284559.git.mcuelenaere@gmail.com>	<4C129341.2060407@gmail.com>
	<AANLkTi=FKAdC9AwPR41MUBUjBZ2Zf1qv1DSQ+EnMHu7d@mail.gmail.com>
Message-ID: <4C63DF4C.1020501@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hi,

Op 03-08-10 06:44, Kyungmin Park schreef:
> Hi,
>
> Any update on this?

Sorry for the late reply.

The current (functional) status of the driver doesn't differ much from the original one. I've reworked the crypto request handling code like David suggested and started adding support for (HMAC) SHA-1 acceleration.

The main issues still remain (DMA not working at all and FIFO not working for some (T)DES transfers). Additionally, I couldn't get tcrypt to test the s3c-sss driver for some reason, it always picked the standard AES/TDES/DES driver (even though s3c-sss has a higher priority and succeeded the self-test).

-- 
Maurus Cuelenaere
