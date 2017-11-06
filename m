From: roy.pledge@nxp.com (Roy Pledge)
Date: Mon, 6 Nov 2017 19:40:06 +0000
Subject: [PATCH v2] staging: fsl-mc: move bus driver out of staging
References: <20170828105405.19552-1-laurentiu.tudor@nxp.com>
 <20170831160430.GB11200@kroah.com> <20171103151711.GA22453@kroah.com>
 <5A006F97.1080409@nxp.com>
Message-ID: <DB6PR04MB29992D82295832B25FC3912D86500@DB6PR04MB2999.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> struct dpaa2_io {
>>           atomic_t refs;
>>
>> That's a kref, please use it instead of trying to roll your own.
>>
>> And even for this, your locking is not correct (i.e. you do not have
>> any), that needs to be fixed so that teardown works correctly.
> 
> I think we can drop this refcount altogether as it's not used. Roy, any
> comment on this?
> 

Yes I think this refcount can be removed.  I'll make a note for when the 
DPIO is moving out of staging but that isn't part of this patchset. 
There are other cleanups needed in DPIO as well. I've been holding off 
on pushing patches for that until the bus driver gets moved to try to 
avoid complex patch dependencies and merge conflict confusion.
