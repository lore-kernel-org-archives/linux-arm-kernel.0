From: hlovdal@gmail.com (=?UTF-8?B?SMOla29uIEzDuHZkYWw=?=)
Date: Mon, 2 Nov 2009 22:13:40 +0100
Subject: [PATCH 5/7] S3C64XX: Add platform data and driver resources for
	IDE controller driver.
In-Reply-To: <20091101130502.GI8096@trinity.fluff.org>
References: <1257051403-8146-1-git-send-email-thomas.ab@samsung.com>
	<20091101130502.GI8096@trinity.fluff.org>
Message-ID: <a01a16b50911021313h681bac38pdeea996a3e3cfb81@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/11/1 Ben Dooks <ben-linux@fluff.org>:
> On Sun, Nov 01, 2009 at 01:56:43PM +0900, Thomas Abraham wrote:
>> + ? ? if (!pd) {
>> + ? ? ? ? ? ? printk(KERN_ERR "%s: no memory for platform data\n", __func__);
>> + ? ? ? ? ? ? return;
>> + ? ? }
>> + ? ? s3c_device_cfcon.dev.platform_data = pd;
>
> doing:
>
> ? ? ? ?if (!pd)
> ? ? ? ? ? ? ? ?printk(KERN_ERR "%s: no memory for platform data\n", __func__);
> ? ? ? ?else
> ? ? ? ? ? ? ? ?s3c_device_cfcon.dev.platform_data = pd;
>
> would be better.

I do not quite understand why this would be better. In the former case
the normal operation (e.g. s3c_dev... = pd;) is written directly without
any extra indentation and is not buried (deep) down in some error handling.

Writing code in that style makes it very easy to read with a mental filter like

     if (test) {
             ERROR HANDLING, ERROR HANDLING, ERROR HANDLING, ERROR HANDLING;
             return;
     }
     NORMAL CASE, NORMAL CASE, NORMAL CASE, ;

See also http://stackoverflow.com/questions/114342/what-are-code-smells-what-is-the-best-way-to-correct-them/223881#223881.

BR H?kon L?vdal
