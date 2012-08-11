From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 11 Aug 2012 11:38:59 +0200
Subject: [PATCH 1/6] ARM: dove: unify clock setup
In-Reply-To: <20120811091255.GA31809@lunn.ch>
References: <1344255815-4457-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1344255815-4457-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <20120811091255.GA31809@lunn.ch>
Message-ID: <50262833.2010601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/2012 11:12 AM, Andrew Lunn wrote:
>> +	/* Ensure tclk is always clocked */
>> +	clk_prepare_enable(tclk);
>>   }
>
> "ticking" would be better than clocked.
>
> Since this is a root fixed clock, is it necessary to prepare_enable()
> it? I think prepare and enable become NOPs in this situation.

Hi Andrew,

yes you are right, it is useless to prepare or enable a fixed rate clk.
I cannot be gated anyway. I'll update the patch and resend soon.

Sebastian
