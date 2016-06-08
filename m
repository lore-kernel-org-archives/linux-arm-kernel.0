From: tthayer@opensource.altera.com (Thor Thayer)
Date: Wed, 8 Jun 2016 08:49:45 -0500
Subject: [PATCHv2 2/5] EDAC, altera: ECC Manager IRQ controller support
In-Reply-To: <20160608090005.GB26590@pd.tnic>
References: <1464193783-5071-3-git-send-email-tthayer@opensource.altera.com>
 <1465331757-10227-1-git-send-email-tthayer@opensource.altera.com>
 <20160608090005.GB26590@pd.tnic>
Message-ID: <57582279.60400@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/08/2016 04:00 AM, Borislav Petkov wrote:
> On Tue, Jun 07, 2016 at 03:35:57PM -0500, tthayer at opensource.altera.com wrote:
>> From: Thor Thayer <tthayer@opensource.altera.com>
>>
>> To better support child devices, the ECC manager needs to be
>> implemented as an IRQ controller.
>>
>> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
>> ---
>> v2  Update with cleanup/improvements from maintainer.
>> ---

<snip>

>> +	} else {
>> +		WARN_ON(1);
>>   	}
>> -	return IRQ_HANDLED;
>> +	return IRQ_NONE;
>>   }
>
> Simplified a bit more while applying. Ok?
>
>
Yes, yours is cleaner, Thanks!

<snip>

> +		return IRQ_HANDLED;
>   	}
> -	return IRQ_HANDLED;
> +
> +	WARN_ON(1);
> +
> +	return IRQ_NONE;
>   }
<snip>
