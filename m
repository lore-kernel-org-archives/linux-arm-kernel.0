From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Fri, 13 Jun 2014 12:09:15 +0200
Subject: [PATCH] i2c: sun6-p2wi: fix call to snprintf
In-Reply-To: <20140613095714.GP23430@n2100.arm.linux.org.uk>
References: <CAGXu5jLi5NXNsbUAn=XndDb2JSTxiVhMWbiMxtDsUOqZZhxf2A@mail.gmail.com>
 <1402644002-2591-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140613095714.GP23430@n2100.arm.linux.org.uk>
Message-ID: <539ACDCB.7010209@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 13/06/2014 11:57, Russell King - ARM Linux wrote:
> On Fri, Jun 13, 2014 at 09:20:02AM +0200, Boris BREZILLON wrote:
>> -	snprintf(p2wi->adapter.name, sizeof(p2wi->adapter.name), pdev->name);
>> +	snprintf(p2wi->adapter.name, sizeof(p2wi->adapter.name), "%s",
>> +		 pdev->name);
> Isn't this just a complicated way to express:
>
> 	strlcpy(p2wi->adapter.name, pdev->name, sizeof(p2wi->adapter.name));
>
> ?

Yes it is. I'll make use of strlcpy instead.

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
