From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Mon, 31 May 2010 10:14:02 +0900
Subject: [PATCH v2 1/5] ARM: SAMSUNG: Add keypad device support
In-Reply-To: <20100530085224.GA28188@core.coreip.homeip.net>
References: <1275188784-23395-1-git-send-email-jy0922.shim@samsung.com>
	<201005300542.37715.marek.vasut@gmail.com>
	<20100530085224.GA28188@core.coreip.homeip.net>
Message-ID: <4C030D5A.1060609@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/30/2010 5:52 PM, Dmitry Torokhov wrote:
> On Sun, May 30, 2010 at 05:42:37AM +0200, Marek Vasut wrote:
>> Dne Ne 30. kv?tna 2010 05:06:20 Joonyoung Shim napsal(a):
>>> + */
>>> +struct samsung_kp_platdata {
>>> +	const struct matrix_keymap_data	*keymap_data;
>>> +	unsigned int		rows;
>>> +	unsigned int		cols;
>>> +	unsigned int		rep;
>> I don't know, maybe using uint32_t here? On ARM, it doesn't matter so far as int 
>> will be always 32bit, but maybe we should just type the variables well ?
>>
>> Guys, what do you think ?
>>
> 
> I think unsigned int is fine, we do not care about particular size, just
> need "big enough". I'd change 'rep' to be a boolean though.
> 

I will modify 'rep' to unsinged int rep:1;
