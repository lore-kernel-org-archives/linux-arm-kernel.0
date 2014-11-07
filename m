From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 07 Nov 2014 09:41:19 -0300
Subject: [PATCH 1/2] thermal: armada: Remove support for A375-Z1 SoC
In-Reply-To: <20141107032619.GD3698@titan.lakedaemon.net>
References: <1415116839-4323-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1415116839-4323-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141107032619.GD3698@titan.lakedaemon.net>
Message-ID: <545CBDEF.6050502@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2014 12:26 AM, Jason Cooper wrote:
> Ezequiel,
> 
> On Tue, Nov 04, 2014 at 01:00:38PM -0300, Ezequiel Garcia wrote:
>> The Armada 375 Z1 SoC revision is no longer supported. This commit
>> removes the quirk needed for the thermal sensor.
>>
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>> ---
>>  .../devicetree/bindings/thermal/armada-thermal.txt   |  8 --------
>>  drivers/thermal/armada_thermal.c                     | 20 --------------------
>>  2 files changed, 28 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
>> index 4cf0249..4698e0e 100644
>> --- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
>> @@ -5,17 +5,9 @@ Required properties:
>>  - compatible:	Should be set to one of the following:
>>  		marvell,armada370-thermal
>>  		marvell,armada375-thermal
>> -		marvell,armada375-z1-thermal
>>  		marvell,armada380-thermal
>>  		marvell,armadaxp-thermal
>>  
>> -		Note: As the name suggests, "marvell,armada375-z1-thermal"
>> -		applies for the SoC Z1 stepping only. On such stepping
>> -		some quirks need to be done and the register offset differs
>> -		from the one in the A0 stepping.
>> -		The operating system may auto-detect the SoC stepping and
>> -		update the compatible and register offsets at runtime.
>> -
>>  - reg:		Device's register space.
>>  		Two entries are expected, see the examples below.
>>  		The first one is required for the sensor register;
> 
> I've no problem with removing support for the z1 stepping from the
> kernel.  However, I don't think we should erase it from binding docs.
> I'm not sure what the DT maintainers think is the appropriate action
> here, but I'm thinking we could add a 'Deprecated' section at the end of
> the doc and move these hunks there.  With a little rewording of course.
> 
> I'm primarily concerned about users with older dtbs looking to upgrade,
> "Hey, wtf is marvell,armada375-z1-thermal?  I looked in the binding docs
> and there's nothing there, do I replace it with marvell,armada375-thermal?"
> 

We can do that if you think it's really useful. However, I think we've
designed this so *nobody* would actually have to put the z1 compatible
string. The mvebu quirk (tries) to auto-detect it from the revision
register and hot fix the compatible string.

Moreover, I'm not at all sure *anyone* would have a Z1 board except
early developers like us. Am I being too naive here?

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141107/72590425/attachment.sig>
