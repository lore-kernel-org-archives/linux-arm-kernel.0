From: stillcompiling@gmail.com (Joshua Clayton)
Date: Tue, 17 Nov 2015 11:28:29 -0800
Subject: [PATCH 3/8] Documentation/spi/spidev_test.c: accept input from a
 file
In-Reply-To: <564B716E.5020605@gmail.com>
References: <cover.1447773299.git.stillcompiling@gmail.com>
 <d90d749776cf562bc9922aff5e97cb911a77b22b.1447773299.git.stillcompiling@gmail.com>
 <564B716E.5020605@gmail.com>
Message-ID: <5345438.ORMdKP6N7u@jclayton-pc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 17, 2015 07:26:54 PM Anton Bondarenko wrote:
> On 17.11.2015 16:24, Joshua Clayton wrote:
> > +	if (sb.st_size > 4096)
> > +		pabort("input file exceeds spidev's 4k limit");
> This is not a true. IIRC PAGE_SIZE is the default buffer size for 
> spidev, but can be changed using bufsiz module parameter.
> Just 'insmod spidev bufsiz=X', where X is number of bytes.

You are right. I will drop this. As Mark suggests.
The ioctl gives a nice error code if the buffer is too big.

...
> > +	tx = malloc(sb.st_size);
> It would be good to check new allocations for fail.

I will add a check for this. 

-- 
~Joshua Clayton
