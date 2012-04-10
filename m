From: robherring2@gmail.com (Rob Herring)
Date: Tue, 10 Apr 2012 07:57:12 -0500
Subject: [PATCH 3/4] clk: add DT clock binding support
In-Reply-To: <CAOMZO5AKmnQRo4_3GVDSMUc0fMZ5orwvZSxjXfn6m-5Boew04A@mail.gmail.com>
References: <1334003101-17274-1-git-send-email-robherring2@gmail.com>
 <1334003101-17274-4-git-send-email-robherring2@gmail.com>
 <CAOMZO5AKmnQRo4_3GVDSMUc0fMZ5orwvZSxjXfn6m-5Boew04A@mail.gmail.com>
Message-ID: <4F842E28.8060609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2012 11:27 PM, Fabio Estevam wrote:
> On Mon, Apr 9, 2012 at 5:25 PM, Rob Herring <robherring2@gmail.com> wrote:
>> From: Grant Likely <grant.likely@secretlab.ca>
>>
>> Based on work 1st by Ben Herrenschmidt and Jeremy Kerr, then by Grant
>> Likely, this patch adds support to clk_get to allow drivers to retrieve
>> clock data from the device tree.
>>
>> Platforms scan for clocks in DT with of_clk_init and a match table, and
>> the register a provider through of_clk_add_provider. The provider's
>> clk_src_get function will be called when a device references the
>> provider's OF node for a clock reference.
>>
>> v5 (Rob Herring):
>>    - Move from drivers/of into common clock subsystem
>>    - Squashed "dt/clock: add a simple provider get function" and
>>      "dt/clock: add function to get parent clock name"
>>    - Rebase to 3.4-rc1
>>    - Drop CONFIG_OF_CLOCK and just use CONFIG_OF
>>    - Add missing EXPORT_SYMBOL to various functions
>>    - s/clock-output-name/clock-output-names/
>>    - Define that fixed-clock binding is a single output
> 
> The patch history should go below the --- line,

No, depends who you ask, and Grant is very much in favor of retaining
the history.

Rob
