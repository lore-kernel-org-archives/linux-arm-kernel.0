From: robherring2@gmail.com (Rob Herring)
Date: Mon, 3 Feb 2014 14:11:28 -0600
Subject: [PATCH 1/2] clocksource: sunxi: Add new compatibles
In-Reply-To: <20140203194505.GF25625@lukather>
References: <1391348280-9484-1-git-send-email-maxime.ripard@free-electrons.com>
 <52EFC573.2050302@linaro.org> <20140203194505.GF25625@lukather>
Message-ID: <CAL_JsqJuSS1Hh8Fb26PMKBB_uKmLuiqnZJjz0zvt1Ux7P8cCzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 3, 2014 at 1:45 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Daniel,
>
> (Adding DT mailing-list in CC)
>
> On Mon, Feb 03, 2014 at 05:36:03PM +0100, Daniel Lezcano wrote:
>> On 02/02/2014 02:37 PM, Maxime Ripard wrote:
>> >The Allwinner A10 compatibles were following a slightly different compatible
>> >patterns than the rest of the SoCs for historical reasons. Add compatibles
>> >matching the other pattern to the timer driver for consistency, and keep the
>> >older one for backward compatibility.
>>
>> Hi Maxime,
>>
>> is it really needed to keep the old pattern ?
>
> We agreed during the ARM Kernel Summit to consider the DT as a stable
> ABI.
>
> While I'd be ok with removing the older ones, that also means that we
> would break the boot of newer kernels with older DT, so yes, we
> actually need to keep the old compatibles.

It all depends if that would really cause problems for a given
platform. So if Allwinner DT support is a moving target, then changing
is probably okay. For example, if anyone using the platform is going
to need to update their DTB to add more nodes to get various features
anyway, then breaking it is not all that important.

Rob
