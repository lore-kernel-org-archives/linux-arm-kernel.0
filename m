From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 10 Sep 2018 09:53:49 +0100
Subject: [PATCH v2 11/16] nvmem: add support for cell info
In-Reply-To: <20180910093632.3a9337a9@bbrezillon>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <20180907100750.14564-12-brgl@bgdev.pl>
 <21ec4e6f-aa39-66cf-af32-d9e8e85f4961@linaro.org>
 <20180910093632.3a9337a9@bbrezillon>
Message-ID: <4c569813-aba0-8e9d-dfc8-653b6c2e365b@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/09/18 08:36, Boris Brezillon wrote:
>>> --- /dev/null
>>> +++ b/include/linux/nvmem-machine.h
>> This should go in nvmem-consumer.h, I don't think we should add header
>> files for each usecase. These are nvmem consumers so lets put them in
>> correct header file.
> Actually no, it should go in nvmem-provider.h. Consumer should not be
> allowed to define cells, only reference existing ones.The usecase can be provider and consumer.
In arm machine use case it is a consumer and it other use cases this can 
be a provider.

I agree with you, It makes more sense to be in nvmem-provider.h

thanks,
srini
> 
> Regards,
> 
> Boris
