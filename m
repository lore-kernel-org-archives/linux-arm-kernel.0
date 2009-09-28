From: jernej.turnsek@gmail.com (Jernej Turnsek)
Date: Mon, 28 Sep 2009 10:56:40 +0200
Subject: Problem with mxc_nand driver
In-Reply-To: <4AC0682D.6000907@eukrea.com>
References: <a57e67db0909272341k59d4cda6pde85ff7425a75c8f@mail.gmail.com>
	<4AC0682D.6000907@eukrea.com>
Message-ID: <a57e67db0909280156x686f0d26u397dc6397fd0b3a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

are you using HW ECC on your chip? I suspect that HW ECC is writting
something into space provided for the clean markers. I will
investigate to.

BR,
Jernej

On Mon, Sep 28, 2009 at 9:39 AM, Eric B?nard <eric@eukrea.com> wrote:
> Hi Jernej,
>
> Jernej Turnsek a ?crit :
>>
>> I found a bit strange to set badblock_pattern parameter to
>> smallpage_memorybased although pagesize is 2k. Or am I wrong?
>>
>> When I revert this patch, everything works as it should.
>>
> on my iMX27 board, I have the opposite case with a MT29F4G08ABC : it works
> only with this patch. This code came from the original Freescale BSP. I'm
> going to investigate more on this problem on my board and let you know.
>
> Eric
>
