From: hong.xu@atmel.com (Hong Xu)
Date: Mon, 19 Dec 2011 09:58:28 +0800
Subject: [PATCH 1/2] MTD: atmel_nand: Update Kconfig to support PMECC
In-Reply-To: <1324136016.4240.48.camel@sauron.fi.intel.com>
References: <1323327219-17895-1-git-send-email-hong.xu@atmel.com>
 <1323723514.2297.8.camel@koala> <4EE6A6DF.4@atmel.com>
 <4EE6B160.3000201@atmel.com> <1324136016.4240.48.camel@sauron.fi.intel.com>
Message-ID: <4EEE9A44.6080401@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2011 11:33 PM, Artem Bityutskiy wrote:
> On Tue, 2011-12-13 at 09:58 +0800, Hong Xu wrote:
>> PMECC is not compatible with the old HW ECC engine. It currently needs
>> around 700 lines of C code to make it work. If we do not have a way to
>> exclude the PMECC related code at compiling time, my quick testing shows
>> that the driver code size will be doubled if some old SoCs do not
>> support it. This sounds not good. What's your opinion?
>
> Well, depends on its size. Say, if it is about 8KiB - then doubling it
> is probably not a big deal.
>

Hmm.., not that big, less than 8KB. OK, I'll send out another patch 
removing the stuff modified in Kconfig.

Thanks!

BR,
Eric
