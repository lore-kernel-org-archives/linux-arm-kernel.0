From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 22 Jan 2013 15:26:56 +0100
Subject: [PATCH V2  0/5] W1: Support onewire master on i.MX53
In-Reply-To: <20130122140941.GA4920@S2101-09.ap.freescale.net>
References: <20130116145749.24249.678.stgit@localhost>
 <20130122082712.GJ1906@pengutronix.de>
 <20130122140941.GA4920@S2101-09.ap.freescale.net>
Message-ID: <50FEA1B0.7060600@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/01/13 15:09, Shawn Guo wrote:
> On Tue, Jan 22, 2013 at 09:27:12AM +0100, Sascha Hauer wrote:
>> On Wed, Jan 16, 2013 at 03:57:49PM +0100, Martin Fuzzey wrote:
>>> W1: Support onewire master on i.MX53
>>> 	* Add device tree and pinctrl support to the MXC master driver
>>> 	* Convert to use devm_
>>> 	* Add i.MX53 clocks
>>> 	* Add i.MX53 device tree entries
>>>
>>> Changes since V1
>>> * Applied comments from Sascha Hauer:
>>> 	* Move patch converting driver to devm_ before the one adding devm_ based pinctrl
>>> 	* Fix existing unbalanced clk_prepare_enable/clk_disable_unprepare
>>> 	in probe error path
>>>
>>> * Place DT patch last since it includes pinctrls for driver.
>> This looks good now.
>>
>> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
>>
>> You might have to send this again in two series, one for the w1
>> maintainer and one for arm-soc. Both series should be sufficiently
>> orthogonal.
>>
> Evgeniy has already ACK-ed the v1 series, so maybe he does not see any
> problem with the whole series going through one tree.  In that case,
> we may just have it go via arm-soc tree?  Otherwise, please let us
> know, Evgeniy.
>
> Shawn
>
There was also the question raised by Mark Rutland on the DT compatible
string.
Currently this is "fsl,imx21-owire" but Mark thought "fsl,imx21-w1" to
be better.

Do I take your Acks to mean "fsl,imx21-owire" is OK?
I should add a Documentation file for the DT binding too but I was
waiting for consensus
on the compatible string first.

Martin
