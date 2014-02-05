From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed, 05 Feb 2014 14:53:25 +0100
Subject: [RFC PATCH 1/9] mtd: nand: retrieve ECC requirements from Hynix
 READ ID byte 4
In-Reply-To: <20140123014906.GY8919@ld-irv-0074>
References: <1389190924-26226-1-git-send-email-b.brezillon@overkiz.com>
 <1389190924-26226-2-git-send-email-b.brezillon@overkiz.com>
 <20140123014906.GY8919@ld-irv-0074>
Message-ID: <52F24255.9030603@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Brian,

On 23/01/2014 02:49, Brian Norris wrote:
> + Huang
>
> Hi Boris,
>
> On Wed, Jan 08, 2014 at 03:21:56PM +0100, Boris BREZILLON wrote:
>> The Hynix nand flashes store their ECC requirements in byte 4 of its id
>> (returned on READ ID command).
>>
>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> I haven't verified yet (perhaps Huang can confirm?), but this may be
> similar to a patch Huang submitted recently. In his case, we found that
> this table is actually quite unreliable and is likely hard to maintain.

Indeed (as stated in this thread 
http://comments.gmane.org/gmane.linux.drivers.mtd/50252).
I'll remove this patch from the next version of this series and make use 
of the
nand-ecc-strength /nand-ecc-size DT properties instead.

Thanks.

Best Regards,

Boris
>
> Why do you need this ECC information, for my reference?
>
> Brian
