From: robherring2@gmail.com (Rob Herring)
Date: Tue, 11 Sep 2012 07:02:58 -0500
Subject: [PATCH 07/12] ARM: move all dtb targets out of Makefile.boot
In-Reply-To: <20120907023955.GG26709@S2101-09.ap.freescale.net>
References: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
 <1346962375-26163-8-git-send-email-robherring2@gmail.com>
 <20120907022711.GE26709@S2101-09.ap.freescale.net>
 <50495DB9.5030008@wwwdotorg.org>
 <20120907023955.GG26709@S2101-09.ap.freescale.net>
Message-ID: <504F2872.8080609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2012 09:39 PM, Shawn Guo wrote:
> On Thu, Sep 06, 2012 at 08:36:41PM -0600, Stephen Warren wrote:
>> On 09/06/2012 08:27 PM, Shawn Guo wrote:
>>> On Thu, Sep 06, 2012 at 03:12:50PM -0500, Rob Herring wrote:
>>>> +dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb
>>>> +dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
>>>> +dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += tegra20-harmony.dtb tegra20-paz00.dtb \
>>>> +	tegra20-seaboard.dtb tegra20-trimslice.dtb tegra20-ventana.dtb \
>>>> +	tegra20-whistler.dtb
>>
>> Hmm. The existing files all have one file per line, which makes
>> adding/removing files have a little less impact; whole lines are
>> added/removed rather than needing to reflow the whole list. Should we
>> apply the same layout here too?
>>
> +1

Are you okay if I change i.MX entries to use CONFIG_ARCH_MXC instead of
per SOC entries? I want to make things more consistent and primarily use
the top level CONFIG_ARCH_xxx values.

Rob
