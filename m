From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 7 Dec 2012 16:10:04 +0530
Subject: [PATCH v3 1/3] mtd: nand: omap2: Update nerrors using ecc.strength
In-Reply-To: <518397C60809E147AF5323E0420B992E3EA1139B@DBDE01.ent.ti.com>
References: <1354189595-12784-1-git-send-email-avinashphilip@ti.com>
 <1354189595-12784-2-git-send-email-avinashphilip@ti.com>
 <50BF3819.9010200@ti.com>
 <518397C60809E147AF5323E0420B992E3EA1139B@DBDE01.ent.ti.com>
Message-ID: <50C1C784.4040209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/5/2012 6:13 PM, Philip, Avinash wrote:
> On Wed, Dec 05, 2012 at 17:33:37, Nori, Sekhar wrote:
>> Hi Avinash,
>>
>> On 11/29/2012 5:16 PM, Philip, Avinash wrote:
>>> Update number of errors using nand ecc strength.
>>> Also add macro definitions BCH8_ERROR_MAX & BCH4_ERROR_MAX
>>
>> Can you please describe why the original method of setting nerrors was
>> incorrect? Was it causing any issues in any particular configuration?
> 
> It affects the reusability of the code. For example BCH8 with AM335x RBL 
> compatibility requires  14 bytes instead of 13 byte. So setting nerrors
> with
> 	nerrors = (info->nand.ecc.bytes == 13) ? 8 : 4;
> will break am335x RBL compatibility.

This should be summarized in the patch description so the motivation is
clear to those who read the history later.

Thanks,
Sekhar
