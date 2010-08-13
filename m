From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 13 Aug 2010 13:17:53 +0200
Subject: [RFC 9/9] crypto: Add Samsung crypto engine driver
In-Reply-To: <20100812.153208.48514514.davem@davemloft.net>
References: <4C129341.2060407@gmail.com>	<AANLkTi=FKAdC9AwPR41MUBUjBZ2Zf1qv1DSQ+EnMHu7d@mail.gmail.com>	<4C63DF4C.1020501@gmail.com>
	<20100812.153208.48514514.davem@davemloft.net>
Message-ID: <4C6529E1.8020300@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Op 13-08-10 00:32, David Miller schreef:
> From: Maurus Cuelenaere <mcuelenaere@gmail.com>
> Date: Thu, 12 Aug 2010 13:47:24 +0200
>
>> The main issues still remain (DMA not working at all and FIFO not
>> working for some (T)DES transfers). Additionally, I couldn't get
>> tcrypt to test the s3c-sss driver for some reason, it always picked
>> the standard AES/TDES/DES driver (even though s3c-sss has a higher
>> priority and succeeded the self-test).
> I forget the details of your driver, but were your encryption algorithms
> implemented async?

Yes, all are async (also the not-yet-working hash algorithms).

> tcrypt can validate async crypto algorithms, but cannot performance
> test them just yet.  I can performance test async hash algorithms,
> for which I added the code for a few months ago.
Hmm ok, I suppose implementing support for performance testing async crypto
algorithms isn't trivial?

-- 
Maurus Cuelenaere
