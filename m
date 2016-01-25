From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Mon, 25 Jan 2016 18:51:59 +0600
Subject: [PATCH 1/3] printk: make preferred_console local static bool
In-Reply-To: <1453725901.28952.53.camel@perches.com>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
 <1453722324-22407-2-git-send-email-aleksey.makarov@linaro.org>
 <1453725901.28952.53.camel@perches.com>
Message-ID: <56A61A6F.10409@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25.01.2016 18:45, Joe Perches wrote:
> On Mon, 2016-01-25 at 17:45 +0600, Aleksey Makarov wrote:
>> The variable preferred_console is used only inside register_console()
>> and it's semantics is boolean.  Make it clear.
>
> This loses the index of the preferred console.
> I'm not sure this is better.

That index is not used anywhere.  I believe the patch makes things clear.

Also, it indexes the array console_cmdline.  With introduction of the 
ACPI-selected console it does not have any sense and I would have to 
change it anyway.

Thank you
Aleksey Makarov
