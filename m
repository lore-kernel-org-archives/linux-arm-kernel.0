From: aletes.xgr@gmail.com (Alexandre Pereira da Silva)
Date: Wed, 27 Jun 2012 09:26:48 -0300
Subject: [PATCH v7] MTD: LPC32xx SLC NAND driver
In-Reply-To: <4FEAF90B.5030809@antcom.de>
References: <1339064536-20553-1-git-send-email-stigge@antcom.de>
 <1340794007.29342.50.camel@sauron.fi.intel.com>
 <4FEAF90B.5030809@antcom.de>
Message-ID: <CAAAP30HemOV9svhVghLTWfZe95=P3CT-H7UsQ=xY6rC8=AfBsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2012 at 9:14 AM, Roland Stigge <stigge@antcom.de> wrote:
> On 06/27/2012 12:46 PM, Artem Bityutskiy wrote:
>> On Thu, 2012-06-07 at 12:22 +0200, Roland Stigge wrote:
>>> This patch adds support for the SLC NAND controller inside the
>>> LPC32xx SoC.
>>>
>>> Signed-off-by: Roland Stigge <stigge@antcom.de>
>>
>> Now the write_page and write_page_raw functions return an error
>> code, see this commit in the l2 tree:
>>
>> http://git.infradead.org/users/dedekind/l2-mtd.git/commit/49c8d9ab3b70732665249f2d993f734378ebbba9
>>
>> ?I've amended your SLC driver, see below the diff. But I think it
>> could return the real return code becuse it can fail - could you
>> please take a look and send an incremental patch?
>>
>> Please, base your work on top of the l2-mtd tree:
>> git://git.infradead.org/users/dedekind/l2-mtd.git
>
> Thanks for the note! I'm sending an incremental patch. There was
> actually only one place in the two functions that could fail (return
> code of lpc32xx_xfer()).

I think it's best in case of *_raw to use nand base default functions,
like in the MLC patch.
