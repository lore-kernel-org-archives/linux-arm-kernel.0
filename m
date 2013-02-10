From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Mon, 11 Feb 2013 01:04:16 +0530
Subject: [PATCH v5 07/45] CPU hotplug: Provide APIs to prevent CPU offline
 from atomic context
In-Reply-To: <87mwvsuw68.fsf@sejong.aot.lge.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073446.13822.39253.stgit@srivatsabhat.in.ibm.com>
 <87mwvsuw68.fsf@sejong.aot.lge.com>
Message-ID: <5117F638.9070700@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Namhyung,

On 01/29/2013 03:51 PM, Namhyung Kim wrote:
> Hi Srivatsa,
> 
> On Tue, 22 Jan 2013 13:04:54 +0530, Srivatsa S. Bhat wrote:
>> @@ -246,15 +291,21 @@ struct take_cpu_down_param {
>>  static int __ref take_cpu_down(void *_param)
>>  {
>>  	struct take_cpu_down_param *param = _param;
>> -	int err;
>> +	unsigned long flags;
>> +	int err = 0;
> 
> It seems no need to set 'err' to 0.
>

Sorry for the late reply. This mail got buried in my inbox and
I hadn't noticed it until now.. :-(

I'll remove the unnecessary initialization. Thank you!

Regards,
Srivatsa S. Bhat
