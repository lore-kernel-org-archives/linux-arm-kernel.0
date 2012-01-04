From: rob.lee@linaro.org (Rob Lee)
Date: Wed, 4 Jan 2012 17:21:47 -0600
Subject: [RFC PATCH v2 1/2] cpuidle: Add common init interface and idle
 functionality
In-Reply-To: <20111222180923.GH29622@opensource.wolfsonmicro.com>
References: <1323846126-7516-1-git-send-email-rob.lee@linaro.org>
 <1323846126-7516-2-git-send-email-rob.lee@linaro.org>
 <20111222180923.GH29622@opensource.wolfsonmicro.com>
Message-ID: <CAMXH7KEgPg2F-Trioo+9w9nRuX081jKF8y_Re7mFLxn2-dWutg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark, thanks again for your review.  Will fix the indention in v3.

On 22 December 2011 12:09, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Dec 14, 2011 at 01:02:05AM -0600, Robert Lee wrote:
>> The patch adds some cpuidle initialization functionality commonly
>> duplicated by many platforms. ?The duplicate cpuidle init code of
>> various platfroms has been consolidated to use this common code
>> and successfully rebuilt.
>>
>> Signed-off-by: Robert Lee <rob.lee@linaro.org>
>
> Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> This looks good to me with one small comment:
>
>> +int cpuidle_def_idle(struct cpuidle_device *dev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct cpuidle_driver *drv, int index) {
>> + ? ? cpu_do_idle();
>> + ? ? return index;
>> +}
>
> Odd indentation here.
>
> I'll move my s3c64xx cpuidle code over to this, though I think it'll end
> up being an incremental patch as Kukjin just said he'd apply it and it'd
> be nice to get the support into 3.3 if we can.
