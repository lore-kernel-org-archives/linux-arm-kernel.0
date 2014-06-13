From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 13 Jun 2014 10:38:19 -0600
Subject: [PATCH v8 0/6] efuse driver for Tegra
In-Reply-To: <20140613080052.GN5961@tbergstrom-lnx.Nvidia.com>
References: <1402587400-1544-1-git-send-email-pdeschrijver@nvidia.com>
 <539A26DE.8050609@wwwdotorg.org>
 <20140613072328.GK5961@tbergstrom-lnx.Nvidia.com>
 <20140613080052.GN5961@tbergstrom-lnx.Nvidia.com>
Message-ID: <539B28FB.3000504@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2014 02:00 AM, Peter De Schrijver wrote:
> On Fri, Jun 13, 2014 at 09:23:28AM +0200, Peter De Schrijver wrote:
>> On Fri, Jun 13, 2014 at 12:17:02AM +0200, Stephen Warren wrote:
>>> On 06/12/2014 09:36 AM, Peter De Schrijver wrote:
>>>> This driver allows userspace to read the raw efuse data. Its userspace
>>>> interface is modelled after the sunxi_sid driver which provides similar
>>>> functionality for some Allwinner SoCs. It has been tested on
>>>> Tegra20 (ventana), Tegra30 (beaverboard), Tegra114 (dalmore) and
>>>> Tegra124 (jetson TK1).
>>>
>>> I think this series looks OK now. However, I noticed one change in
>>> behaviour that I don't think is expected:
>>>
>>> The current code/DTB print:
>>> Tegra Revision: A01 SKU: 0 CPU Process: 0 Core Process: 0
>>>
>>> However, applying these patches and booting yields:
>>> Tegra Revision: A01 SKU: 0 CPU Process: 1 Core Process: 1
>>
>> On which board/SoC?

Oops. Venice2/Tegra124.

> I'm guessing you're running on Tegra124 because the silicon revision reported
> is A01. If this is correct then, the current output is bogus. The current fuse
> code does not have any Tegra124 support and will fall back to reading the same
> fuse bits as on Tegra20 to determine the process IDs. You should get a warning
> message though: 'Tegra: unknown chip id'

Ah yes:
Tegra: unknown chip id 64

OK, so there's nothing wrong with this change in behaviour:-)

If that error message still exists, it might be nice if that value was
printed in hex since that's what the data sheets and code usually
represents it as. That can certainly be a followon patch though; no need
for a respin.
