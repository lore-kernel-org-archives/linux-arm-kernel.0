From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 25 Jun 2010 09:17:51 +0200
Subject: 
In-Reply-To: <4C245238.7010501@eukrea.com>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<4C236EC2.8090506@eukrea.com>
	<20100624175528.GA14838@pengutronix.de>
	<4C23B67C.7090207@eukrea.com>
	<20100625051016.GA31164@pengutronix.de>
	<4C245238.7010501@eukrea.com>
Message-ID: <20100625071751.GB31164@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 25, 2010 at 08:52:40AM +0200, Eric B?nard wrote:
> Le 25/06/2010 07:10, Uwe Kleine-K?nig a ?crit :
>> On Thu, Jun 24, 2010 at 09:48:12PM +0200, Eric B?nard wrote:
>>> How do you manage to merge this simply in order to test it ?
>>> I added your branch as a remote tree, then fetched it, then merged it :
>>> is there any magic git sequence missing here that would help to reduce
>>> the number of conflicts ?
>> No, but these conflicts aren't that hard to resolve.  Check out my
>> imx/for-2.6.36-merged branch.
I'm currently fixing mx3, I missed that there appeared a new machine,
too.  I give you a ping via PM when I'm done.

> most of them may not be hard to resolve but that creates more work to  
> test the patches (and that create more work for Sascha to integrate the  
> patches in its tree). Thanks for your merged branch, I'll test asap.
rebasing creates more work for me, and if Sascha pulls my merge he has
no problems.

>> BTW there are two warnings about 'otg_pdata' and 'usbh2_pdata' defined
>
> should already be fixed in :
> http://git.pengutronix.de/?p=imx/linux-2.6.git;a=commit;h=4ecca63bf70aec86745c4bb631ada8b15e02e855
>
>> but not used with the config I tested.  And it would have been more
>> consistent to name your machine source file mach-eukrea_cpuimx25.c.
>>
> OK so this would require the same renaming for cpuimx27 & 35 as actually  
> its consitent between the 3 boards. Should I send a patch to rename them 
> ?
If you don't, then I will do :-)  I would recommend to wait until Sascha
merged though.

While testing I found another problem.  There are two definitions of
MACH_EUKREA_MBIMXSD_BASEBOARD that conflict.  For me
MACH_EUKREA_MBIMXSD_BASEBOARD doesn't appear in .config if I select
MACH_EUKREA_CPUIMX25.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
