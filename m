From: s-anna@ti.com (Suman Anna)
Date: Mon, 19 Feb 2018 18:06:59 -0600
Subject: syscon regmap for disabled node?
In-Reply-To: <CAK8P3a25wQiCreFB3qBuyE86GvwmjpZmqyTszF-ZBJRDPwHotQ@mail.gmail.com>
References: <e9863f03-f1b5-9158-76f3-37158a0b4cd4@ti.com>
 <CAK8P3a25wQiCreFB3qBuyE86GvwmjpZmqyTszF-ZBJRDPwHotQ@mail.gmail.com>
Message-ID: <112b03a1-8f2d-dddf-529c-e70561722722@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/17/2018 01:51 PM, Arnd Bergmann wrote:
> On Sat, Feb 17, 2018 at 2:40 AM, Suman Anna <s-anna@ti.com> wrote:
>> Hi Pankaj, Arnd, Lee,
>>
>> I am testing some code to use a syscon/regmap interface and I find that
>> the syscon/regmap is initialized even on a disabled device node using a
>> "syscon" compatible property when I have expected it to fail. Prior to
>> commit bdb0066df96e ("mfd: syscon: Decouple syscon interface from
>> platform devices"), the driver would have never probed, and the
>> of_syscon_register() only checks for the compatible, but not if the
>> device node is available. Is this intentional or a bug?
> 
> My guess would be that nothing relies on the current behavior and that
> it could be changed if it causes problems, but it's hard to tell for the general
> case.
> 
> Can you describe why you have a disabled syscon node? Most uses of the
> status property are for on-chip devices that we disable because nothing is
> connected to them, but that seems unlikely for a syscon.

I am just testing the failure paths in my code by specifically disabling
the syscon node, and to my surprise, the code went through fine when I
had expected the syscon_node_to_regmap() call to fail.

regards
Suman
