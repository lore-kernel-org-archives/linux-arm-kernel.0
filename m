From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 23 Sep 2014 10:51:36 -0700
Subject: [PATCH v1] soc: qcom: do not disable the iface clock in probe
In-Reply-To: <A61C4CA5-7558-4B3D-BF05-BBDD1C3F550F@codeaurora.org>
References: <1408081268-5748-1-git-send-email-srinivas.kandagatla@linaro.org>
 <A61C4CA5-7558-4B3D-BF05-BBDD1C3F550F@codeaurora.org>
Message-ID: <CAMAWPa8gxoUkNaB5x=cwM2WTRdECgMJuT-rVnwK7LPjHyKU6TA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 10:42 AM, Kumar Gala <galak@codeaurora.org> wrote:
>
> On Aug 15, 2014, at 12:41 AM, Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
>
>> The use case here is when we have a bootconsole which is printing the
>> characters on serial console and gsbi driver comes up after some time.
>> As gsbi driver disables the clock in probe the bootconsole locks up.
>>
>> This patch fixes the problem by disabling the clock in platform remove
>> rather than in probe.
>>
>> Tested-by: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>> Changes since RFC:
>>       - none, just a subject line change.
>
> Srini,
>
> We need some changes to the commit message for this to get into v3.17.
>
> Probably some references to:
>
> http://www.spinics.net/lists/linux-arm-msm/msg10589.html
>
> Adding Kevin to provide details on what else should be in commit message w/regards to the regression we introduced.

At this point of the cycle, we're rather strict about what qualifies
as a fix.  It should be fixing a specific regression.  Looking at the
above link, it looks like it is, so could you re-spin this with
changelog, summarizing the regression and how this fixes the
regression, and we should still be able to get it in for v3.17.

Also, it looks like the original was only posted to the msm list.  For
future reference, for patches that need to go via the arm-soc
maintainers, make sure to Cc arm at kernel.org.

Thanks,

Kevin
