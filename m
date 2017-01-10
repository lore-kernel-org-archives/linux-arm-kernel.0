From: jic23@kernel.org (jic23 at kernel.org)
Date: Tue, 10 Jan 2017 14:21:01 +0000
Subject: [PATCH 2/3 v2] iio: adc: break out common code from SPMI VADC
In-Reply-To: <CACRpkdZUk6UUN2ACXp0S1RW7k2M5t5X5N_0mJQeo_UTEa4H=9w@mail.gmail.com>
References: <1481842105-14047-1-git-send-email-linus.walleij@linaro.org>
 <717ea1c4-33af-f0ca-e018-5d7ac87506e1@kernel.org>
 <CACRpkdZUk6UUN2ACXp0S1RW7k2M5t5X5N_0mJQeo_UTEa4H=9w@mail.gmail.com>
Message-ID: <b6c65ca47a69bc83fce28ec8bb44dfa1@jic23.retrosnub.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.01.2017 08:54, Linus Walleij wrote:
> On Fri, Dec 30, 2016 at 8:01 PM, Jonathan Cameron <jic23@kernel.org> 
> wrote:
>> On 15/12/16 22:48, Linus Walleij wrote:
>>> The SPMI VADC and the earlier XOADC share a subset of
>>> common code, so to be able to use the same code in both
>>> drivers, we break out a separate file with the common code,
>>> prefix exported functions that are no longer static with
>>> qcom_* and bake an object qcom-vadc.o that contains both
>>> files: qcom-vadc-common.o and qcom-spmi-vadc.o.
>>> 
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Cc: linux-arm-msm at vger.kernel.org
>>> Cc: Ivan T. Ivanov <iivanov.xz@gmail.com>
>>> Cc: Andy Gross <andy.gross@linaro.org>
>>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>>> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> 
>> Looks superficially fine, but I'm guessing will need a respin
>> as we have a fair bit of new stuff (and a couple of fixes) going
>> through this driver at the moment.
>> 
>> All but the two fixes I posted a few mins ago are in my testing
>> branch and should go to Greg once I have confirmed testing on
>> those two fixes.
> 
> I looked at the git and "testing"
> contains a top commit named "guessing" fixing some 64bit
> artithmetic (which looks correct) in the driver, shall I simply
> rebase on top of that and hope for the best? :)
I'm an idiot and pushed out the wrong branch.  Will fix up when
I get home and push one with a sensible patch title!
(It'll be the same content though - feel free to Ack that if
you like ;)

Not my best half asleep patch writing ;)

Jonathan
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
