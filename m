From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 28 Mar 2012 17:07:03 +0530
Subject: [PATCH] ARM: Samsung: Make PM_GENERIC_DOMAINS config depend on
 CONFIG_PM
In-Reply-To: <20120328113419.GM3232@opensource.wolfsonmicro.com>
References: <1332843404-25476-1-git-send-email-thomas.ab@samsung.com>
 <20120328105122.GF3232@opensource.wolfsonmicro.com>
 <CAJuYYwQgZqN6nguddjS6bjLhx_ZhUZ5AfcrSAKBa7Ft-Bn6wPQ@mail.gmail.com>
 <20120328113419.GM3232@opensource.wolfsonmicro.com>
Message-ID: <CAJuYYwRR6eo8LruyOtyi3Sp96jydRvPFhMnbF6wfk55eM-zjbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 March 2012 17:04, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Mar 28, 2012 at 04:51:32PM +0530, Thomas Abraham wrote:
>> On 28 March 2012 16:21, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
>
>> > What's the underlying issue here? ?This seems like something the PM core
>> > should be dealing with gracefully...
>
>> The PM_GENERIC_DOMAINS config option has dependency on CONFIG_PM
>> option. When building with PM disabled, the following errors occur.
>
> Right, this does seem like something which it'd be better to handle
> more gracefully in the PM core.

Ok. Selecting PM_GENERIC_DOMAINS without checking for dependency on PM
did not seem correct.
