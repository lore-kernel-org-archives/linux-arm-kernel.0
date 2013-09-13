From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 13 Sep 2013 10:12:36 -0600
Subject: [PATCH] crypto: tegra: use kernel entropy instead of ad-hoc
In-Reply-To: <20130913122318.GD8579@gondor.apana.org.au>
References: <1378712154-30602-1-git-send-email-linus.walleij@linaro.org>
 <522DF0FC.5080200@wwwdotorg.org> <20130913122318.GD8579@gondor.apana.org.au>
Message-ID: <52333974.4040404@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2013 06:23 AM, Herbert Xu wrote:
> On Mon, Sep 09, 2013 at 10:02:04AM -0600, Stephen Warren wrote:
>> On 09/09/2013 01:35 AM, Linus Walleij wrote:
>>> The way I read the Tegra AES RNG is that it has a homebrew
>>> algorithm for initializing the 128bit RNG using timespec and
>>> the unique chip ID. This looks like reinventing the (square)
>>> wheel, instead just grab 128bits from the kernel entropy pool
>>> where the time and (after another patch) chip unique ID is
>>> already mixed in.
>>>
>>> Incidentally this also gets rid of a rather ugly
>>> cross-dependence on the machine using an extern declaration.
>>
>> This sounds reasonable to me, although I know little about the driver.
>> Varun, can you please comment?
>>
>> Acked-by: Stephen Warren <swarren@nvidia.com>
> 
> Patch applied.  Thanks.

I'm curious which kernel version it was merged for; it'd be nice to
remove tegra_chip_uid() from the Tegra tree now since it's unused, but
that obviously requires this patch in the history.
