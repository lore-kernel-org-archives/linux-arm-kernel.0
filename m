From: ralf@ramses-pyramidenbau.de (Ralf Ramsauer)
Date: Fri, 15 Jul 2016 11:37:30 +0200
Subject: [PATCH] ARM: tegra: fix erroneous address in dts
In-Reply-To: <20160714220218.GB4205@mithrandir.ba.sec>
References: <1468514937-23250-1-git-send-email-ralf@ramses-pyramidenbau.de>
 <20160714220218.GB4205@mithrandir.ba.sec>
Message-ID: <8a8ccb29-ba73-f29f-2b57-5c1d91e13bf7@ramses-pyramidenbau.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2016 12:02 AM, Thierry Reding wrote:
> On Thu, Jul 14, 2016 at 06:48:57PM +0200, Ralf Ramsauer wrote:
>> c90bb7b enabled the high speed UARTs of the Jetson TK1. The address
>> specification inside the dts is wrong. Fix it and use the correct
>> address.
>>
>> Fixes: c90bb7b9b9 ("ARM: tegra: Add high speed UARTs to Jetson TK1 device tree")
>> Signed-off-by: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
>> ---
>>  arch/arm/boot/dts/tegra124-jetson-tk1.dts | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> These addresses are correct. The 0, prefix was dropped from the unit
> address in commit b5896f67ab3c ("ARM: tegra: Remove commas from unit
> addresses on Tegra124").
> 
> What's the problem that you're seeing? What's not working for you?
I cannot find b5896f67ab3c neither in swarren's tree nor in linux
upstream. But there's d0bc5aaf890 in swarren's linux-tegra tree that
matches your described changes and was committed on 1st of July. But
this patch is not upstream yet, while the other patch is.

Have a look at mainline tegra124-jetson-tk1.dts, there the addresses are
erroneous as they still use the 0, annotation. And I just realised, that
somehow, upstream patch c90bb7b slightly differs from my initial patch
[1] on the mailing list.

  Ralf

[1] http://permalink.gmane.org/gmane.linux.ports.tegra/24779
> 
> Thierry
> 

-- 
Ralf Ramsauer
PGP: 0x8F10049B

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160715/dbf98a2c/attachment.sig>
