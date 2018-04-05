From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Thu, 5 Apr 2018 18:11:25 -0500
Subject: [PATCH] clk: samsung: s3c: Mark expected switch fall-through
In-Reply-To: <152295987121.91052.16578276622043986934@swboyd.mtv.corp.google.com>
References: <20180404010931.GA30291@embeddedor.com>
 <152295987121.91052.16578276622043986934@swboyd.mtv.corp.google.com>
Message-ID: <4d52473e-019a-58da-c475-49bcd16c2ed4@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/05/2018 03:24 PM, Stephen Boyd wrote:
> Quoting Gustavo A. R. Silva (2018-04-03 18:09:31)
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> Notice that in this particular case I replaced the comma wiht a dash,
> 
> s/wiht/with/
> 

Thanks for this.

>> which is what GCC is expecting to find when there are other comments
>> in the same line in which "fall through" appears.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>> This code was compiled with GCC 7.3.0
> 
> What's the GCC warning? Please include in the commit text.
> 

drivers/clk/samsung/clk-s3c2443.c:430:3: warning: this statement may 
fall through [-Wimplicit-fallthrough=]
    samsung_clk_register_alias(ctx, s3c2450_aliases,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      ARRAY_SIZE(s3c2450_aliases));
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/clk/samsung/clk-s3c2443.c:433:2: note: here
   case S3C2416:
   ^~~~


> Also what's the implicit-fallthrough level you're using? 3? Can you file
> a bug so GCC can update their regex to accept a comma in addition to
> whitespace characters?
> 

Yeah, I can talk to the GCC guys about that.

> And maybe we can change the level to 2 or 1 in the kernel's makefile so
> we don't need to patch comments for this.
> 

Yeah, with level 2 I don't get that warning.

Thanks
--
Gustavo
