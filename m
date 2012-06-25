From: rob.lee@linaro.org (Rob Lee)
Date: Sun, 24 Jun 2012 23:49:49 -0500
Subject: [PATCH v5 0/7] cleanup imx5 idle, add imx5/6 cpuidle
In-Reply-To: <CAMXH7KGh2RrzTy9+mcYAfbQgcVC0H9=ozXzBb-wCho51pM6CVg@mail.gmail.com>
References: <1337640630-29176-1-git-send-email-rob.lee@linaro.org>
 <20120620103004.GA13194@pengutronix.de>
 <CAMXH7KGh2RrzTy9+mcYAfbQgcVC0H9=ozXzBb-wCho51pM6CVg@mail.gmail.com>
Message-ID: <CAMXH7KHthCK+vP2H0Y86C9vRk3ZOqJXbgEBSCZx0E2LpmO=i5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 9:15 AM, Rob Lee <rob.lee@linaro.org> wrote:
> Hello Sascha,
>
> On Wed, Jun 20, 2012 at 5:30 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> Hi Robert,
>>
>> On Mon, May 21, 2012 at 05:50:23PM -0500, Robert Lee wrote:
>>> Cleanup up imx5 idle code and enable imx5 low powe idle for imx53.
>>>
>>> Add common imx cpuidle initialization functionality and add a i.MX5 and i.MX6Q
>>> platform cpuidle implementation.
>>
>> I rebased this to 3.5-rc1 here:
>>
>> git.pengutronix.de/git/imx/linux-2.6.git imx/cpuidle
>>
>> Could you check if the result is ok with you?
>>
>
> Certainly. ?I will let you know in a day or two.
>

I did some basic testing and everything looks ok as far as idle and
cpuidle goes.  For imx51 and 53 I tested both device tree and
non-device tree boot.  On my imx51-babbage board, a generic
imx_v6_v7_defconfig does not boot without enabling device tree and
shows no output after the u-boot messages.  But this also occurs on
the kernel.org v3.5-rc3.  Removing support for all boards except
imx51-babbage makes it boot up ok.  The idle changes don't seem to
affect this behavior.

> Rob
>
>> Sascha
>>
>>
>> --
>> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
>> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
>> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
