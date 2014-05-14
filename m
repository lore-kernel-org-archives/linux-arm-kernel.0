From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 14 May 2014 17:51:36 +0200
Subject: [RFC PATCH 2/9] dt: deps: dependency based device creation
In-Reply-To: <20140514140534.897F8C4153D@trevor.secretlab.ca>
References: <1399913280-6915-1-git-send-email-holler@ahsoftware.de>	<1399913280-6915-3-git-send-email-holler@ahsoftware.de>
 <20140514140534.897F8C4153D@trevor.secretlab.ca>
Message-ID: <53739108.40209@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 14.05.2014 16:05, schrieb Grant Likely:

>> +
>> +	if (graph.finished)
>> +		return -EINVAL; /* cycle found */
>> +
>> +	/* of_init_print_order(); */
>
> If you wrap of_init_print_order with a #ifdef DEBUG/#else/#endif, then
> you don't need to comment out the call to of_init_print_order().

To explain why I didn't use DEBUG here: DEBUG enables a lot of 
distracting messages. which is true for CONFIG_DEBUG_DRIVER too. 
Therefor I often prefer to use just pr_info("AHO: ..."); with which I 
print only stuff I want (and can easily grep for).

And as said, the patches I presented are meant for evaluation. I did 
patches without discussing them before in order to avoid endless 
discussion which likely never would have found an end and therfor would 
have prevented a start. So now you already have some to play and test 
with, without anyone had to discuss stuff before. ;)

Regards,

Alexander Holler
