From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 13 Aug 2014 15:21:29 +0200
Subject: [PATCH 1/2] spi: xilinx: Remove .owner field for driver
In-Reply-To: <20140813123343.GR17528@sirena.org.uk>
References: <d35c656e50eb7cc951499f13ef339d6aa1a23deb.1407930755.git.michal.simek@xilinx.com>
 <20140813123343.GR17528@sirena.org.uk>
Message-ID: <b172f93e-b2fb-4cf4-a2de-d2ca62cdb83f@BN1BFFO11FD016.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13/2014 02:33 PM, Mark Brown wrote:
> On Wed, Aug 13, 2014 at 01:52:39PM +0200, Michal Simek wrote:
>> There is no need to init .owner field.
>>
>> Based on the patch from Peter Griffin <peter.griffin@linaro.org>
>> "mmc: remove .owner field for drivers using module_platform_driver"
>>
>> This patch removes the superflous .owner field for drivers which
>> use the module_platform_driver API, as this is overriden in
>> platform_driver_register anyway."
> 
> Would it not be better to do this as a tree wide or at least subsystem
> wide sweep with something like cocinelle?

Feel free to use cocinelle for fixing this everywhere.
For me was just easier to fix all xilinx drivers to ensure
that none else will copy it for new drivers.

Thanks,
Michal



-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140813/874bcdc0/attachment-0001.sig>
