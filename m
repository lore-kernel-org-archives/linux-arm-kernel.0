From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Thu, 02 May 2013 22:11:07 +0200
Subject: [PATCH 8/9] s3c2410fb: Remove redundant platform_set_drvdata()
In-Reply-To: <000001ce46f6$54f27cc0$fed77640$@samsung.com>
References: <1367006543-5458-1-git-send-email-sylvester.nawrocki@gmail.com>
 <1367006543-5458-9-git-send-email-sylvester.nawrocki@gmail.com>
 <000001ce46f6$54f27cc0$fed77640$@samsung.com>
Message-ID: <5182C85B.7090305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jingoo,

On 05/02/2013 07:31 AM, Jingoo Han wrote:
> On Saturday, April 27, 2013 5:02 AM, Sylwester Nawrocki wrote:
>> >  driver_data field is being cleared by the driver core since
>> >  commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
>> >  device-core: Ensure drvdata = NULL when no driver is bound
>> >  hence there is no need to do it in the driver's remove() callback.

> How about eliminating platform_set_drvdata(pdev, NULL)
> in s3c24xxfb_probe() as well as s3c2410fb_remove()?

Ah, thanks for pointing out. Indeed, that could be dropped too, I've
overlooked it somehow. Will update and resend this patch shortly.

Regards,
Sylwester
