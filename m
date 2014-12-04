From: Andrew.Jackson@arm.com (Andrew Jackson)
Date: Thu, 04 Dec 2014 09:00:35 +0000
Subject: [PATCH 2/5] ASoC: dwc: Don't allow negative use counts
In-Reply-To: <20141203172526.GC7712@sirena.org.uk>
References: <547F3C9F.8080102@arm.com> <20141203172526.GC7712@sirena.org.uk>
Message-ID: <548022B3.8050105@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/14 17:25, Mark Brown wrote:
> On Wed, Dec 03, 2014 at 04:38:55PM +0000, Andrew Jackson wrote:
> 
>>  	case SNDRV_PCM_TRIGGER_STOP:
>>  	case SNDRV_PCM_TRIGGER_SUSPEND:
>>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>> -		dev->active--;
>> +		if (dev->active > 0)
>> +			dev->active--;
> 
> How is this triggering - this sounds like you're papering over some
> other bug somewhere?
> 

When I looked at the code paths I couldn't convince myself that STOP wouldn't be called more than once.  Then actuve would be negative and the device might not be restartable.  I didn't have a problem per se, it was just that it seemed to be something of a loophole.

   Andrew
